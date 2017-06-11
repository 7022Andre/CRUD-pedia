require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  let(:my_wiki) { create(:wiki, user: subject.current_user) }

  describe "GET #index" do
    login_user

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_wiki] to @wikis" do
      get :index
      expect(assigns(:wikis)).to eq [my_wiki]
    end
  end

  describe "GET #show" do
    login_user

    it "returns http success" do
      get :show, {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders #new view" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    login_user

    it "increases Wiki count by 1" do
      expect{ post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user} }.to change(Wiki,:count).by(1)
    end

    it "assigns new wiki to @wiki" do
      post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user}
      expect(assigns(:wiki)).to eq Wiki.last
    end

    it "redirects to new wiki" do
      post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user}
      expect(response).to redirect_to Wiki.last
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

end
