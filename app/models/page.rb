class Page < ActiveRecord::Base
	belongs_to :admin

	extend FriendlyId
  	friendly_id :name, use: :slugged

  	def should_generate_new_friendly_id?
		slug.blank? || name_changed?
	end
end
