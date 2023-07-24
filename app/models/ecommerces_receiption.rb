require 'render_anywhere'

class EcommercesReceiption
  attr_reader :order

  include RenderAnywhere

  def initialize(order)
    @order = order
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A4')
    kit.to_file("#{Rails.root}/tmp/ecommerces_receiption_#{Time.zone.now.to_i}.pdf")
  end

  def filename
    "Receiption #{order.code}.pdf"
  end

  private

  def as_html
    ApplicationController.render template: 'ecommerces/receiptions/pdf', layout: 'ecommerces/receiption_pdf',
                                 locals: { order: order }
  end
end
