# include Amount
require 'amount'

class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      # REVIEW why doesn't this work?
      amount: Amount.default
      # amount: 10_00
    }
  end

  def edit
    # TODO change Stripe account to reflect downgrade
    current_user.downgrade_role

    flash[:notice] = "#{current_user.email} account downgraded to #{current_user.role}."
    redirect_to user_path(current_user)
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # TODO create Amount class
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd' )

    # flash[:notice] = "Thank you for your purchase, #{current_user.email}."
    # TODO change this to something better?
    # XXX testing - adding user upgrade here

    current_user.vip!

    flash[:notice] = "#{current_user.email} account upgraded to #{current_user.role}."
    redirect_to current_user

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end

  end
