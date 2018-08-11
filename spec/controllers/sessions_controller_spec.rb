describe SessionsController do
  describe "GET /auth/callback" do
    it "assigns @teams" do
      stub_request(:post, "https://secure.meetup.com/oauth2/access").
        to_return(status: 200, body: fixture("login"), headers: {})
      stub_request(:get, "https://api.meetup.com/2/member/self/?access_token=access_token").
        to_return(status: 200, body: fixture("me"), headers: {})
      expect{
        get :create, params: {code: 'abc'}
      }.to change{User.count}.by(1)
    end
  end
end