class ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @movie = Movie.find(review_params[:movie_id])
    @review = current_user.reviews.build(review_params)
    @review.save
    @reviews = @movie.reviews
    @support = Supports::Movie.new
  end

  def destroy
    @review = Review.find(params[:id])
    @movie = @review.movie
    @review.destroy
    @reviews = @movie.reviews
  end

  private

  def review_params
    params.require(:review).permit(:rate, :movie_id)
  end
end
