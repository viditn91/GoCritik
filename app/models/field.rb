class Field < ActiveRecord::Base	
  serialize :options
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end