class Field < ActiveRecord::Base

  serialize :options

  scope :searchable, -> { where(searchable: true) }
  scope :sortable,   -> { where(sortable: true) }

  has_many :fields_values

  # before_validation :check_for_form_tempering
  before_destroy :ensure_not_referenced_by_resource
  before_update :check_for_updated_fields
  # callbacks for delta-indexing resource once a field-value is changed corresponding to a searchable field
  after_save :set_resource_delta_flag
  after_update :set_resource_delta_flag
  after_destroy :set_resource_delta_flag
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validate :field_name_with_resource_attributes
  validates :input_type, inclusion: { in: InputTypeHash.map{ |hash| hash[:name] }, 
    message: "%{value} is not a valid Input-Type" }
  validates :type, inclusion: { in: FieldTypeArray.map{ |display_text, type| type }, 
    message: "%{value} is not a valid Field-Type" }
  validates_each :required, :unique, :searchable, :sortable do |record, attr, value|
    record.errors[:base] << "#{ attr.capitalize } Field must be true or false" unless value.in? [true, false]
  end
  # validates_each :required, :unique, :searchable, :sortable do |record, attr, value|
  #   value_input = record.send("#{ attr }_before_type_cast".to_sym)
  #   record.errors[:base] << "'#{ value_input }' is not a valid value for #{ attr.capitalize } Field" unless value_input.to_s.in? ['true', 'false', '1', '0']
  # end
  # liquid template requirement
  liquid_methods :id, :name


  def get_regexp
    InputTypeHash.each do |hash|
      return hash[:regexp] if hash[:name] == input_type
    end
  end

  def get_disp_text(value)
    options.each do |hash|
      return hash[:text] if hash[:value] == value.to_s
    end
    nil
  end

private


  def field_name_with_resource_attributes
    errors.add(:name, 'is already taken.') if name =~ /^(name|description)$/i
  end

  def ensure_not_referenced_by_resource
    raise Exceptions::RequiredFieldError.new "Field Cannot be deleted. Records depend on this field" if field_exists_in_resource?
  end

  def check_for_updated_fields
    hash = changes
    if hash.keys.include?('input_type') || hash.keys.include?('type')
      raise Exceptions::RequiredFieldError.new "Field-Type/Input-Type Cannot be updated. Records depend on this field" if field_exists_in_resource?
    end
  end

  def field_exists_in_resource?
    fields_values.present?
  end

  def set_resource_delta_flag
    if searchable_changed?
      fields_values.each do |field_value|
        resource_obj = field_value.resource
        resource_obj.delta = true
        resource_obj.save(validate: false)
      end
    end
  end

end