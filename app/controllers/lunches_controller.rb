class LunchesController < ApplicationController
  before_action :set_lunch, only: %i[ show edit update destroy ]
  before_action :set_participant, only: %i[ new ]

  # GET /lunches or /lunches.json
  def index
    @lunches = Lunch.page(params[:page])
  end

  # GET /lunches/1 or /lunches/1.json
  def show
  end

  # GET /lunches/new
  def new
    @lunch = Lunch.new
  end

  # GET /lunches/1/edit
  def edit
  end

  # POST /lunches or /lunches.json
  def create
    @lunch = Lunch.new(lunch_params)

    respond_to do |format|
      if @lunch.save
        format.html { redirect_to lunches_path, notice: "Lunch was successfully created." }
        format.json { render :show, status: :created, location: @lunch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lunch.errors, status: :unprocessable_entity }
      end
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

    respond_to do |format|
      format.html { redirect_to lunches_path, status: :see_other, notice: "Lunch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lunch
      @lunch = Lunch.find(params.expect(:id))
    end

    def set_participant
      @participant = Participant.find_by(barcode: params.expect(lunch: [ :participant_barcode ])[:participant_barcode])
    end

    # Only allow a list of trusted parameters through.
    def lunch_params
      params.expect(lunch: [ :participant_id, :user_id, :kind, :delivery_date ])
    end
end
