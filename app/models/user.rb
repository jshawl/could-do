require 'digest/bubblebabble'

class User < ApplicationRecord
  def ics_key
    Digest::SHA256.hexdigest uid.to_s
  end
  def ics_path
    h = Hashids.new(Rails.application.credentials.hashids_salt, 8, "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
    enc = h.encode(id)
    "/#{enc}.ics"
  end
  def self.from_hash(hash)
    h = Hashids.new(Rails.application.credentials.hashids_salt, 8, "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
    enc = h.decode(hash)
    User.find_by(id: enc)
  end
  def events
    HTTParty.get("https://api.meetup.com/find/upcoming_events?access_token=#{access_token}")["events"]
  end
end