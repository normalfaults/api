# Create some questions
question_data = { field_type: 'text', help_text: '', options: '[]', required: true }
# ProjectQuestion.create(question_data.merge question: 'Project Name')
ProjectQuestion.create(question_data.merge question: 'Project Description')
ProjectQuestion.create(question_data.merge question: 'Project Charge Code')
ProjectQuestion.create(question_data.merge question: 'Maintenance Day', field_type: 'date')
ProjectQuestion.create(question_data.merge question: 'Performed Maintenance', field_type: 'check_box')
# ProjectQuestion.create(question_data.merge question: 'Initial Budget')
ProjectQuestion.create(question_data.merge question: 'Default provisioning location', field_type: 'select_option', options: "[\"East Coast Data Center\",\"West Coast Data Center\", \"Classified Data Center\"]")
ProjectQuestion.create(question_data.merge question: 'Will this run in production?', field_type: 'select_option', options: "[\"Yes\",\"No\"]")
ProjectQuestion.create(question_data.merge question: 'FISMA Classification', field_type: 'select_option', options: "[\"Low\",\"Medium\", \"High\"]")
