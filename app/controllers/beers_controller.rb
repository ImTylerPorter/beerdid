class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy, :like]
  before_action :authenticate_admin!, except: [:index, :show, :search, :sitemap]

  def search
    if params[:search].present?
      @beers = Beer.search(params[:search])
    else
      @beers = Beer.all
    end
  end

  def index
    @beers = Beer.order("created_at desc").paginate(page: params[:page], per_page: 9)
        prepare_meta_tags title: "Beers", 
              description: "Tasted beers by Beerdid",
              og: {
              title: "Beers",
              description: "Tasted beers by Beerdid",
            },
              twitter: {
              description: "Tasted beers by Beerdid"
            }
  end

  def show
    @reviews = Review.where(beer_id: @beer.id).order("created_at DESC")
    prepare_meta_tags(title: @beer.name,
                      description: @beer.description.truncate(120),
                      image: @beer.image.url(:original),
                      og: {
                          title: @beer.name,
                          description: @beer.description.truncate(120),
                          image: @beer.image.url(:original)
                      },
                      twitter: {
                          description: @beer.description.truncate(120),
                          image: @beer.image.url(:original)
                      }
            )

      @avg_review = @reviews.average(:rating)
    
  end

  def new
    if current_admin.admin?
      @beer = current_admin.beers.build
    else
      redirect_to root_path
    end
  end

  def edit
    if current_admin.admin?
    else
      redirect_to root_path
    end
  end

  def create
    @beer = current_admin.beers.build(beer_params)

    respond_to do |format|
      if @beer.save
        format.html { redirect_to @beer, notice: 'Beer was successfully created.' }
        format.json { render :show, status: :created, location: @beer }
      else
        format.html { render :new }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @beer.update(beer_params) 
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { render :show, status: :ok, location: @beer }
      else
        format.html { render :edit }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if current_admin.admin?
      @beer.destroy
      respond_to do |format|
        format.html { redirect_to beers_url, notice: 'Beer was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path
    end
  end

  def like
    if @beer.liked_by current_admin
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def sitemap
      @beers = Beer.all
      @pages = Page.all
      respond_to do |format|
          format.xml { render layout: false }
      end
  end


  private
    def set_beer
      @beer = Beer.friendly.find(params[:id])
    end

    def beer_params
      params.require(:beer).permit(:name, :description, :style, :abv, :ibu, :brewery, :location, :image, :slug, :youtube_url, :rate_beer, :beer_advocate)
    end
end
