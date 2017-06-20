require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  let(:wiki) { create(:wiki) }
  let(:user) { create(:user) }
  let(:collaborator) { create(:collaborator, user: user, wiki: wiki) }

	it "collaborator has user and wiki attributes" do
		expect(collaborator).to have_attributes(user_id: user.id, wiki_id: wiki.id)
	end
end
