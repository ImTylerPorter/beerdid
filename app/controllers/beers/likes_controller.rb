class Beers::LikesController < ApplicationController
 	before_action :authenticate_admin!
 	before_action :set_beer

	def create
		@beer.likes.where(admin_id: current_admin.id).first_or_create

		respond_to do |format|
	      format.html { redirect_to @beer }
	      format.js
		end
	end

	def destroy
		@beer.likes.where(admin_id: current_admin.id).destroy_all

		respond_to do |format|
		      format.html { redirect_to @beer }
		      format.js
		end
	end

	private

	def set_beer 
		@beer = Beer.friendly.find(params[:beer_id])
	end

end