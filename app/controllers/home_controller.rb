class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:secret]
  def index
  end

  def secret
  end
end
