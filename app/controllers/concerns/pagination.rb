module Pagination
  PER_PAGE_DEFAULT = 10

  extend ActiveSupport::Concern

  included do
    attr_reader :render_params
    before_action :gather_pagination_params!
  end

  module ClassMethods
  end

  def gather_pagination_params!
    @pagination_params = {}
    @pagination_params[:page] = params[:page]
    unless @pagination_params[:page].nil?
      @pagination_params[:per_page] = params[:per_page]
      @pagination_params[:per_page] ||= PER_PAGE_DEFAULT
    end
  end

  def query_with_pagination(query)
    @pagination_params[:page].nil? ? query : query.paginate(@pagination_params)
  end
end
