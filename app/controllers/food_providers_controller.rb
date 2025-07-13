# frozen_string_literal: true

class FoodProvidersController < ApplicationController
  before_action :set_food_provider, only: %i[ edit update destroy ]

  def index
    @food_providers = FoodProvider.page(params[:page])
  end

  def new
    @food_provider = FoodProvider.new
  end

  def edit; end

  def create
    @food_provider = FoodProvider.new(food_provider_params)

    if @food_provider.save
      redirect_to food_providers_path, notice: I18n.t("helpers.notices.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @food_provider.update(food_provider_params)
      redirect_to food_providers_path, notice: I18n.t("helpers.notices.updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @food_provider.destroy!
    redirect_to food_providers_path, status: :see_other, notice: I18n.t("helpers.notices.destroyed")
  end

  private

  def set_food_provider
    @food_provider = FoodProvider.find(params.expect(:id))
  end

  def food_provider_params
    params.expect(food_provider: [ :name, :default ])
  end
end
