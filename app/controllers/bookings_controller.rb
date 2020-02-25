class BookingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @bookings = Booking.where(user: current_user)
  end

  def show
    @booking = Booking.find(params[:id])
    @owner = @booking.car.user
    @renter = @booking.user
    @car = @booking.car
  end

  def new
    @booking = Booking.new
    @car = Car.find(params[:car_id])
  end

  def create
    # raise
    @car = Car.find(params[:car_id])
    booking = Booking.new(booking_params)
    booking.car = @car
    booking.user = current_user
    if booking.save!
      redirect_to booking_path(booking)
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :car_id, :initial_date, :final_date)
  end

end
