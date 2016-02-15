require 'amount'

class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: Amount.default
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd' )

    flash[:notice] = "Thank you for your purchase, #{current_user.email}."

    current_user.premium!

    flash[:notice] = "#{current_user.email} account upgraded to #{current_user.role}."
    redirect_to current_user

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end

  end
