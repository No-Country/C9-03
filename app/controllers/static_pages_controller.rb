class StaticPagesController < ApplicationController
    before_action :authenticate_user!, only: %i[success]
    before_action :unset_cart, only: %i[success]
    
    def landing
        render :landing
    end

    def success
        
        if params[:search].present? && params[:collection_status].equal("approved")
            current_user.current_cart.destroy
        end
        
        render :success
    end

    private
    def unset_cart
        current_user.unset_current_cart
    end
end