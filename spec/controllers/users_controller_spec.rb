require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	context "user not logged in" do
		it "GET #show - returns to login page" do
			get :show, {id: rand(1..100)}
			expect(response).to redirect_to(new_user_session_path)
		end
	end

	context "standard user logged in" do
		login_standard_user

		it "GET #show - shows own profile page" do
			get :show, {id: subject.current_user}
			expect(response).to have_http_status(:success)
		end

		login_other_standard_user
		
		it "GET #show - does not show other profiles" do
			request.env['HTTP_REFERER'] = 'http://test.host/'
			get :show, {id: 1}
			expect(response).to redirect_to(request.referer)
		end
	end
end
