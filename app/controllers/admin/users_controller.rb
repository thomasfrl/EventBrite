class Admin::UsersController < ApplicationController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?
  layout 'admin'
  # GET /admin/users
  # GET /admin/users.json
  def index
    @admin_users = User.all
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
    @user = set_admin_user
    @administrated_events = @user.administrated_events
    @events  = @user.events

  end

  # GET /admin/users/new
  def new
    @path = "/admin/users/"
    @admin_user = User.new
  end

  # GET /admin/users/1/edit
  def edit
    @path = "/admin/users/#{params[:id]}"
    @admin_user = set_admin_user
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @admin_user = User.new(admin_user_params)
    @admin_user.avatar.attach(params[:user][:avatar]) if params[:user][:avatar]
    @admin_user.update(is_admin: params[:user][:is_admin])
    @admin_user.update(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
    respond_to do |format|
      if @admin_user.save
        format.html { redirect_to admin_users_path, notice: 'User was successfully created.' }
        #format.json { render :show, status: :created, location: @admin_user }
      else
        @path = "/admin/users/"
        format.html { render :new }
        #format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      @admin_user.is_admin = params[:user][:is_admin]
      puts "t"*90
      puts params
      puts "t"*90
      if params[:user][:password]
        puts "9"*60
      end
      if params[:user][:password] != "" || params[:user][:password_confirmation] != ""
        @admin_user.password = params[:user][:password]
        @admin_user.password_confirmation = params[:user][:password_confirmation]
      end 
      if @admin_user.update(admin_user_params) 
        @admin_user.avatar.attach(params[:user][:avatar]) if params[:user][:avatar]
        format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
        #format.json { render :show, status: :ok, location: @admin_user }
      else
        @path = "/admin/users/#{params[:id]}"
        format.html { render :edit }
        #format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:user).permit(:first_name, :last_name, :description, :email)
    end
end
