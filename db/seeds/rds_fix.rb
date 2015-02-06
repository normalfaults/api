# Fix the RDS storage type options
rds_type = ProductType.where(name: 'RDS').first

rds_type_question = ProductTypeQuestion.where(product_type_id: rds_type.id, label: 'Storage Type').first
rds_type_question.options = [
  %w(standard standard),
  %w(gp2 gp2),
  %w(io1 io1)
]
rds_type_question.save
