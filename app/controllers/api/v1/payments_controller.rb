module Api::V1
  class PaymentsController < ApplicationController

    def charge

      ActiveRecord::Base.transaction do
        @card = Card.new(payment_params)
        @card.save! # All fields will be validated on model level
        CardValidationService.new(@card).validate # validate card via some service
        CreateChargeOnCard.new(@card, payment_params[:amount]).charge # charge card via some service
        current_user.update!(balance: payment_params[:amount]) # topping up user's balance (random stuff)
      end

      render json: {status: 'Success', message: 'Card was charged successfully!', data: current_user.balance}, status: :ok

    rescue ActiveRecord::RecordInvalid
      render json: {status: 'Failure', message: 'Something went wrong. Please check your card'}, status: :ok
    end

    private

    def payment_params
      params.permit(:card, :name_on_card, :card_type, :expiry_date, :cvv, :amount)
    end
  end
end
