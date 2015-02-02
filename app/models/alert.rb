class Alert < ActiveRecord::Base
  has_one :order_item
  belongs_to :project
  scope :active, -> { where('(alerts.start_date <= NOW() OR alerts.start_date IS NULL) AND (alerts.end_date >= NOW() OR alerts.end_date IS NULL)') }
  scope :recent, -> { joins('INNER JOIN (SELECT MAX(a3.id) AS id FROM alerts a3 GROUP BY order_item_id) a2 ON alerts.id = a2.id') }
end
