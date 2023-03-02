class StaticPagesController < ApplicationController
    
    def landing
        render :landing
    end

    def success
        
        if params[:search].present? && params[:collection_status].equal("approved")
            current_user.current_cart.destroy
        end
        
        render :success
    end    
end