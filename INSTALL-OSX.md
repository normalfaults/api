## How to install on Mac OS X Mavericks (for Development)

This guide will walk you through how to install and run Jellyfish-API on a Mac.  Generally, this would be for
development, however you can run it in production as well.  This will setup the app to run on port 5000, if you want
it to run on a different port, you will need to use Apache or Nginx (this doc will not cover that).

#### Install the Mac command line tools:

````
xcode-select --install
````

#### Install Toughtbot Laptop Tools

````
curl --remote-name https://raw.githubusercontent.com/thoughtbot/laptop/master/mac
sh mac 2>&1 | tee ~/laptop.log
```

#### Add this data to ./.env

You will need to create this file yourself (it is already in the .gitignore),
the dotEnv gem uses this to to "create" ENVIRONMENT variables.  Alternatively,
you can simply create ENVIRONMENT vars yourself.

````
DATABASE_URL=postgres://YOUR_LOCAL_USERNAME:@localhost:5432/jellyfish
CORS_ALLOW_ORIGIN=localhost:5000
DEFAULT_URL=http://localhost:3000
````
#### Populate the database

Run the following rake commands.  You only need to run "rake sample:demo" if
you are wanting, sample data (useful for development).  Please note that this
rake task does not create the database or the database user (those will need
to be created based on the DB you are using)

````
rake db:setup
rake db:seed
rake sample:demo
````

#### Start the server (development mode)

````
rails s
````

#### Upkeep Rake Tasks

The following rake commands need to be executed to maintain Jellyfish Core.

````
# Updates the budgets for projects
rake upkeep:update_budgets

# Pull down AWS pricing (not used at the moment)
rake upkeep:get_aws_od_pricing

# Get the status of VM's from ManageIQ
rake upkeep:poll_miq_vms

# Run the delayed job workers (this is what processes the orders to the various systems
rake jobs:work
````


Copyright 2015 Booz Allen Hamilton
