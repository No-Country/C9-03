module StoresHelper
    def make_params(url, new_param)
        # NO BORRAR, se utilizara a futuro
        
        # http://localhost:3000/stores#index
        # http://localhost:3000/stores?category_id=2
        # http://localhost:3000/stores?category_id=2&ratings=true
        # http://localhost:3000/stores?search=f&commit=Search&ratings=true&category_id=2
        # http://localhost:3000/stores?category_id=1
        url_split = url.split("stores") # => ?category_id=2&ratings=true
        new_param_split = new_param.split("=") # => ["ratings","true"]
        param = new_param_split[0].to_s # => ["ratings"]
        replace = ""
        if url_split.size == 1 # no tiene params
            url + "?" + new_param # concatenamos new param
        else
            url_params = url_split[1].split(/([?&])\w+/) #sub array de parametros ej: ["category_id=2",ratings=true]
            url_params.each_with_index do |sub_array, i| # => "category_id=2"
                if sub_array[new_param] # => encontro category_id en actual params
                    replace = sub_array # => texto a remplazar
                end
            end 
            if replace.empty?
                url + "&" + new_param
            else
                url.gsub(replace, new_param)
            end        
        end 
    end


    # <%= link_to "Puntuación" , make_params(request.original_url,"ratings=true"), class: "dropdown-item"%> 
    # <%= link_to "Más cercano" , make_params(request.original_url,"near=true"), class: "dropdown-item"%> 
    # <%= link_to category.name, make_params(request.original_url, "category_id=" + category.id.to_s), class: "dropdown-item"%> 
       
end
