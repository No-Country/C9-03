module NavbarHelper
    def get_location
        if current_user && current_user.location_id != nil
            # Return current address
            user_location = Location.find(current_user.location_id).street   
        else
            t('navbar.choose_location')
        end
    end

    def logged_and_location
        if current_user && current_user.location_id != nil 
            false 
        else
            true
        end    
    end
end    
    