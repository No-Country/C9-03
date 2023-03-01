class StaticPagesController < ApplicationController
    
    def landing
        render :landing
    end

    def success
        render :success
    end    
end