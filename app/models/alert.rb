class Alert < ActiveRecord::Base
  belongs_to :order_item, inverse_of: :alerts
  belongs_to :project

  scope :active, -> { where('(alerts.start_date <= NOW() OR alerts.start_date IS NULL) AND (alerts.end_date >= NOW() OR alerts.end_date IS NULL)') }
  scope :inactive, -> { where('end_date < NOW() OR start_date > NOW()') }
  scope :latest, -> { joins(:order_item).where('alerts.id = order_items.latest_alert_id') }
  scope :not_status, ->(status) { where('alerts.status != ?', status) }
  scope :newest_first, -> { order('updated_at DESC') }
  scope :oldest_first, -> { order('updated_at') }

  after_commit :cache_alert_data, on: [:create, :update]

  def cache_alert_data
    order_item.update_attributes latest_alert_id: id
    project.compute_current_status!
  end
end
