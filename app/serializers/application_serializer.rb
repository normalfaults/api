class ApplicationSerializer < ActiveModel::Serializer
  def include_associations!
    return unless @options[:include].present?

    inclusions = @options.delete(:include)

    inclusions.each_pair do |association, includes|
      include! association, include: includes
    end

    # Put the includes back; Important if an array is being returned with includes
    @options[:include] = inclusions
  end
end
