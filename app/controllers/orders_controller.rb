class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_order, only: [:show, :payment]
    def show
        generate_mercadopago_preference_service = GenerateMercadopagoPreferenceService.new(@order.shopping_cart)
        @preference_id = generate_mercadopago_preference_service.call  
        @order
    end

    def payment
        # I'm hardcoding the api_key because env vars and credentials are not working for me. I think it should be working in production env though.
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
            client_reference_id: @order.id,
            payment_method_types: ['card'],
            success_url: root_url,
            cancel_url: root_url,
        )
        #redirect and empty cart
        redirect_to @order_session.url, status: 303, allow_other_host: true, target: "_blank"
    end
    
    private
    def set_order
        @order ||= current_user.orders.find(params[:id] || params[:order_id])
    end
end