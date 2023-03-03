class StaticPagesController < ApplicationController
    before_action :authenticate_user!, only: %i[success]
    before_action :unset_cart, only: %i[success]
    
    def landing
        render :landing
    end

    def success
        render :success
    end

    private
    def unset_cart
        session[:shopping_cart_id] = nil
    end
end