class WelcomeController < ApplicationController

  def index
  end

  def ics
    expires_in 30.minutes, public: true
    @events = User.from_hash(params[:hash]).ics_events
    return render inline: @events.to_ical, content_type: "text/calendar"
  end

end