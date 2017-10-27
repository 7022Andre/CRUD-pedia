require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:wiki) { create(:wiki) }
  let(:user) { create(:user) }

  describe "attributes" do
    it "has title, body and user attribute" do
      user.confirm
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body, user: wiki.user)
    end

    it "is public by default" do
      expect(wiki.private).to be(false)
    end
  end
end
