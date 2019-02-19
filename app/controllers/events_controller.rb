class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :edit]
  before_action :valid_user, only: [:destroy, :update, :edit]
  before_action :is_there_image?, only: [:create]
  before_action :is_validated?, only: [:show]
  # GET /events
  # GET /events.json
  def index
    @events = Event.all.select{|e| e.validated == true}
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @users = @event.users
  end 

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.administrator = current_user
    @event.event_image.attach(params[:event_image])
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
       # format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        #format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      @event.event_image.attach(params[:event_image]) if params[:event_image]
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location, :administrator)
    end
end
