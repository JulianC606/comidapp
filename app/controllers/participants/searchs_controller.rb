# frozen_string_literal: true

module Participants
  class SearchsController < ApplicationController
    def new; end

    def create
      redirect_to participant_path(participant_barcode)
    end

    private

    def participant_barcode = participant_params[:barcode]
    def participant_params = params.expect(participant: [ :barcode ])
  end
end
