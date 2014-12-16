namespace :upkeep do
  desc 'Removes alerts older than 1 year.'
  task prune_alerts: :environment do
    Alert.destroy_all(['created_at < ?', 365.days.ago])
  end
end
