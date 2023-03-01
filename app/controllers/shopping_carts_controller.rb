class ShoppingCartsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_cart, only: %i[show add_food remove_food checkout]
  
    def show
      @shopping_cart = current_user.current_cart
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
      if current_user.current_cart.nil?
        @shopping_cart = ShoppingCart.create!(user: current_user)
      end
      @shopping_cart = current_user.current_cart
    end
end
  