class SessionsController < ApplicationController
  def new
    client_id = Rails.application.credentials.meetup[:client_id]
    redirect_uri = Rails.application.credentials.meetup[:redirect_uri]
    auth_url = "https://secure.meetup.com/oauth2/authorize?client_id=#{client_id}&response_type=code&redirect_uri=#{redirect_uri}"
    return redirect_to auth_url
  end
  def create
    res = HTTParty.post("https://secure.meetup.com/oauth2/access", body:{
      client_id: Rails.application.credentials.meetup[:client_id],
      client_secret: Rails.application.credentials.meetup[:client_secret],
      grant_type: "authorization_code",
      redirect_uri: Rails.application.credentials.meetup[:redirect_uri],
      code: params[:code]
    })
    me = HTTParty.get("https://api.meetup.com/2/member/self/?access_token=" + res["access_token"])
    u = User.find_or_initialize_by(uid: me["id"])
    u.access_token = res["access_token"]
    u.refresh_token = res["refresh_token"]
    u.access_token_expires_at = Time.now.to_i + res["expires_in"].to_i - 1
    u.save
    session['user_id'] = u.id
    redirect_to "/"
  end
  def destroy
    session.clear
    redirect_to "/"
  end
end
