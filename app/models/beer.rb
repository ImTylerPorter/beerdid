class Beer < ActiveRecord::Base
	belongs_to :admin
	has_many :reviews
	has_many :likes
	searchkick

	has_attached_file :image, styles: { medium: "600x400#" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  	extend FriendlyId
  	friendly_id :name, use: :slugged

  	def should_generate_new_friendly_id?
		slug.blank? || name_changed?
	end

	def self.get_previous_beer(current_beer)
    	Beer.where("beers.id < ? ", current_beer.id).order('created_at asc').last
    end

	def self.get_next_beer(current_beer)
        Beer.where("beers.id > ? ", current_beer.id).order('created_at asc').first
    end

    

end
