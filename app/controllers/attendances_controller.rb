class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :valid_administrator, only: [:index]
  before_action :non_valid_administrator, only: [:new, :create]
  before_action :already_subscribe, only: [:new, :create]
  before_action :event_is_validated?, only: [:new, :create]

  
  def new
    @event = Event.find(params[:event_id])
  end

  def create

    @event = Event.find(params[:event_id])
    @attendance = Attendance.new()
    @attendance.user = current_user
    @attendance.event = @event

    amount = @event.price * 100
  
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
  
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    @attendance.stripe_customer_id = customer.id
  

    if @attendance.save
      redirect_to event_path(@event), notice: 'Subscription was successfully created.' 
    else
      flash.now[:error] = "Echec lors de votre inscription à l'événement"
      render :new
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_attendance_path

  end

  def index
    @event = Event.find(params[:event_id])
    @attendances = Attendance.all.select{|a| a.event == @event}
  end
end
