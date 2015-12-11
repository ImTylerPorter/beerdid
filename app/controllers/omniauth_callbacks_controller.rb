class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def all
		admin = Admin.from_omniauth(request.env["omniauth.auth"])
		if admin.persisted?
			flash.notice = "Signed in!"
			sign_in_and_redirect admin
		else
			session["devise.admin_attributes"] = admin.attributes
			redirect_to new_admin_registration_url
		end
	end

	alias_method :facebook, :all
end
