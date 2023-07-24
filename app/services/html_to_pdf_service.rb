# frozen_string_literal: true

class HtmlToPdfService
  attr_reader :template, :object

  def initialize(template, object = {})
    @template = template
    @object = object
  end

  def perform
    controller = ActionController::Base.new
    controller.view_context_class.include(ActionView::Helpers, PdfHelper)
    pdf_html = controller.render_to_string(
      template: template, layout: 'pdf', locals: { object: object },
    )
    WickedPdf.new.pdf_from_string(pdf_html)
  end
end
