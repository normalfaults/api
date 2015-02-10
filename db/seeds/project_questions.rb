# Create some questions
question_data = { field_type: 'text', help_text: '', options: '[]', required: true }
# ProjectQuestion.create(question_data.merge question: 'Project Name')
ProjectQuestion.create(question_data.merge question: 'Project Description')
ProjectQuestion.create(question_data.merge question: 'Project Charge Code')
# ProjectQuestion.create(question_data.merge question: 'Initial Budget')
ProjectQuestion.create(question_data.merge question: 'FISMA Classification', field_type: 'select_option', options: "[\"Low\",\"Medium\", \"High\"]")
