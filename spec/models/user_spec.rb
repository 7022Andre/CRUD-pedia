require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:wiki) { create(:wiki) }
  let(:collaborator) { create(:collaborator, user: user, wiki: wiki) }

  describe "attributes" do
    it "should have email and password" do
      expect(user).to have_attributes(email: user.email, password: user.password)
    end

    it "user should have standard role" do
      expect(user.role).to eq "standard"
    end

    it "user should not be confirmed after signup" do
      expect(user.confirmed?).to be false
    end

    it "user should be confirmed after confirmation clicked" do
      user.confirm
      expect(user.confirmed?).to be true
    end
  end
end
