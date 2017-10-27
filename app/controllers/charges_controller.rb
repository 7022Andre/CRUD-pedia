class ChargesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    # Amount in cents
    @amount = 1500

    customer = Stripe::Customer.create(
      email:  current_user.email,
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:    customer.id,
      amount:      @amount,
      description: 'CRUD-pedia - Upgrade to premium',
      currency:    'usd'
    )

    flash[:notice] = 'Thanks for upgrading your account!'
    current_user.premium!
    redirect_to user_path(current_user)

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end
end
