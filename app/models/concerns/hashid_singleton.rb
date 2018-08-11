require 'active_support/concern'

module HashidSingleton
  extend ActiveSupport::Concern
  def hashids
    Hashids.new(Rails.application.credentials.hashids_salt, 8, "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
  end
end