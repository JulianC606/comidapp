require "csv"
require_relative "./wsdc/participant"

class Wsdc
  attr_reader :csv

  def initialize
    @participants = CSV.read(Rails.root.join("lib", "wsdc", "participants.csv"), headers: true)
    @providers = CSV.read(Rails.root.join("lib", "wsdc", "providers.csv"), headers: true)
    @restrictions = CSV.read(Rails.root.join("lib", "wsdc", "restrictions.csv"), headers: true)
  end

  def call
    sync_restrictions
    sync_providers
    sync_participants
  end

  private

  def sync_restrictions
    @restrictions.each do |row|
      FoodRestriction.find_or_create_by(name: row["name"], kind: row["kind"])
    end
  end


  def sync_providers
    @providers.each do |row|
      default = row["default"] == "true"
      FoodProvider.find_or_create_by(name: row["name"], default:)
    end
  end

  def sync_participants
     @participants.each do |row|
      participant = WsdcParticipant.new(row["barcode"], row["name"], row["role"], row["country"])
      participant.sync
      participant.add_food_restrictions(parse_food_restriction(row["allergies"], row["food_restriction"]))
      participant.choose_provider
    end
  end

  def parse_food_restriction(allergies, others)
    allergies=allergies&.split(",") || []
    others=others&.split(",") || []
    food_restrictions = allergies + others
    food_restrictions.map do |food_restriction|
      FoodRestriction.find_or_create_by(name: food_restriction)
    end
  end
end
