module AssociationResolution
  class Exception < StandardError
  end

  extend ActiveSupport::Concern

  included do
    rescue_from AssociationResolution::Exception, with: :entity_resolution_error
    before_action :set_association_inclusions!
  end

  module ClassMethods
  end

  def respond_with_resolved_associations(item)
    respond_with do |format|
      format.json do
        render json: item, include: @association_inclusions
      end
    end
  end

  protected

  def model_associations
    @model_associations_symbols ||= controller_name.classify.constantize.reflect_on_all_associations.collect(&:name)
  end

  def set_association_inclusions!
    raw_inclusion = params[:include] || []
    @association_inclusions = raw_inclusion.map(&:to_sym)
    @association_inclusions.each { |inclusion| fail AssociationResolution::Exception "Invalid include param: #{inclusion}" unless model_associations.include?(inclusion) }
  end

  def entity_resolution_error(e)
    format.json do
      render json: { error: e.message }
    end
  end
end
