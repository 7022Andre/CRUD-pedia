require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
	let(:private_wiki) { create(:wiki, private: true) }
	let(:user) { create(:user) }
	let(:collaborator) { create(:collaborator, user: user, wiki: private_wiki) }

	describe "premium user" do
		login_premium_user

		it "add collaborator via wiki" do
			private_wiki.collaborators.create(user: user)
			expect(Collaborator.last).to have_attributes(user_id: user.id, wiki_id: private_wiki.id)
		end

		it "destroys collaborator via wiki" do
			private_wiki.collaborators.create(user: user)
			private_wiki.collaborators.find_by(user_id: user.id).destroy
			expect(Collaborator.all.empty?).to eq true
		end

		it "destroys all collaborators of wiki after wiki is deleted" do
			private_wiki.collaborators.create(user: user)
			private_wiki.destroy
			expect(Collaborator.all.empty?).to eq true
		end
	end

	describe "admin" do
		login_admin_user

		it "add collaborator via wiki" do
			private_wiki.collaborators.create(user: user)
			expect(Collaborator.last).to have_attributes(user_id: user.id, wiki_id: private_wiki.id)
		end

		it "destroys collaborator via wiki" do
			private_wiki.collaborators.create(user: user)
			private_wiki.collaborators.find_by(user_id: user.id).destroy
			expect(Collaborator.all.empty?).to eq true
		end

		it "destroys all collaborators of wiki after wiki is deleted" do
			private_wiki.collaborators.create(user: user)
			private_wiki.destroy
			expect(Collaborator.all.empty?).to eq true
		end
	end
end
