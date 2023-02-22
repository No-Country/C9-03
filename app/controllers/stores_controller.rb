class StoresController < ApplicationController
    before_action :set_store, only: %i[show]

    def index

        if params[:name].present? #si encuentra parametros de :name mostrará los que se correspondan
            @stores = Store.where("name LIKE ?", Store.sanitize_sql_like(params[:name]) + "%")
            render json: @stores, only: [:name, :category_id], include: {location: {only: :street}}
        elsif params[:category_id].present? #si encuentra parametros de categoria mostrará los que se corresponda
            @stores = Store.where("category_id = ?", params[:category_id])
            render json: @stores, only: [:name, :category_id] ,  include: {location: {only: :street}}
        elsif params[:near].present?
            if params[:near] == "true"
                distance_order(Location.second)
            end
        else
            @stores = Store.all#json: Store.all, only: [:name, :category_id], include: {address: {only: :street}}
        end
    end

    def show
        render json: @store, :include => [:location, :foods], status: :ok
    end

    def distance_order(location_object) # Al pasar un objeto de Location nos devuelve los locales dentro del radio especificado
        @locations = location_object.nearbys(5)
        @stores = []
        @locations.each do |obj|
            @stores << Store.where(id: obj.store_id)#, only: [:name, :category_id], include: {address: {only: :street}}
        end
        render json: @stores, only: [:name, :category_id] ,  include: {location: {only: :street}}
    end

    private
    
    def set_store
        @store = Store.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Could not find any store with ID '#{params[:id]}'" }
    end
end
