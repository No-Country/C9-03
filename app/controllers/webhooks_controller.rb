# require 'stripe'

# class WebhooksController < ApplicationController
#   skip_before_action :verify_authenticity_token
#   Stripe.api_key = 'sk_test_51Mf4CQAgLOp41ZUX84T7CYR6yA8AkK9PLsrw9ZbNy1tZTdB5caRUoU14j3T9FKfnpSRCG9ZybAa63EuqHUkMNqV400MUqXpIyC'
#   def stripe
#     payload = request.body.read
#     sig_header = request.env['HTTP_STRIPE_SIGNATURE']
#     event = nil

#     begin
#       event = Stripe::Event.construct_from(
#         JSON.parse(payload), sig_header
#       )
#     rescue JSON::ParserError => e
#       # Invalid payload
#       render json: { error: e.message }, status: :bad_request
#       return
#     rescue Stripe::SignatureVerificationError => e
#       # Invalid signature
#       render json: { error: e.message }, status: :bad_request
#       return
#     end

#     # Handle the event
#     case event.type
#     when 'checkout.session.completed'
#       handle_checkout_success(event)
#     when 'checkout.session.failed'
#       handle_checkout_error(event)
#     end

#     render json: { message: 'success' }
#   end

#   private

#   def handle_checkout_success(event)
#     checkout_session = event.data.object

#     # Log the success message
#     Rails.logger.info("Checkout succeeded for session #{checkout_session.id}")

#     # You can access the order id from the client reference id
#     order_id = checkout_session.client_reference_id
#     #empty cart for current user
#     current_user.current_cart.destroy


#   end

#   def handle_checkout_error(event)
#     checkout_session = event.data.object

#     # Log the error message
#     Rails.logger.error("Checkout failed for session #{checkout_session.id}")

#     # You can access the order id from the client reference id
#     order_id = checkout_session.client_reference_id

#     puts "Failed order id: #{order_id}"
#   end
# end
