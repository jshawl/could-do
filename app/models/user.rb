class User < ApplicationRecord

  include HashidSingleton

  def ics_path
    "/#{hashids.encode(id)}.ics"
  end

  def self.from_hash(hash)
    find_by(id: hashids.decode(hash))
  end

  def events
    HTTParty.get("https://api.meetup.com/find/upcoming_events?access_token=#{access_token}")["events"]
  end

  def ics_events
    cal = Icalendar::Calendar.new
    events.map do |event|
      str = event["local_date"].gsub('-','') + "T" + event["local_time"].gsub(':','') + "00"
      dt = str_to_datetime(str)
      cal.event do |e|
        e.dtstart = Icalendar::Values::DateTime.new(datetime_to_str(dt))
        e.dtend = Icalendar::Values::DateTime.new(datetime_to_str(dt + 1.hour))
        e.summary = event["name"]
        e.description = event["description"]
        e.url = event['link']
        e.location = event['venue']['name'] if event['venue']
      end
    end
    cal
  end

  def str_to_datetime(str)
    DateTime.strptime(str,"%Y%m%dT%H%M%S")
  end

  def datetime_to_str(datetime)
    datetime.strftime("%Y%m%dT%H%M%S")
  end

end