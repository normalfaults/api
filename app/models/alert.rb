# == Schema Information
#
# Table name: alerts
#
#  id            :integer          not null, primary key
#  project_id    :integer
#  staff_id      :integer
#  status        :string(20)
#  message       :text
#  start_date    :datetime
#  end_date      :datetime
#  created_at    :datetime
#  updated_at    :datetime
#  order_item_id :integer
#
# Indexes
#
#  index_alerts_on_end_date    (end_date)
#  index_alerts_on_start_date  (start_date)
#  index_order_item_id         (order_item_id)
#

class Alert < ActiveRecord::Base
  belongs_to :order_item, inverse_of: :alerts
  belongs_to :project

  scope :active, -> { where('(alerts.start_date <= NOW() OR alerts.start_date IS NULL) AND (alerts.end_date >= NOW() OR alerts.end_date IS NULL)') }
  scope :inactive, -> { where('end_date < NOW() OR start_date > NOW()') }
  scope :latest, -> { joins(:order_item).where('alerts.id = order_items.latest_alert_id') }
  scope :not_status, ->(status) { where('alerts.status != ?', status) }
  scope :newest_first, -> { order('updated_at DESC') }
  scope :oldest_first, -> { order(:updated_at) }
  scope :project_order, -> { order(:project_id) }

  after_commit :cache_alert_data, on: [:create, :update]

  def cache_alert_data
    order_item.update_attributes latest_alert_id: id
    project.compute_current_status!
  end
end
