class Admin::FieldsValuesController < Admin::BaseController

	def new
		@fields_values = FieldsValue.new
	end

end
