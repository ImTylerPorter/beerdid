class Beer < ActiveRecord::Base
	belongs_to :admin
	has_many :reviews

	has_attached_file :image, styles: { medium: "600x400#" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  	extend FriendlyId
  	friendly_id :name, use: :slugged

  	def should_generate_new_friendly_id?
		slug.blank? || title_changed?
	end
end
