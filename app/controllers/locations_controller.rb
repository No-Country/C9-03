class LocationsController < ApplicationController
    before_action :authenticate_user!

    def index
        # By default take CABA coordinates
        @latitude = -34.599722
        @longitude = -58.381944
        @error = ""

        if current_user.location_id?
            @current_place = Location.find(current_user.location_id).street
            @latitude = Location.find(current_user.location_id).latitude
            @longitude = Location.find(current_user.location_id).longitude
        end    
        if params[:place].present?
            @results = Geocoder.search(params[:place].to_s + ", CABA",
                 params: {countrycodes: "ar"})
            if !@results.empty?
                @latitude = @results.first.latitude
                @longitude = @results.first.longitude
            else
                @error = "No se encontro la dirección, busque de nuevo"
                params.delete :place    
            end    
        end       
    end
    
    def create
        user = current_user
        location = Location.create!(street: params[:place_street], latitude: params[:place_latitude], longitude: params[:place_longitude] )
        if location.save!
            user.location_id = location.id
            user.save!
        end    
        redirect_to stores_path
    end    
end    