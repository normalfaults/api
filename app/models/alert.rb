class Alert < ActiveRecord::Base
  after_commit :update_order_item, on: [:create, :update]
  belongs_to :order_item
  belongs_to :project
  scope :active, -> { where('(alerts.start_date <= NOW() OR alerts.start_date IS NULL) AND (alerts.end_date >= NOW() OR alerts.end_date IS NULL)') }
  scope :recent, -> { joins('INNER JOIN (SELECT MAX(a3.id) AS id FROM alerts a3 GROUP BY order_item_id) a2 ON alerts.id = a2.id') }
  scope :not_status, ->(status) { where('alerts.status != ?', status) }

  def update_order_item
    order_item.update_attribute(:latest_alert_id, id)
    project_status = :ok
    order_item.project.latest_alerts.each do |latest_alert|
      new_status = latest_alert.status
      case new_status
      when 'OK'
        project_status = new_status unless [:pending, :unknown, :warning, :critical].include? project_status
      when 'PENDING'
        project_status = new_status unless [:warning, :critical].include? project_status
      when %w(UNKNOWN WARNING)
        project_status = :warning unless project_status == :critical
      when 'CRITICAL'
        project_status = new_status
      else
        project_status = :unknown
      end
    end
    order_item.project.update_attribute(:status, project_status.downcase)
  end
end
