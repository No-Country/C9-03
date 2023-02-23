class ShoppingCartsController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @shopping_cart = current_user.current_cart
    end
  
    def add_food
      @shopping_cart = current_user.current_cart
      food = Food.find(params[:food_id])
      quantity = params[:quantity] || 1
      if current_user.current_cart.nil?
        ShoppingCart.create!(user: current_user)
      end
      @shopping_cart.add_food(food, quantity)
    end
  
    def checkout
      @shopping_cart = current_user.current_cart
      @shopping_cart.checkout
      redirect_to orders_path
    end

    def remove_food
      @shopping_cart = current_user.current_cart
      food = Food.find(params[:food_id])
      @shopping_cart.remove_food(food)
      redirect_to shopping_cart_path
    end
end
  