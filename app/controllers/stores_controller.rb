class StoresController < ApplicationController
    before_action :set_store, only: %i[show avg]

    def index
        @categories = Category.all
        if params[:search].present?
            @stores = Store.includes(:foods).where("stores.name ILIKE :search OR foods.name ILIKE :search", search: "%#{params[:search]}%").references(:foods)
            if params[:category_id].present?
                @stores = Store.includes(:foods).where("stores.name ILIKE :search OR foods.name ILIKE :search", search: "%#{params[:search]}%").references(:foods).where("category_id = ?", params[:category_id])
                if params[:ratings].present?
                    @stores = @stores.order(average: :desc)
                end
            elsif params[:ratings].present?
                if params[:category_id].present?
                    @stores = Store.includes(:foods).where("stores.name ILIKE :search OR foods.name ILIKE :search", search: "%#{params[:search]}%").references(:foods).where("category_id = ?", params[:category_id])
                end    
                @stores = @stores.order(average: :desc)
            end
        elsif params[:ratings].present?
            @stores = Store.all
            if params[:category_id].present?
                @stores = Store.includes(:foods).where("stores.name ILIKE :search OR foods.name ILIKE :search", search: "%#{params[:search]}%").references(:foods).where("category_id = ?", params[:category_id])
            end
            @stores = @stores.order(average: :desc)
        elsif params[:category_id].present? #si encuentra parametros de categoria mostrará los que se corresponda
            @stores = Store.where("category_id = ?", params[:category_id])
            if params[:ratings].present?
                @stores = @stores.order(average: :desc)
            end
        # elsif params[:near].present?
        #     if params[:near] == "true"
        #         distance_order(Address.second)
        #     end
        else
            @stores = Store.all
            if params[:ratings].present?
                @stores = @stores.order(average: :desc)
            end
        end
    end

    
    def show
        render json: @store, :include => [:address, :foods], status: :ok
    end

    def distance_order(address_object) # Al pasar un pbjeto de Address nos devuelve los locales dentro del radio especificado
        @addresses = address_object.nearbys(5)
        @stores = []
        @addresses.each do |obj|
            @stores << Store.where(id: obj.store_id)#, only: [:name, :category_id], include: {address: {only: :street}}
        end
        render json: @stores, only: [:name, :category_id] ,  include: {address: {only: :street}}
    end

    def avg
        @avg = (store.ratings.sum.to_f/store.ratings.size)
    end

    helper_method :avg

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
