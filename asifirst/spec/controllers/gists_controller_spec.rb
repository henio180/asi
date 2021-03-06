require "spec_helper"

describe GistsController do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the gists into @gists" do
      gist1, gist2 = Gist.create!, Gist.create!
      get :index
      expect(assigns(:gists)).to match_array([gist1, gist2])
    end
  end
end
