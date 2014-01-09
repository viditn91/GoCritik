class FieldsValuesController < ApplicationController
  
  def new
    @fields_values = FieldsValue.new
  end
  
end