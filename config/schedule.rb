# Use this file to easily define all of your cron jobs.

# Learn more: http://github.com/javan/whenever

set :output, 'log/cron.log'

every 1.minute do
  rake 'upkeep:prune_alerts'
end
