class ShoppingCartsController < ApplicationController
    before_action :authenticate_user!
    before_action :current_cart
  
    def show
      generate_mercadopago_preference_service = GenerateMercadopagoPreferenceService.new(@current_cart)
      @preference_id = generate_mercadopago_preference_service.call
      @current_cart
    end
  
    def add_food
      food = Food.find(params[:food_id])
      quantity = params[:quantity] || 1
      
      @current_cart.add_food(food, quantity)
    end
  
    def checkout
      @current_cart.checkout
      redirect_to order_path(@current_cart.order)
    end

    def remove_food
      food = Food.find(params[:food_id])
      @current_cart.remove_food(food)
      redirect_to shopping_cart_path
    end
    private
    def current_cart
      if session[:shopping_cart_id]
        shopping_cart = ShoppingCart.find_by(:id => session[:shopping_cart_id])
        if shopping_cart.present?
          @current_cart = shopping_cart
        else
          session[:shopping_cart_id] = nil
        end
      end

      if session[:shopping_cart_id] == nil
        @current_cart = ShoppingCart.create!(user: current_user)
        session[:shopping_cart_id] = @current_cart.id
      end
    end 
end