class ReviewsController < ApplicationController
  def new; end

  def create
    @review = current_user.reviews.build review_params

    if @review.save
      respond_to do |f|
        f.html{redirect_to @review.product}
        f.js
      end
    else
      flash[:danger] = t "review_fails"
      redirect_to @review.product
    end
  end

  private

  def review_params
    params.require(:review).permit Review::REVIEW_PARAMS
  end
end
