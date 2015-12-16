class ChargesController < ApplicationController
  def new
    # Rails.configuration.stripe = {

    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      # description: "Premium Membership - #{current_user.email}",
      # TODO put this in own class/structure/block?
      # amount: Amount.default
      amount: 10_00
    }
  end

  def create
    # customer = Stripe::Customer.create(
    @customer = Stripe::Customer.create(
      email: current_user.email,
      card: [params[:stripeToken]]
    )

    # TODO create Amount class
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      # description: "Premium Membership - #{current_user.email}",
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd' )

    flash[:notice] = "Thank you for your purchase, #{current_user.email}."
    # TODO change this to something better?
    redirect_to user_path(current_user)

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
  end
# end
