Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', "#{Rails.env}.log"))
