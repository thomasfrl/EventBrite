class UsersController < ApplicationController
  before_action :valid_user_profil
  def show
    @user = current_user
    @administrated_events = @user.administrated_events
    @events  = @user.events
  end
end
