class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
        if resource.designation == 'teacher'
          dashboard_path
        else
          doubts_path
        end
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:designation])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
        devise_parameter_sanitizer.permit(:account_update,  keys: [:username])
        devise_parameter_sanitizer.permit(:account_update,  keys: [:designation])
    end
end
