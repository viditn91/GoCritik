module ReviewsHelper
  def get_rated_value(review)
    ## We can move this method to Review model
    resource_obj = review.resource
    user_obj = review.user
    if user_obj.ratings.find_by(resource_id: resource_obj.id)
      user_obj.ratings.find_by(resource_id: resource_obj.id).value.round(2)
    else
    	0.round(2)
    end
  end
end