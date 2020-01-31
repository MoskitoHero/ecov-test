# frozen_string_literal: true

class TripsController < ApplicationController
  before_action :set_trip, only: %i[show edit destroy]
  before_action :set_member_trip, only: %i[start cancel]

  # GET /trips
  # GET /trips.json
  def index
    @trips = Trip.all.order(status: :desc, created_at: :desc)
  end

  # GET /trips/1
  # GET /trips/1.json
  def show; end

  # GET /trips/new
  def new
    @trip = Trip.new
  end

  # GET /trips/1/edit
  def edit; end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(trip_params)

    respond_to do |format|
      if @trip.save
        publish_to_rabbitmq
        format.html { redirect_to @trip, notice: 'Trajet créé avec succès.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1/start
  # PATCH/PUT /trips/1/start.json
  def start
    respond_to do |format|
      if @trip.update(status: 'STARTED')
        publish_to_rabbitmq
        format.html { redirect_to @trip, notice: 'Trajet créé avec succès.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1/cancel
  # PATCH/PUT /trips/1/cancel.json
  def cancel
    respond_to do |format|
      if @trip.update(status: 'CANCELLED')
        publish_to_rabbitmq
        format.html { redirect_to trips_path, notice: 'Trajet annulé avec succès.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trajet supprimé avec succès.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trip
    @trip = Trip.find(params[:uid])
  end

  def set_member_trip
    @trip = Trip.find(params[:uid])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def trip_params
    params.fetch(:trip, {}).permit(:uid, :status, :departure, :destination)
  end

  def publish_to_rabbitmq
    Publisher.publish('fanout', uid: @trip.uid, status: @trip.status)
  end
end
