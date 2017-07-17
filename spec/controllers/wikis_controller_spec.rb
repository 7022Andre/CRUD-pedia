require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  let(:my_wiki) { create(:wiki, user: subject.current_user) }
  let(:other_wiki) { create(:wiki) }
  let(:private_wiki) { create(:wiki, user: subject.current_user, private: true) }
  let(:other_private_wiki) { create(:wiki, private: true) }

  context "public wiki" do
    describe "guest" do
      it "can see index - returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "shows wiki - returns http success" do
        get :show, {id: other_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "renders #show view" do
        get :show, {id: other_wiki.id}
        expect(response).to render_template :show
      end

      it "#new returns http redirect" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end

      it "can't create wiki - returns http redirect" do
        post :create, wiki: {name: RandomData.random_sentence, description: RandomData.random_paragraph}
        expect(response).to redirect_to(new_user_session_path)
      end

      it "can't edit wiki - returns http redirect" do
        get :edit, {id: other_wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end

      it "can't update wiki - returns http redirect" do
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, id: other_wiki.id, wiki: {name: new_name, description: new_description }
        expect(response).to redirect_to(new_user_session_path)
      end

      it "can't delete wiki - returns http redirect" do
        delete :destroy, {id: other_wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "standard user" do
      login_standard_user

      it "can create wiki - increases Wiki count by 1" do
        expect{ post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user} }.to change(Wiki,:count).by(1)
      end

      it "can create wiki - assigns new wiki to @wiki" do
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user}
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "can create wiki and redirects to new wiki" do
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user}
        expect(response).to redirect_to Wiki.last
      end

      it "can edit own wiki - returns http success" do
        get :edit, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "can edit own wiki- renders #edit view" do
        get :edit, {id: my_wiki.id}
        expect(response).to render_template :edit
      end

      it "can update own wiki and returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to(wiki_path)
      end

      it "can delete own wiki and returns http redirect" do
        delete :destroy, {id: my_wiki.id}
        expect(response).to redirect_to(wikis_path)
      end

      it "can update other wiki" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: other_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to(wiki_path)
      end

      it "can't delete other wiki" do
        delete :destroy, {id: other_wiki.id}
        expect(response).to redirect_to(root_path)
      end
    end

    describe "premium user" do
      login_premium_user

      it "can create wiki - increases Wiki count by 1" do
        expect{ post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user} }.to change(Wiki,:count).by(1)
      end

      it "can create wiki - assigns new wiki to @wiki" do
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user}
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "can create wiki and redirects to new wiki" do
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user}
        expect(response).to redirect_to Wiki.last
      end

      it "can edit own wiki - returns http success" do
        get :edit, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "can edit own wiki- renders #edit view" do
        get :edit, {id: my_wiki.id}
        expect(response).to render_template :edit
      end

      it "can update own wiki and returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to(wiki_path)
      end

      it "can delete own wiki and returns http redirect" do
        delete :destroy, {id: my_wiki.id}
        expect(response).to redirect_to(wikis_path)
      end

      it "can update other wiki" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: other_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to(wiki_path)
      end

      it "can't delete other wiki" do
        delete :destroy, {id: other_wiki.id}
        expect(response).to redirect_to(root_path)
      end
    end

    describe "admin user" do
      login_admin_user

      it "can create wiki - increases Wiki count by 1" do
        expect{ post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user} }.to change(Wiki,:count).by(1)
      end

      it "can create wiki - assigns new wiki to @wiki" do
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user}
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "can create wiki and redirects to new wiki" do
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user}
        expect(response).to redirect_to Wiki.last
      end

      it "can edit own wiki - returns http success" do
        get :edit, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "can edit own wiki- renders #edit view" do
        get :edit, {id: my_wiki.id}
        expect(response).to render_template :edit
      end

      it "can update own wiki and returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to(wiki_path)
      end

      it "can delete own wiki and returns http redirect" do
        delete :destroy, {id: my_wiki.id}
        expect(response).to redirect_to(wikis_path)
      end

      it "can update other wiki" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: other_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to(wiki_path)
      end

      it "can delete other wiki" do
        delete :destroy, {id: other_wiki.id}
        expect(response).to redirect_to(wikis_path)
      end
    end
  end

  context "private wiki" do
    describe "guest" do
      it "can't open private wiki" do
        get :show, {id: other_private_wiki.id}
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "standard user" do
      login_standard_user

      it "can't create private wiki" do
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user, private: true}
        expect(response).to redirect_to(wikis_path)
      end

      it "can't open private wiki" do
        get :show, {id: other_private_wiki.id}
        expect(response).to redirect_to(wikis_path)
      end

      it "can open own private wiki (created as premium user before downgrade)" do
        get :show, {id: private_wiki.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "premium user" do
      login_premium_user

      it "can open private wiki" do
        get :show, {id: private_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "can create private wiki" do
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user, private: true}
        expect(response).to redirect_to(Wiki.last)
      end

      it "can update private wiki" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: private_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to(wiki_path)
      end

      it "can delete own private wiki" do
        delete :destroy, {id: private_wiki.id}
        expect(response).to redirect_to(wikis_path)
      end

      it "can't delete other private wiki" do
        delete :destroy, {id: other_private_wiki.id}
        expect(response).to redirect_to(root_path)
      end
    end

    describe "admin user" do
      login_admin_user

      it "can open private wiki" do
        get :show, {id: private_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "can create private wiki" do
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, user: subject.current_user, private: true}
        expect(response).to redirect_to(Wiki.last)
      end

      it "can update private wiki" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: private_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to(wiki_path)
      end

      it "can delete private wiki" do
        delete :destroy, {id: private_wiki.id}
        expect(response).to redirect_to(wikis_path)
      end

      it "can delete other private wiki" do
        delete :destroy, {id: other_private_wiki.id}
        expect(response).to redirect_to(wikis_path)
      end
    end
  end
end
