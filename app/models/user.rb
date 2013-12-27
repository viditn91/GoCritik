class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
