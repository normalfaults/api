module RenderWithParams
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
  end

  def respond_with_params(item, r_params = {})
    @render_params ||= {}
    @render_params.merge! r_params
    @render_params[:json] = item

    respond_with do |format|
      format.json do
        render @render_params
      end
    end
  end
end
