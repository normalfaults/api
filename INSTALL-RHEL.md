## How to install on Mac OS X Mavericks

This guide will walk you through how to install and run Jellyfish-Core on RedHat Enterprise Linux (or similar,
like CentOS).

###Setup user
This will create the user that will be *for what exactly?*

######Create jellyfish user
````
$ sudo useradd jellyfish
````

###Prerequisites
This will install all of the software that is needed to compile, install and/or clone all of the software packages needed to run jellyfish-core.

######Installation prerequisites
````
$ sudo yum install git
$ sudo yum install gcc-c++ patch readline readline-devel zlib zlib-devel
$ sudo yum install libyaml-devel libffi-devel openssl-devel make
$ sudo yum install bzip2 autoconf automake libtool bison iconv-devel
$ sudo yum install sqlite-devel
````

###PostgreSQL 9.3+
This will install the PostgreSQL 9.3+ database software needed for jellyfish-core.

* <ruby><rt><h2>Documentation for 9.3+ is located at http://www.postgresql.org/download/linux/redhat/#yum</h2></rt></ruby>
* <ruby><rt><h3>(Don't use `yum install postgresql-server` for RHEL 6.x. This will install PostgreSQL 8.4+)</h3></rt></ruby>

######Install PostgreSQL
```
$ sudo yum install http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-redhat93-9.3-1.noarch.rpm
$ sudo yum install postgresql93-server postgresql93-contrib postgresql93-devel
$ sudo service postgresql-9.3 initdb
$ sudo chkconfig postgresql-9.3 on
$ sudo ln -s /usr/pgsql-9.3/bin/p* /usr/local/bin/
```

###rbenv & Plugins
This will install the rbenv and plugins needed for jellyfish-core.

* Documentation for rbenv /rbenv-build is located at https://github.com/sstephenson/rbenv#installation
* Documentation for rbenv-sudo is located at https://github.com/dcarley/rbenv-sudo#installation

######Install rbenv, rbenv-build and rbenv-sudo
```
$ git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
$ echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
$ type rbenv
rbenv is a function
$ mkdir ~/.rbenv/plugins
$ git clone git://github.com/dcarley/rbenv-sudo.git ~/.rbenv/plugins/rbenv-sudo
```

####Ruby
This will install the actual ruby programming language

######Install Ruby 2.1.5
````
$ rbenv install 2.1.5
$ rbenv global 2.1.5
````

####Bundler
This will install the bundler used to install or create bundles

######Install bundler
````
gem install bundler
````

###rbenv Default Gems Plugin
This will re-install gems automatically for us whenever we install a new version of Ruby.

* Documentation for rbenv-default-gems is located at https://github.com/sstephenson/rbenv-default-gems#installation

######Install rbenv-default-gems plugin
```
$ git clone https://github.com/sstephenson/rbenv-default-gems.git ~/.rbenv/plugins/rbenv-default-gems
$ echo "bundler" >> ~/.rbenv/default-gems
```

####<ins>OPTIONAL</ins>: RDoc
This will generate documentation from ruby source files

* **<ins>This step is optional</ins>**

######Install RDoc
````
$ echo "gem: --no-document" >> ~/.gemrc
````

####Rails gem
This will install the rails framework

######Install rails gem
````
$ gem install rails
$ echo "rails" >> ~/.rbenv/default-gems
````

####PostgreSQL Gem
This will install the gem that will allow the rails framework to communicate with PostgreSQL

######Install PostgreSQL Gem
````
$ gem install pg
```

####Clone Repository
This will checkout the latest version of the jellyfish-core code

* Because jellyfish-core is private, you must user your GitHub credetintials to log in

######Git Clone
````
$ git clone https://USERNAME:PASSWORD@github.com/booz-allen-hamilton/jellyfish-core.git
````

####Dependencies
This will install any dependancies for the application

######Install dependancies
````
$ cd jellyfish-core
$ bundle install
````

####Configure application
You must configure your `./config/application.yml` file

You will need to create this file yourself (it is already in the .gitignore),
the Figaro gem uses this to to "create" ENVIRONMENT variables.  Alternatively,
you can simply create ENVIRONMENT vars yourself.

* **Note**: You will need to install PostgreSQL per their directions

########./config/application.yml Contents
````
DATABASE_URL:     "postgres://jellyfish_user:jellyfish_pass@localhost:5432/jellyfish"
CORS_ALLOW_ORIGIN: [fqdn of ux server]
````

####Application Database
This will create and populate the database to be used by the application

* <ins>OPTIONAL</ins>: You only need to run "rake sample:jenkins" sample data is needed (useful for development)
* Please note that this rake task does not create the database or the database user (those will need to be created based on the DB you are using)

````
rake db:schema:load
rake
rake db:seed
rake sample:jenkins
````


####Start the server (for development)

````
rails s
````


#####Install Nginx

Get the Package for your RHEL Version (http://nginx.org/en/linux_packages.htm), and install

````
sudo rpm -i rpm -i <url to repo file from above page>
sudo yum install nginx
````

Delete the default site config
````
sudo rm /etc/nginx/conf.d/default.conf
````

Create jellyfish.conf (with the file contents below)
````
sudo vi /etc/nginx/conf.d/jellyfish.conf

# File (update the my_app_url.com) and

upstream myapp_puma {
  server unix:///tmp/myapp_puma.sock;
}

server {
  listen  80;
  root /home/jellyfish/jellyfish-core/public;

  location / {
        #all requests are sent to the UNIX socket
        proxy_pass http://myapp_puma;
        proxy_redirect     off;

        proxy_set_header   Host             $host:$proxy_port;
        proxy_set_header   X-Real-IP        $remote_addr;
        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;

        client_max_body_size       10m;
        client_body_buffer_size    128k;

        proxy_connect_timeout      90;
        proxy_send_timeout         90;
        proxy_read_timeout         90;

        proxy_buffer_size          4k;
        proxy_buffers              4 32k;
        proxy_busy_buffers_size    64k;
        proxy_temp_file_write_size 64k;
  }
}
````

Restart Nginx
````
sudo /etc/init.d/nginx restart
````

Start Core
cd /home/jellyfish/jellyfish-core
bundle exec puma -e production -d -b unix:///tmp/myapp_puma.sock


####Upkeep Rake Tasks

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
