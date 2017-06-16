module ControllerMacros
  def login_standard_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      user.update_attributes(role: :standard)
      user.confirm
      sign_in user
    end
  end

  def login_other_standard_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      user.update_attributes(role: :standard)
      user.confirm
      sign_in user
    end
  end

  def login_premium_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      user.update_attributes(role: :premium)
      user.confirm
      sign_in user
    end
  end
end
