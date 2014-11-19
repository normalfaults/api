# Default module
module ApplicationHelper
  def resource_name
    :staff
  end

  def resource
    @resource ||= Staff.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:staff]
  end
end
