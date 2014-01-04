class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :photo, :styles => {
  	  :tiny => "50x50",
      :thumb => "60x60",
      :small => "90x90",
      :profile => "200x200",
      :full => "400"
  }, :default_url => "/images/default/:style/missing.jpg"
end