class ApplicationController < ActionController::Base  
  before_action :configure_permitted_parameters, if: :devise_controller? 
  
  protected

  def is_validated?
    unless Event.find(params[:id]).validated 
      flash[:danger] = "Vous ne pouvez pas afficher un événement non validé"
      redirect_back(fallback_location: root_path)    
    end
  end

  def event_is_validated?
    unless Event.find(params[:event_id]).validated 
      flash[:danger] = "Vous ne pouvez pas vous inscrire à un événement non validé"
      redirect_back(fallback_location: root_path)    
    end
  end


  def is_admin?
    unless current_user.is_admin == true
      flash[:danger] = "Vous n'êtes pas administrateur"
      redirect_back(fallback_location: root_path)
    end
  end

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

  def valid_administrator
    unless current_user == Event.find(params[:event_id]).administrator
      flash[:danger] = "Vous ne pouvez pas avoir accès aux informations d'un événement dont vous n'êtes pas l'administrateur"
      redirect_back(fallback_location: root_path)
    end
  end


  def non_valid_administrator
    if current_user == Event.find(params[:event_id]).administrator
      flash[:danger] = "Vous ne pouvez pas vous inscrire à un événement que vous administrez"
      redirect_back(fallback_location: root_path)
    end
  end

  def already_subscribe
    if Event.find(params[:event_id]).users.include?(current_user)
      flash[:danger] = "Vous êtes déjà inscrits à cet événement"
      redirect_back(fallback_location: root_path)
    end
  end


  def valid_user_profil
    unless current_user == User.find(params[:id])
      flash[:danger] = "Vous ne pouvez pas avoir accès aux informations personnelles d'un autre utilisateur"
      redirect_back(fallback_location: root_path)
    end
  end

  def is_there_image?
    unless params[:event_image]
      flash[:danger] = "Vous ne devez ajouter une image"
      redirect_back(fallback_location: root_path)
    end
  end

end