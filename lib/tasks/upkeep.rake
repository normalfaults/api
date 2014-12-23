namespace :upkeep do
  desc 'Removes alerts older than 1 year.'
  task prune_alerts: :environment do
    Alert.destroy_all(['created_at < ?', 365.days.ago])
  end

  desc 'Show all alerts'
  task show_all_alerts: :environment do
    alerts = Alert.all.order('created_at ASC')
    alerts.each do |alert|
      Alert.new.attributes.keys.each { |attr| puts alert.to_s + ' ' + attr + ': ' + alert[attr].to_s }
      puts "\n"
    end
  end

  desc 'Show active alerts'
  task show_active_alerts: :environment do
    @alerts = Alert.where('(start_date IS NULL OR start_date <= ?) AND (end_date IS NULL OR end_date > ?)', DateTime.now, DateTime.now).order('created_at ASC')
    alerts.each do |alert|
      Alert.new.attributes.keys.each { |attr| puts alert.to_s + ' ' + attr + ': ' + alert[attr].to_s }
      puts "\n"
    end
  end

  desc 'Show inactive alerts'
  task show_inactive_alerts: :environment do
    @alerts = Alert.where('end_date < ? OR start_date > ?', DateTime.now, DateTime.now).order('created_at ASC')
    alerts.each do |alert|
      Alert.new.attributes.keys.each { |attr| puts alert.to_s + ' ' + attr + ': ' + alert[attr].to_s }
      puts "\n"
    end
  end

  desc 'Poll MIQ VMS'
  task poll_miq_vms: :environment do
    # setup metadata
    vm_list = ManageIQClient::VirtualMachine.list
    miq_path = ManageIQClient.host + ManageIQClient::VirtualMachine.path + '/'

    # get the ids of each resource
    resource_ids = []
    unless vm_list['resources'].nil?
      vm_list['resources'].each do |resource_path|
        if resource_path['href'].index(miq_path) == 0
          resource_id = resource_path['href'][miq_path.length, resource_path['href'].length].to_i
          resource_ids << resource_id
        end
      end
      resource_ids = resource_ids.sort
    end

    # poll each vm and create alerts for power off state
    resource_ids.each do |resource_id|
      vm_info = ManageIQClient::VirtualMachine.find resource_id
      message_status = (vm_info[:power_state] == 'on') ? 'OK' : 'WARNING'
      message = message_status + ': ' + 'The VM resource with ID ' + resource_id.to_s + " is in the '" + vm_info[:power_state] + "' state."
      @alert_params = { project_id: '0', staff_id: '0', order_id: resource_id, status: message_status, message: message, start_date: Time.now.to_s }
      conditions = { project_id: @alert_params[:project_id], order_id: @alert_params[:order_id], status: @alert_params[:status] }
      result = Alert.where(conditions).order('updated_at DESC').first
      @alert_id = (result.nil? || result.id.nil?) ? nil : result.id
      if @alert_id.nil? # CAN CREATE AS NEW
        result = Alert.new @alert_params
      else # UPDATE THE ATTRIBUTE - UPDATE ID
        result.update_attributes @alert_params
      end
      result.save
      puts message
    end
  end
end
