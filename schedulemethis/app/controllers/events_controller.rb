class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :all_events, only: [:index, :create, :update]
  respond_to :html, :js

  # GET /events
  # GET /events.json
  def index
  end

  # GET /events/1
  # GET /events/1.json
  def show
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
    if !user_signed_in?
      redirect_to root_url
    else
      @mySchedule = Schedule.all.where(user_id: current_user.id).first
      if @mySchedule.nil?
        @mySchedule = Schedule.create user_id: current_user.id
        @mySchedule.save!
      end
      @event = Event.new(event_params)
      @event.schedule = @mySchedule
      @event.save
      #validation?
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
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
    def all_events
      @events = Event.recently_created.limit(5)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:short_description, :description, :start_date, :end_date, :start_time, :end_time, :start_time_flex_amount, :end_time_flex_amount, :priority, :may_split, :estimated_time_required, :location)
    end
end
