require 'mercadopago'


class GenerateMercadopagoPreferenceService
    attr_reader :shopping_cart

    def initialize(shopping_cart)
        # TODO hacer que esta ENV la levante de otro lado
        @sdk = Mercadopago::SDK.new('TEST-754353421681918-022407-d1cca2f6e8596ec7aa012bed6fc37904-593048532')
        @shopping_cart = shopping_cart
    end

    def call
        preference_response = @sdk.preference.create(create_preference_data)
        preference = preference_response[:response]
        preference_id = preference['id']
    end

    private

    def create_preference_data
        preference_data = {
            items: [
              {
                # TODO ver si el titulo puede ser varios datos concatenados, 
                # o si existe alguna opcion para poner el detalle, y ahi mandar info del pedido
                # como Nombre, direccion, nombre del local, etc (como la factura de pedidos ya)

                title: 'Mi pedido',
                unit_price: @shopping_cart.total_price.to_f, 
                quantity: 1
              }
            ],
            payment_methods: {
              excluded_payment_types: [ #excluye opcion pagofacil/rapipago
                { id: 'ticket' }
            ]},
            back_urls: {
              success: 'http://localhost:3000/success',
              failure: 'https://www.tu-sitio/failure',
              pending: 'https://www.tu-sitio/pendings'
            },
            auto_return: 'approved'
        }   
     
        # Datos que retorna MP
        # http://localhost:3000/?collection_id=1312826943
        # &collection_status=approved
        # &payment_id=1312826943
        # &status=approved
        # &external_reference=null
        # &payment_type=credit_card
        # &merchant_order_id=7932643329
        # &preference_id=593048532-5abba113-b5c9-47b5-8e3d-eb827d669c52
        # &site_id=MLA
        # &processing_mode=aggregator
        # &merchant_account_id=null
      
    end
end 
