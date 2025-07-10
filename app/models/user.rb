class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy_async

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  enum :locale, { en: "en", es: "es" }

  def self.humanized_locales
    locales.map { |key, value| [ human_attribute_name("locale/#{value}"), key ] }
  end
end
