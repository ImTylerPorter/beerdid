class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

      before_filter :configure_permitted_parameters, if: :devise_controller?

      private

      def configure_permitted_parameters
         devise_parameter_sanitizer.for(:sign_up){ |u| u.permit(:name, :user_name, :email, :password, :password_confirmation, :update_without_password, :current_password, :first_name, :last_name, :terms, :image)}        
         devise_parameter_sanitizer.for(:account_update){ |u| u.permit(:name, :user_name, :email, :password, :password_confirmation, :update_without_password, :current_password, :first_name, :last_name, :terms, :image) }          
      end
end
