module Manager
  class ReviewsController < Manager::BaseController
    skip_before_action :verify_authenticity_token
    def index
      @reviews = Review.all.page(params[:page]).per Settings.per_page_reviews
    end

    def destroy
      @review = Review.find params[:id]
      @review.destroy
      flash[:success] = "Review delete"
      redirect_to manager_reviews_path
    end
  end
end
