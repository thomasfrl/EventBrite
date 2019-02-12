class ApplicationController < ActionController::Base  
  before_action :configure_permitted_parameters, if: :devise_controller? 
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :description])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :description])
  end

  def valid_user
    unless current_user == Event.find(params[:id]).administrator
      flash[:danger] = "Vous ne pouvez pas modifier ou supprimer un élément que vous n'avez pas créé."
      redirect_back(fallback_location: root_path)
    end
  end
end