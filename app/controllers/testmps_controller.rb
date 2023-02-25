require 'mercadopago'


class TestmpsController < ApplicationController
  before_action :set_testmp, only: %i[ show edit update destroy ]

  # GET /testmps or /testmps.json
  def index
    sdk = Mercadopago::SDK.new('TEST-754353421681918-022407-d1cca2f6e8596ec7aa012bed6fc37904-593048532')
    @total_price = ShoppingCart.first.total_price
    @testmps = Testmp.all

    preference_data = {
      items: [
        {
          title: 'Mi pedido',
          unit_price: @total_price.to_f,
          quantity: 1
        }
      ],
      payment_methods: {
        excluded_payment_types: [ #excluye opcion pagofacil/rapipago
          { id: 'ticket' }
        ]},
        
        shipments:{#permite especificar el costo de envio en mp
            cost: 180,
            mode: "not_specified",
        },
        # back_urls = {
        #   success: 'https://www.tu-sitio/success',
        #   failure: 'https://www.tu-sitio/failure',
        #   pending: 'https://www.tu-sitio/pendings'
        # },
        # auto_return: 'approved'
      
    }
    preference_response = sdk.preference.create(preference_data)
    preference = preference_response[:response]
    
    # Este valor reemplazará el string "<%= @preference_id %>" en tu HTML
    @preference_id = preference['id']
  end

  # GET /testmps/1 or /testmps/1.json
  def show
  end

  # GET /testmps/new
  def new
    @testmp = Testmp.new
  end

  # GET /testmps/1/edit
  def edit
  end

  # POST /testmps or /testmps.json
  def create
    @testmp = Testmp.new(testmp_params)

    respond_to do |format|
      if @testmp.save
        format.html { redirect_to testmp_url(@testmp), notice: "Testmp was successfully created." }
        format.json { render :show, status: :created, location: @testmp }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @testmp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /testmps/1 or /testmps/1.json
  def update
    respond_to do |format|
      if @testmp.update(testmp_params)
        format.html { redirect_to testmp_url(@testmp), notice: "Testmp was successfully updated." }
        format.json { render :show, status: :ok, location: @testmp }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @testmp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /testmps/1 or /testmps/1.json
  def destroy
    @testmp.destroy

    respond_to do |format|
      format.html { redirect_to testmps_url, notice: "Testmp was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_testmp
      @testmp = Testmp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def testmp_params
      params.fetch(:testmp, {})
    end
end
