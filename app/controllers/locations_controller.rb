class LocationsController < ApplicationController
    def index
        # By default take CABA coordinates
        @latitude = -34.599722
        @longitude = -58.381944
        if params[:place].present?
            @results = Geocoder.search(params[:place].to_s + ", CABA",
                 params: {countrycodes: "ar"})
            if @results != nil 
                @latitude = @results.first.latitude
                @longitude = @results.first.longitude
            end    
        end       
    end
    
    def create
        user = current_user
        location = Location.create!(street: params[:place_guardar], latitude: params[:place_latitude], longitude: params[:place_longitude] )
        if location.save!
            user.location_id = location.id
            user.save!
        end    
        redirect_to stores_path
    end    
end    