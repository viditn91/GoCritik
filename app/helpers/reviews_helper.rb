module ReviewsHelper

  def my_review?(review)
    review.user == current_user
  end

end