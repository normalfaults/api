namespace :sample do
  desc 'Reset Auto Increment Ids'
  task reset: :environment do
    Alert.connection.execute('ALTER SEQUENCE alerts_id_seq RESTART 1')
    Order.connection.execute('ALTER SEQUENCE orders_id_seq RESTART 1')
    OrderItem.connection.execute('ALTER SEQUENCE order_items_id_seq RESTART 1')
    Project.connection.execute('ALTER SEQUENCE projects_id_seq RESTART 1')
    Product.connection.execute('ALTER SEQUENCE products_id_seq RESTART 1')
    Staff.connection.execute('ALTER SEQUENCE staff_id_seq RESTART 1')
  end

  desc 'Populate sample data for Jenkins'
  task jenkins: :environment do
    # Create some staff
    user_data = { last_name: 'Staff', password: 'jellyfish' }
    user = Staff.create(user_data.merge first_name: 'User', email: 'user@jellyfish.com', role: :user)
    admin = Staff.where(email: 'admin@jellyfish.com').first
    Staff.create(user_data.merge first_name: 'Unused', email: 'unused@jellyfish.com', role: :user)

    # AWS Settings
    aws_setting = Setting.where(name: 'AWS').first

    aws_setting_field = SettingField.where(setting_id: aws_setting.id, label: 'Enabled').first
    aws_setting_field.value = 'true'
    aws_setting_field.save

    aws_setting_field = SettingField.where(setting_id: aws_setting.id, label: 'Access Key').first
    aws_setting_field.value = 'AWS_ACCESS_KEY'
    aws_setting_field.save

    aws_setting_field = SettingField.where(setting_id: aws_setting.id, label: 'Secret Key').first
    aws_setting_field.value = 'AWS_SECRET_KEY'
    aws_setting_field.save

    # Manage IQ Settings
    miq_setting = Setting.where(name: 'Manage IQ').first

    miq_setting_field = SettingField.where(setting_id: miq_setting.id, label: 'URL').first
    miq_setting_field.value = 'https://manage_iq_server:3000'
    miq_setting_field.save

    miq_setting_field = SettingField.where(setting_id: miq_setting.id, label: 'Username').first
    miq_setting_field.value = 'admin'
    miq_setting_field.save

    miq_setting_field = SettingField.where(setting_id: miq_setting.id, label: 'Password').first
    miq_setting_field.value = 'smartvm'
    miq_setting_field.save

    # Create some cloud entries
    aws = Cloud.create(name: 'AWS', extra: '{}')
    Cloud.create(name: 'Azure', extra: '{}')
    Cloud.create(name: 'Rackspace', extra: '{}')

    # Load some product types
    ec2_type = ProductType.where(name: 'AWS VM').first
    rds_type = ProductType.where(name: 'RDS').first
    s3_type = ProductType.where(name: 'S3 Bucket').first

    # Create some products
    ec2_data = { description: 'Product description', service_type_id: 8, service_catalog_id: 1, chef_role: '--CHEF-ROLE--', options: {}, cloud: aws, active: true, product_type: ec2_type, img: 'products/aws_ec2.png' }
    ec2_questions = [
      ProductTypeQuestion.where(product_type: ec2_type, manageiq_key: 'instance_size').first,
      ProductTypeQuestion.where(product_type: ec2_type, manageiq_key: 'disk_size').first
    ]
    ec2_products = [
      ['Small', 'Small EC2 Instance', 1.99, 0.001, 0.05, ['t2.micro', '20']],
      ['Medium', 'Medium EC2 Instance', 2.99, 0.0025, 0.075, ['m3.medium', '40']],
      ['Large', 'Large EC2 Instance', 3.99, 0.0055, 0.12, ['m3.large', '80']]
    ].map do |row|
      data = {
        name: row[0],
        description: row[1],
        setup_price: row[2],
        hourly_price: row[3],
        monthly_price: row[4],
        answers_attributes: [
          { product_type_question_id: ec2_questions[0].id, answer: row[5][0] },
          { product_type_question_id: ec2_questions[1].id, answer: row[5][1] }
        ]
      }
      Product.create(ec2_data.merge data)
    end

    rds_data = { description: 'Product description', service_type_id: 3, service_catalog_id: 1, chef_role: '--CHEF-ROLE--', options: {}, cloud: aws, active: true, product_type: rds_type, img: 'products/aws_rds.png' }
    rds_questions = [
      ProductTypeQuestion.where(product_type: rds_type, manageiq_key: 'instance_size').first,
      ProductTypeQuestion.where(product_type: rds_type, manageiq_key: 'db_engine').first,
      ProductTypeQuestion.where(product_type: rds_type, manageiq_key: 'disk_size').first,
      ProductTypeQuestion.where(product_type: rds_type, manageiq_key: 'storage_type').first
    ]
    rds_products = [
      ['Small MySQL', 'Small MySQL', 0.99, 0.001, 0.05, ['db.m3.medium', 'mysql', '20', 'magnetic']],
      ['Medium MySQL', 'Medium MySQL', 1.99, 0.004, 0.1, ['db.m3.medium', 'mysql', '40', 'magnetic']],
      ['Medium PostgreSQL', 'Medium PostgreSQL', 2.99, 0.004, 0.25, ['db.m3.medium', 'posgresql', '40', 'ssd']],
      ['Large PostgreSQL', 'Large PostgreSQL', 3.99, 0.009, 0.50, ['db.m3.large', 'postgresql', '120', 'ssd']],
      ['Medium Aurora', 'Medium Aurora', 4.99, 0.015, 0.95, ['db.m3.medium', 'aurora', '40', 'magnetic']],
      ['Large SQL Server', 'Large SQL Server', 5.99, 0.025, 1.29, ['db.m3.xlarge', 'sqlserver', '120', 'ssd']]
    ].map do |row|
      data = {
        name: row[0],
        description: row[1],
        setup_price: row[2],
        hourly_price: row[3],
        monthly_price: row[4],
        answers_attributes: [
          { product_type_question_id: rds_questions[0].id, answer: row[5][0] },
          { product_type_question_id: rds_questions[1].id, answer: row[5][1] },
          { product_type_question_id: rds_questions[2].id, answer: row[5][2] },
          { product_type_question_id: rds_questions[3].id, answer: row[5][3] }
        ]
      }
      Product.create(rds_data.merge data)
    end

    s3_data = { description: 'Product description', service_type_id: 5, service_catalog_id: 1, chef_role: '--CHEF-ROLE--', options: {}, cloud: aws, active: true, product_type: s3_type, img: 'products/aws_s3.png' }
    s3_questions = [
      ProductTypeQuestion.where(product_type: s3_type, manageiq_key: 'availability').first,
      ProductTypeQuestion.where(product_type: s3_type, manageiq_key: 'region').first
    ]
    s3_products = [
      ['Standard Storage', 'Normal, US-Standard', 0.99, 0.001, 0.05, ['normal', '']],
      ['West Coast Storage', 'Normal, Northern California', 0.99, 0.001, 0.05, ['normal', 'us-west-1']],
      ['West Coast Storage', 'Normal, Oregon', 0.99, 0.001, 0.05, ['normal', 'us-west-2']],
      ['Reduced Storage', 'Reduced, US-Standard', 0.99, 0.0001, 0.005, ['reduced', '']],
      ['West Coast Storage', 'Reduced, Northern California', 0.99, 0.0001, 0.005, ['reduced', 'us-west-1']],
      ['West Coast Storage', 'Reduced, Oregon', 0.99, 0.0001, 0.005, ['reduced', 'us-west-2']]
    ].map do |row|
      data = {
        name: row[0],
        description: row[1],
        setup_price: row[2],
        hourly_price: row[3],
        monthly_price: row[4],
        answers_attributes: [
          { product_type_question_id: s3_questions[0].id, answer: row[5][0] },
          { product_type_question_id: s3_questions[1].id, answer: row[5][1] }
        ]
      }
      Product.create(s3_data.merge data)
    end

    # Create some projects
    starts = DateTime.now
    ends = starts + 9.months
    project_data = { description: 'Project description', cc: '--CC--', staff_id: '--STAFF_ID--', budget: 123_654, spent: 0.0, start_date: starts, end_date: ends }

    project = Project.create(project_data.merge name: 'Project 1', approved: false)
    approved_project = Project.create(project_data.merge name: 'Mobile App API', approved: true)
    website_project = Project.create(project_data.merge name: 'Blog', approved: true)
    files_project = Project.create(project_data.merge name: 'Cloud File Share', approved: true)

    # Add some staff
    StaffProject.create(staff: user, project: project)
    StaffProject.create(staff: user, project: approved_project)

    # Apply some approvals
    Approval.create(project: project, staff: user, approved: false)
    Approval.create(project: approved_project, staff: user, approved: true)

    # Create some orders
    order_data = { options: {}, staff: admin }
    order_item_data = { provision_status: :pending, cloud: aws }

    # Approved project
    Order.create(order_data.merge(
        order_items_attributes: [
          order_item_data.merge(product: ec2_products[0], project: approved_project),
          order_item_data.merge(product: ec2_products[0], project: approved_project),
          order_item_data.merge(product: rds_products[2], project: approved_project),
          order_item_data.merge(product: s3_products[0], project: approved_project)
        ]
      )
    )

    # Blog project
    Order.create(order_data.merge(
        order_items_attributes: [
          order_item_data.merge(product: ec2_products[1], project: website_project),
          order_item_data.merge(product: ec2_products[1], project: website_project),
          order_item_data.merge(product: ec2_products[1], project: website_project),
          order_item_data.merge(product: rds_products[1], project: website_project)
        ]
      )
    )

    # Cloud share project
    Order.create(order_data.merge(
        order_items_attributes: [
          order_item_data.merge(product: ec2_products[1], project: files_project),
          order_item_data.merge(product: ec2_products[1], project: files_project),
          order_item_data.merge(product: rds_products[3], project: files_project),
          order_item_data.merge(product: s3_products[0], project: files_project),
          order_item_data.merge(product: s3_products[1], project: files_project)
        ]
      )
    )
  end
end
