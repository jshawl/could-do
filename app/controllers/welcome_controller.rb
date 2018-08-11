class WelcomeController < ApplicationController
  def index
  end

  def ics
    @events = Rails.cache.fetch("meetup", expires_in: 10.minutes) do
      User.from_hash(params[:hash]).events
    end
    expires_in 30.minutes, public: true
    cal = Icalendar::Calendar.new
    @events.map do |event|
      str = event["local_date"].gsub('-','') + "T" + event["local_time"].gsub(':','') + "00"
      dt = str_to_datetime(str)
      cal.event do |e|
        e.dtstart     = Icalendar::Values::DateTime.new(datetime_to_str(dt))
        e.dtend       = Icalendar::Values::DateTime.new(datetime_to_str(dt + 1.hour))
        e.summary     = event["name"]
        e.description = event["description"]
        e.url = event['link']
        if event["venue"]
          
        end
        e.location = event['venue']['name'] if event['venue']
      end
    end
    return render inline: cal.to_ical, content_type: "text/calendar"
  end

  def str_to_datetime(str)
    DateTime.strptime(str,"%Y%m%dT%H%M%S")
  end
  def datetime_to_str(datetime)
    datetime.strftime("%Y%m%dT%H%M%S")
  end
end