namespace :secret do
  desc 'Scan code for possible credentials'
  task scan: :environment do
    matches = SecretScanner.scan_dirs('.')
    unless matches.empty?
      puts '***                                   ***'
      puts '*** Possible credentials in code      ***'
      puts '***                                   ***'
      puts matches
      exit(1)
    end
  end
end
