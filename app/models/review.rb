class Review < ActiveRecord::Base
  belongs_to :resource, counter_cache: true
  belongs_to :user, counter_cache: true
  with_options dependent: :destroy do |assoc|
    assoc.has_many :comments, inverse_of: :review
    assoc.has_many :likes, as: :likeable
  end

  validates :user_id, :resource_id, presence: true
  validates :content, length: {
    minimum: 50,
    tokenizer: lambda { |str| str.scan(/\w+/) },
    too_short: "must have at least %{count} words"
  }

  def get_rated_value
  	## fixed
    ## We can move this method to Review model
    resource_obj = resource
    user_obj = user
    if user_obj.ratings.find_by(resource_id: resource_obj.id)
      user_obj.ratings.find_by(resource_id: resource_obj.id).value.round(2)
    end
  end

  def latest_comment
    comments.order('updated_at').last
  end
end