class User < ActiveRecord::Base
  with_options dependent: :destroy do |assoc|
    assoc.has_many :reviews
    assoc.has_many :ratings
    assoc.has_many :likes
    assoc.has_one :picture, as: :imageable
  end

  validates :first_name, :last_name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  before_create :create_associated_picture

private
  def create_associated_picture
    build_picture
  end

end