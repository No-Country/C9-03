class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.receipt.subject
  #
  def receipt(order, my_hash)
    @order = order
    @user = order.user
    @my_hash = my_hash
    
    line_items = order.line_items.map do |li|
      [li.food.name, li.price.to_f, li.quantity, li.price.to_f * li.quantity, li.food.store.name]
    end

    r = Receipts::Receipt.new(
      details: [
        ["Identificador de pago", @my_hash["id"]],
        ["Fecha de pago", @order.created_at.to_s],
        ["Método de Pago", @my_hash["payment_method_types"][0]]
      ],
      company: {
        name: "Yendo SA",
        address: "En algún lugar de Palermo",
        email: "soporte@yendo.com",
        logo: File.expand_path("app/assets/images/logo-md.png")
      },
      recipient: [
        ["Nombre:", @my_hash["customer_details"]["name"]],
        nil,
        ["Dirección de Correo:", @my_hash["customer_details"]["email"]],
      ],
      line_items: line_items + [
        ["Subtotal", @my_hash["amount_subtotal"]],
        ["Impuestos", @my_hash["total_details"]["amount_tax"]],
        ["Descuentos", @my_hash["total_details"]["amount_discount"]],
        ["Envío", "180$"],
        ["Total", @my_hash["amount_total"]],
        ["<b>Monto pagado:</b>", @my_hash["amount_total"].to_i + 180]
      ],
      footer: "Thanks for your business. Please contact us if you have any questions."
    )

    pdf = r.render
    attachments['receipt.pdf'] = pdf

    mail(to: "to@example.org", subject: "Receipt")
      end
end
