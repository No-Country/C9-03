module NavbarHelper
    def get_location

        if current_user && current_user.location_id != nil
            # Return current address
            user_location = Location.find(current_user.location_id).street   
        else
            'Elegir ubicación'
        end
    end

end    
    