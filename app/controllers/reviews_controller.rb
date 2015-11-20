class ReviewsController < ApplicationController
  before_action :set_beer
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @review.admin_id = current_admin.id
    @review.beer_id = @beer.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to @beer, notice: 'Review was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to beer_path notice: 'Review was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to root, notice: 'Review was successfully destroyed.' }
    end
  end

  private
    def set_beer
      @beer = Beer.friendly.find(params[:beer_id])
    end

    def set_review
      @review = Review.find(params[:id])
    end


    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
