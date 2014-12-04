if ENV['MANAGEIQ_HOST']
  ManageIQClient.host = ENV['MANAGEIQ_HOST']
  ManageIQClient.verify_ssl = ENV['MANAGEIQ_SSL'].nil? ? true : !ENV['MANAGEIQ_SSL'].to_i.zero?
  if ENV['MANAGEIQ_USER'] && ENV['MANAGEIQ_PASS']
    ManageIQClient.credentials = { user: ENV['MANAGEIQ_USER'], password: ENV['MANAGEIQ_PASS'] }
  end
end
