class LocationsController < ApplicationController
    def index
        @stores = Store.all
    end    
end    