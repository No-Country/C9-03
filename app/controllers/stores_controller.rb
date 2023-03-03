class StoresController < ApplicationController
    before_action :set_store, only: %i[show]

    def index
        @stores = Store.all
        @categories = Category.all

        if params[:near].present?
            if params[:near] == "true"
                @stores = distance_order(Location.find(current_user.location_id).street)
            end
        end
        @stores = @stores.includes(:foods).where("stores.name ILIKE :search OR foods.name ILIKE :search", search: "%#{params[:search]}%").references(:foods) if params[:search].present?
        @stores = @stores.filter_by_category(params[:category_id]) if params[:category_id].present?
        @stores = @stores.order(average: :desc) if params[:ratings].present?
    end
    
    def show 

        @latitude = @store.location.latitude
        @longitude = @store.location.longitude

    end

    # Al pasar un objeto de Location nos devuelve los locales dentro del radio especificado
    def distance_order(location) 
        near = Location.near(location,999).where("store_id IS NOT NULL")
        stores = Store.includes(:location).references(:location).merge(near)
        ids = []
        stores.each do |ele|
            ids << ele.id
        end
        @stores = Store.where(id: ids).in_order_of(:id, ids)
    end

    private
    
    def set_store
        @store = Store.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Could not find any store with ID '#{params[:id]}'" }
    end

    def stores_params
        params.require(:store).permit(:search)
    end
end
