class ShoppingCartsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_cart, only: %i[show add_food remove_food checkout]
  
    def show
      generate_mercadopago_preference_service = GenerateMercadopagoPreferenceService.new(@shopping_cart)
      @preference_id = generate_mercadopago_preference_service.call
      @shopping_cart
    end
  
    def add_food
      food = Food.find(params[:food_id])
      quantity = params[:quantity] || 1
      
      @shopping_cart.add_food(food, quantity)
    end
  
    def checkout
      @shopping_cart.checkout
      redirect_to order_path(@shopping_cart.order)
    end

    def remove_food
      food = Food.find(params[:food_id])
      @shopping_cart.remove_food(food)
      redirect_to shopping_cart_path
    end

    private
    def set_cart
      current_cart = current_user.current_cart
      if current_cart.nil?
        current_cart = ShoppingCart.create!(user: current_user)
        current_user.set_current_cart(current_cart)
      end
      @shopping_cart = current_cart
    end
end