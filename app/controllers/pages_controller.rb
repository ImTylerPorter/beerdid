class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:show,:edit, :update, :destroy]

  def index
    @pages = Page.order("created_at desc")
  end

  def show
    prepare_meta_tags(title: @page.name,
                  description: @page.content.truncate(120),
                  og: {
                      title: @page.name,
                      description: @page.content.truncate(120),
                  },
                  twitter: {
                      description: @page.content.truncate(120),
                  }
        )
  end

  def new

    if current_admin.admin?
      @page = Page.new 
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to root_path, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_page
      @page = Page.friendly.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:name, :slug, :content)
    end
end
