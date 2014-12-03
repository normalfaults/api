module AssociationResolution
  extend ActiveSupport::Concern

  included do
    before_action :set_association_inclusions!
  end

  module ClassMethods
  end

  protected

  def model_associations
    @model_associations_symbols ||= controller_name.classify.constantize.reflect_on_all_associations.collect(&:name)
  end

  def set_association_inclusions!
    raw_inclusion = params[:includes] || []
    @association_inclusions = raw_inclusion.map(&:to_sym)
    @render_params ||= {}
    @render_params[:include] = @association_inclusions
  end

  def entity_resolution_error(e)
    format.json do
      render json: { error: e.message }
    end
  end
end
