module RatingsHelper

  def calc_avg_rating(resource)
    if @resource.ratings.present?
      rating_array = @resource.ratings.pluck(:value)
      (rating_array.inject{ |sum, el| sum + el }.to_f / rating_array.size).round(2)
    else
      0.00
    end
  end

end