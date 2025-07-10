# frozen_string_literal: true

class FoodRestrictionsController < ApplicationController
  before_action :set_food_restriction, only: %i[ show edit update destroy ]

  def index
    @food_restrictions = FoodRestriction.page(params[:page])
  end

  def show; end

  def new
    @food_restriction = FoodRestriction.new
  end

  def edit; end

  def create
    @food_restriction = FoodRestriction.new(food_restriction_params)

    if @food_restriction.save
      redirect_to food_restrictions_path, notice: I18n.t("helpers.notices.created", model: @food_restriction.human_class_name)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @food_restriction.update(food_restriction_params)
      redirect_to @food_restriction, notice: I18n.t("helpers.notices.updated", model: @food_restriction.human_class_name)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @food_restriction.destroy!

    redirect_to food_restrictions_path, status: :see_other, notice: I18n.t("helpers.notices.destroyed", model: @food_restriction.human_class_name)
  end

  private

  def set_food_restriction
    @food_restriction = FoodRestriction.find(params.expect(:id))
  end

  def food_restriction_params
    params.expect(food_restriction: [ :name, :kind ])
  end
end
