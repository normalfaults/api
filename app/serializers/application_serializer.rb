class ApplicationSerializer < ActiveModel::Serializer
  def include_associations!
    return unless @options[:include].present?

    @options.delete(:include).each_pair do |association, includes|
      include! association, :include => includes
    end
  end
end
