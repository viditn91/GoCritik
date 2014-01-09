class Field < ActiveRecord::Base

  serialize :options
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validate :field_name_with_resource_attributes

  before_destroy :ensure_not_referenced_by_resource
  before_update :check_for_updated_fields

  def get_regexp
    InputTypeHash.each do |hash|
      return hash[:regexp] if hash[:name] == input_type
    end
  end

protected

  def field_name_with_resource_attributes
    errors.add(:name, 'is already taken.') if name =~ /^(name|description)$/i
  end

  def ensure_not_referenced_by_resource
    raise Exceptions::RequiredFieldError.new "Field Cannot be deleted. Records depend on this field" if field_exists_in_resource?
  end

  def check_for_updated_fields
    hash = self.changes
    if hash.keys.include?('input_type') || hash.keys.include?('type')
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