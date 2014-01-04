class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :picture, as: :imageable, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  before_create :create_associated_picture

  def create_associated_picture
    build_picture
  end

end