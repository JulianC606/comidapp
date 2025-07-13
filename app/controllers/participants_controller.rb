class ParticipantsController < ApplicationController
  before_action :set_participant, only: %i[ show edit update destroy ]

  # GET /participants or /participants.json
  def index
    @participants = Participant.includes(:food_provider).page(params[:page] || 1)
  end

  # GET /participants/1 or /participants/1.json
  def show
    @lunches = @participant.lunches
  end

  # GET /participants/new
  def new
    @participant = Participant.new
  end

  # GET /participants/1/edit
  def edit
  end

  # POST /participants or /participants.json
  def create
    @participant = Participant.new(participant_params)

    if @participant.save
      redirect_to participant_path(@participant.barcode), notice: I18n.t("helpers.notices.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /participants/1 or /participants/1.json
  def update
    if @participant.update(participant_params)
      redirect_to participant_path(@participant.barcode), notice: I18n.t("helpers.notices.updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /participants/1 or /participants/1.json
  def destroy
    @participant.destroy!

    redirect_to participants_path, status: :see_other, notice: I18n.t("helpers.notices.destroyed")
  end

  private
    def participant_barcode
      params.expect(participant: :barcode)[:barcode]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find_by(barcode: params.expect(:barcode))
      @participant ||= Participant.find(params.expect(:barcode))
    end

    # Only allow a list of trusted parameters through.
    def participant_params
      params.expect(participant: [ :name, :welcome_kit, :barcode, :role, :food_provider_id, food_restriction_ids: [] ])
    end
end
