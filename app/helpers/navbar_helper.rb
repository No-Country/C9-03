module NavbarHelper
    def get_location
        if current_user != nil && current_user.location_id != nil
            user_location = Location.find(current_user.location_id).street
            user_location
        else
            ' Tu ubicación'
        end
    end

end    
    