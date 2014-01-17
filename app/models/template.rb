class Template < ActiveRecord::Base
 validates :controller, :action, :view_element, presence: true
end