class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def prepare_meta_tags(options={})

    site        = "BEERDID.COM"
    title       = [controller_name, action_name].join(" ")
    description = "Two men, living in Nashville, TN, with exquisite facial hair. Both of us have a love for the craft, and art form that is Beer."
    image       = options[:image] || ActionController::Base.helpers.asset_path("imgpreview.jpg", type: :image)  
    current_url = request.url

    # Let's prepare a nice set of defaults

    defaults = {
      site:        "beerdid.com",
      title:       title,
      image:       ActionController::Base.helpers.asset_path("imgpreview.jpg", type: :image),
      description: "Two men, living in Nashville, TN, with exquisite facial hair. Both of us have a love for the craft, and art form that is Beer.",
      keywords:    %w[beer beerdid craftbeer Nashville ],
      twitter:     {site_name: site,
                    site: '@beerdid',
                    card: "summary",
                    description: description,
                    image: image},
      og:          {url: current_url,
                    site_name: site,
                    title: "BEERDID",
                    image: image,
                    description: description,
                    type: 'website'}
    }


    options.reverse_merge!(defaults)


    set_meta_tags options

  end

      private

      def configure_permitted_parameters
         devise_parameter_sanitizer.for(:sign_up){ |u| u.permit(:name, :user_name, :email, :password, :password_confirmation, :update_without_password, :current_password, :first_name, :last_name, :terms, :image)}        
         devise_parameter_sanitizer.for(:account_update){ |u| u.permit(:name, :user_name, :email, :password, :password_confirmation, :update_without_password, :current_password, :first_name, :last_name, :terms, :image) }          
      end
end
