class StoresController < ApplicationController
    before_action :set_store, only: %i[show avg]

    def index
        @stores = Store.all
        @categories = Category.all
        @stores = @stores.includes(:foods).filter_by_search(params[:search]).references(:foods) if params[:search].present?
        @stores = @stores.filter_by_category(params[:category_id]) if params[:search].present? && params[:category_id].present?
        @stores = @stores.where("category_id = ?", params[:category_id]) if params[:category_id].present?
        @stores = @stores.order(average: :desc) if params[:ratings].present?
        
    end
    
    def show 

        @latitude = @store.location.latitude
        @longitude = @store.location.longitude

    end

    # Al pasar un objeto de Location nos devuelve los locales dentro del radio especificado
    def distance_order(location_object) 
        @locations = location_object.nearbys(5)
        @stores = []
        @locations.each do |obj|
            @stores << Store.where(id: obj.store_id)
        end
        render json: @stores, only: [:name, :category_id] ,  include: {location: {only: :street}}
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
