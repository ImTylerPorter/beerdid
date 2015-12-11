class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :beers
  has_many :reviews, dependent: :destroy
  has_many :likes
  has_many :pages
  # validates :terms, :acceptance => {:accept => true} , on: :create, allow_nil: false

  def likes?(beer)
  	beer.likes.where(admin_id: id).any?
  end

  def avatar_url
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}"
  end

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |admin|
    admin.provider = auth.provider 
    admin.uid      = auth.uid
    admin.user_name     = auth.info.name
    admin.email = auth.info.email
    admin.image = auth.info.image
    admin.save
  end
end

  def self.new_with_session(params, session)
    if session["devise.admin_attributes"]
      new(session["devise.admin_attributes"], without_protection: true) do |admin|
        admin.attributes = params 
        admin.valid?
      end
    else
      super
    end
  end

  def confirmation_required?
    super && email.present?
  end

  def password_required? 
    super && provider.blank? 
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

end
