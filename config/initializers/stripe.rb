#add stripe secret key from application.yml
require 'stripe'

Stripe.api_key = ENV['STRIPE_SECRET_KEY']
StripeEvent.configure do |events|
    events.subscribe 'checkout.session.completed' do |event|
        puts "checkout.session.completed"
    end
end