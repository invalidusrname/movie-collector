# frozen_string_literal: true

module TemplateHelper
  def render_or_default(partial, default = partial)
    render(partial:)
  rescue ActionView::MissingTemplate
    begin
      render partial: "layouts/#{default}"
    rescue ActionView::MissingTemplate
      nil
    end
  end
end
