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
    @pagination_params[:per_page] = params[:per_page]
    @pagination_params[:per_page] ||= PER_PAGE_DEFAULT
  end

  def query_with_pagination(query)
    query.paginate(@pagination_params)
  end
end
