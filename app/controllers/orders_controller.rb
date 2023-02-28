class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_order, only: [:show, :payment]
    def show
        @order
    end
    def payment
        Stripe.api_key = "sk_test_51Mf4CQAgLOp41ZUX84T7CYR6yA8AkK9PLsrw9ZbNy1tZTdB5caRUoU14j3T9FKfnpSRCG9ZybAa63EuqHUkMNqV400MUqXpIyC"
        puts "stripe api key: #{Stripe.api_key}"
        #create prices array with the format [{price: price_id, quantity: quantity}]
        prices = []
        @order.line_items.each do |line_item|
            prices.push({price: line_item.food.stripe_price_id, quantity: line_item.quantity})
        end
        @order_session = Stripe::Checkout::Session.create(
            mode: 'payment',
            client_reference_id: @order.id,
            currency: 'usd',
            customer_email: current_user.email,
            # pass prices
            line_items: prices,
            payment_method_types: ['card'],
            success_url: "http://localhost:3000/",
            cancel_url: "http://localhost:3000/"
        )    
    end
    private
    def set_order
        @order = current_user.orders.find(15)
    end
end