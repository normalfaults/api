# Fix the RDS storage type options
rds_type = ProductType.where(name: 'RDS').first

rds_type_question = ProductTypeQuestion.where(product_type_id: rds_type.id, label: 'Storage Type').first
rds_type_question.options = [
  %w(standard Magnetic),
  %w(gp2 SSD),
  %w(io1 IOPS)
]
rds_type_question.save
