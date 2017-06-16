require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  let(:my_wiki) { create(:wiki, user: subject.current_user) }
  let(:other_wiki) { create(:wiki) }
  let(:private_wiki) { create(:wiki, private: true) }

  context "guest user - not signed in" do
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, {id: other_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, {id: other_wiki.id}
        expect(response).to render_template :show
      end
    end

     describe "GET #new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST #create" do
      it "returns http redirect" do
        post :create, wiki: {name: RandomData.random_sentence, description: RandomData.random_paragraph}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #edit" do
      it "returns http redirect" do
        get :edit, {id: other_wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PUT #update" do
      it "returns http redirect" do
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, id: other_wiki.id, wiki: {name: new_name, description: new_description }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE #destroy" do
      it "returns http redirect" do
        delete :destroy, {id: other_wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "standard user, CRUD on own wiki (all methods permitted)" do
    describe "GET #index" do
      login_standard_user
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
      login_standard_user
      it "returns http success" do
        get :show, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #new" do
      login_standard_user
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
      login_standard_user
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
      login_standard_user
      it "returns http success" do
        get :edit, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "renders #edit view" do
        get :edit, {id: my_wiki.id}
        expect(response).to render_template :edit
      end
    end

    describe "PUT #update" do
      login_standard_user
      it "updates wiki and returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to(wiki_path)
      end
    end

    describe "DELETE #destroy" do
      login_standard_user
      it "deletes wiki and returns http redirect" do
        delete :destroy, {id: my_wiki.id}
        expect(response).to redirect_to(wikis_path)
      end
    end
  end

  context "standard user, CRUD on other wiki (edit permitted, destroy not permitted)" do
    describe "PUT #update" do
      login_other_standard_user
      it "updates wiki and returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: other_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to(wiki_path)
      end
    end

    describe "DELETE #destroy" do
      login_other_standard_user

      it "other user can't delete wiki and returns to root" do
        request.env['HTTP_REFERER'] = 'http://localhost:3000'
        delete :destroy, {id: other_wiki.id}
        expect(response).to redirect_to(request.referer)
      end
    end
  end

  context "private wiki" do
    describe "guest" do
      it "can't open private wiki" do
        request.env['HTTP_REFERER'] = 'http://localhost:3000'
        get :show, {id: private_wiki.id}
        expect(response).to redirect_to(request.referer)
      end
    end

    describe "standard user" do
      login_standard_user

      it "can't create private wiki" do
        request.env['HTTP_REFERER'] = 'http://localhost:3000'
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user, private: true}
        expect(response).to redirect_to(request.referer)
      end

      it "can't open private wiki" do
        request.env['HTTP_REFERER'] = 'http://localhost:3000'
        get :show, {id: private_wiki.id}
        expect(response).to redirect_to(request.referer)
      end
    end

    describe "premium user" do
      login_premium_user

      it "can open private wiki" do
        get :show, {id: private_wiki.id}
        expect(response).to have_http_status(:success)
      end
    end
  end
end
