class StoresController < ApplicationController
    before_action :set_store, only: %i[show avg]

    def index

        @categories = Category.all
        @stores = Store.all

        # @stores = order_by_distance if params[:near].present? && params[:near] == "true"

        @stores = Store.includes(:foods).where("stores.name ILIKE :search OR foods.name ILIKE :search", 
            search: "%#{params[:search]}%").references(:foods) if params[:search].present?

        @stores = @stores.where("category_id = ?", params[:category_id]) if params[:category_id].present?

        @stores = @stores.order(average: :desc) if params[:ratings].present?

        

        if params[:near].present?
            if params[:near] == "true"
                distance_order(Location.find(current_user.location_id).street)
                # @stores = Store.where(
                # @stores = @stores.order(:location :asc)

                # near = Location.near(street,999).where("store_id  IS NOT NULL")
                # stores = Store.includes(:location).references(:location).merge(near)
                # ids = []
                # stores.each do |ele|
                #     ids << ele.id
                # end
                # @stores = Store.where(id: ids).in_order_of(:id, ids)
                    #
                # l = Location.near(Location.first.street,9999).joins(:store).preload(:store)

                

            end
        end

        # if params[:search].present?
        #     @stores = Store.includes(:foods).where("stores.name ILIKE :search OR foods.name ILIKE :search", search: "%#{params[:search]}%").references(:foods)
        #     if params[:category_id].present?
        #         @stores = Store.includes(:foods).where("stores.name ILIKE :search OR foods.name ILIKE :search", search: "%#{params[:search]}%").references(:foods).where("category_id = ?", params[:category_id])
        #         if params[:ratings].present?
        #             @stores = @stores.order(average: :desc)
        #         end
        #     elsif params[:ratings].present?
        #         if params[:category_id].present?
        #             @stores = Store.includes(:foods).where("stores.name ILIKE :search OR foods.name ILIKE :search", search: "%#{params[:search]}%").references(:foods).where("category_id = ?", params[:category_id])
        #         end    
        #         @stores = @stores.order(average: :desc)
        #     end
        # elsif params[:ratings].present?
        #     @stores = Store.all
        #     if params[:category_id].present?
        #         @stores = Store.includes(:foods).where("stores.name ILIKE :search OR foods.name ILIKE :search", search: "%#{params[:search]}%").references(:foods).where("category_id = ?", params[:category_id])
        #     end
        #     @stores = @stores.order(average: :desc)
        # elsif params[:category_id].present? #si encuentra parametros de categoria mostrará los que se corresponda
        #     @stores = Store.where("category_id = ?", params[:category_id])
        #     if params[:ratings].present?
        #         @stores = @stores.order(average: :desc)
        #     end
        # if params[:near].present?
        #     if params[:near] == "true"
        #         distance_order(Location.find(current_user.location_id).street)
        #         # @stores = Store.where(
        #         # @stores = @stores.order(:location :asc)
        #     end
        # else
        #     # @stores = Store.all
            # if params[:ratings].present?
            #     @stores = @stores.order(average: :desc)
            # end
    #     end
    end
    
    def show 

    end

 

    def distance_order(street) # Al pasar un objeto de Location nos devuelve los locales dentro del radio especificado
        near = Location.near(street,999).where("store_id  IS NOT NULL")
        stores = Store.includes(:location).references(:location).merge(near)
        ids = []
        stores.each do |ele|
            ids << ele.id
        end
        @stores = Store.where(id: ids).in_order_of(:id, ids)
        #@stores = Store.where("id in (SELECT store_id FROM location_object.nearbys(999) where a = ?)", 3)
        # @stores = []
        # @locations.each do |obj|
        #    @stores = Store.where(id: obj.store_id)#, only: [:name, :category_id], include: {address: {only: :street}}
        # end
        # @stores
    end

    # def avg
    #     @avg = (store.ratings.sum.to_f/store.ratings.size)
    # end

    # helper_method :avg

    private


    def order_by_distance
        # Location del usuario
        #user_location = Location.find(current_user.location_id).street.to_s

        # Lista de locations ordenados por distancia
        # near = Location.near(street,999).where("store_id  IS NOT NULL")
        l = Location.near('Av. Cabildo 4500, CABA',9999).where("store_id IS NOT NULL")

        # trae los stores de la lista de locations, respetando el orden
        Store.where(id: l.ids).in_order_of(:id, l.ids)

    #ids_stores = l.ids # Paso que se puede omitir

    end
    
    def set_store
        @store = Store.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Could not find any store with ID '#{params[:id]}'" }
    end

    def stores_params
        params.require(:store).permit(:search)
    end
end
