# Use this file to easily define all of your cron jobs.

# Learn more: http://github.com/javan/whenever

set :output, 'log/cron.log'
job_type :upkeep_cron, 'cd :path && :environment_variable=:environment :task :output'
every 1.day do
  rake 'upkeep:prune_alerts'
end
