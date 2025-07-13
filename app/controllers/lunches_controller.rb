class LunchesController < ApplicationController
  before_action :set_lunch, only: %i[ show edit update destroy ]
  before_action :set_participant, only: %i[ new ]
  before_action :set_new_lunch, only: %i[ new ]
  before_action :set_lunches, only: %i[ index ]

  # GET /lunches or /lunches.json
  def index; end

  # GET /lunches/1 or /lunches/1.json
  def show
  end

  # GET /lunches/new
  def new
  end

  # GET /lunches/1/edit
  def edit
  end

  # POST /lunches or /lunches.json
  def create
    @lunch = Lunch.new(lunch_params)

    if @lunch.save
      redirect_to root_path, notice: t("helpers.notices.created", model: @lunch.human_class_name)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lunches/1 or /lunches/1.json
  def update
    respond_to do |format|
      if @lunch.update(lunch_params)
        format.html { redirect_to @lunch, notice: "Lunch was successfully updated." }
        format.json { render :show, status: :ok, location: @lunch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lunch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lunches/1 or /lunches/1.json
  def destroy
    @lunch.destroy!

    redirect_to lunches_path(participant_id: @lunch.participant.barcode),
                status: :see_other,
                notice: t("helpers.notices.destroyed", model: @lunch.human_class_name)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lunch
      @lunch = Lunch.find(params.expect(:id))
    end

    def set_participant
      @participant = Participant.find_by(barcode: params[:participant_barcode]) if params[:participant_barcode].present?
      @participant ||= Participant.find_by(barcode: params.expect(lunch: [ :participant_barcode ])[:participant_barcode])
    end

    # Only allow a list of trusted parameters through.
    def lunch_params
      params.expect(lunch: %i[ participant_id user_id food_provider_id delivered_at kind ])
    end

    def set_new_lunch
      @lunch = Lunch.new(
        participant_id: @participant.id,
        user_id: Current.user.id,
        delivered_at: Time.current,
        food_provider_id: @participant.food_provider_id || FoodProvider.default.id
      )
    end

    def set_lunches
      @lunches = Lunch.includes(:participant, :user).order(created_at: :desc)
      @lunches = @lunches.where(participant_id: params[:participant_id]) if params[:participant_id].present?
      @lunches = @lunches.page(params[:page])
    end
end
