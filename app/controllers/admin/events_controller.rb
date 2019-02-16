class Admin::EventsController < ApplicationController
  before_action :set_admin_event, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?
  layout 'admin'

  # GET /admin/events
  # GET /admin/events.json
  def index
    @events = Event.all
  end

  # GET /admin/events/1
  # GET /admin/events/1.json
  def show
    @participants = @event.users
  end

  # GET /admin/events/new
  def new
    @path = "/admin/events/"
    @event = Event.new
  end

  # GET /admin/events/1/edit
  def edit
    @path = "/admin/events/#{params[:id]}"
  end

  # POST /admin/events
  # POST /admin/events.json
  def create
    @event = Event.new(admin_event_params)
    @event.event_image.attach(params[:event_image])
    @event.validated = params[:event][:validated]
    respond_to do |format|
      if @event.save
        format.html { redirect_to admin_events_path, notice: 'Event was successfully created.' }
       # format.json { render :show, status: :created, location: @event }
      else
        @path = "/admin/events/"
        format.html { render :new }
        #format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/events/1
  # PATCH/PUT /admin/events/1.json
  def update
    respond_to do |format|
      puts "m"*60
      puts params
      puts "m"*60
      @event.event_image.attach(params[:event_image]) if params[:event_image]
      @event.validated = params[:event][:validated]
      if @event.update(admin_event_params)
        format.html { redirect_to admin_events_path, notice: 'Event was successfully updated.' }
        #format.json { render :show, status: :ok, location: @event }
      else
        @path = "/admin/events/#{params[:id]}"
        format.html { render :edit }
        #format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/events/1
  # DELETE /admin/events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to admin_events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_event_params
      params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location, :administrator_id)
    end
end
