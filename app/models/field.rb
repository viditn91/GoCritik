class Field < ActiveRecord::Base

  serialize :options
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  before_destroy :ensure_not_referenced_by_resource
  before_update :check_for_updated_fields

protected
  
  def ensure_not_referenced_by_resource
    raise Exceptions::RequiredFieldError.new "Field Cannot be deleted. Records depend on this field" if field_exists_in_resource?
  end

  def check_for_updated_fields
    hash = self.changes
    if hash.keys.include?('input_type') || hash.keys.include?('field_type')
      raise Exceptions::RequiredFieldError.new "Field-Type/Input-Type Cannot be updated. Records depend on this field" if field_exists_in_resource?
    end
  end

  def field_exists_in_resource?
    FieldsValue.pluck(:field_id).each do |field_id|
      return true if field_id == self.id
    end
    false
  end

end