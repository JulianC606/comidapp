class WsdcParticipant
  def initialize(barcode, name, role, country)
    @barcode = barcode
    @name = name
    @role = role
    @country = country
    @record = nil
    @delegation = nil
  end

  def sync
    @record = Participant.find_or_create_by(barcode:)
    sync_delegation
    @record.attributes = { name:, role:, food_provider: FoodProvider.default }
    @record.save
  end

  def add_food_restrictions(food_restrictions)
    @record.food_restrictions << food_restrictions
  end

  def choose_provider
    return @record.update(food_provider: FoodProvider.find_by(name: "Halal Carnicería")) if @record.food_restrictions.exists?(name: "Halal")
    return @record.update(food_provider: FoodProvider.find_by(name: "Fonda Mi Reinita")) if @record.food_restrictions.exists?(name: "Kosher")
    return @record.update(food_provider: FoodProvider.find_by(name: "Natral Spice")) if @record.food_restrictions.exists?(name: "Vegetarian")
    @record.update(food_provider: FoodProvider.find_by(name: "Natral Spice")) if @record.food_restrictions.exists?(name: "Vegan")
  end

  private

  attr_reader :barcode, :name, :role

  def sync_delegation
    return unless %w[speaker adjudicator team_manager coach].include? @role

    @record.delegation_id = Delegation.find_or_create_by(name: @country).id
  end
end
