jellyfish-core
=======

[![Code Climate](https://codeclimate.com/repos/54c2c15e69568066da0003ed/badges/c6cc02c252d341b6eeb3/gpa.svg)](https://codeclimate.com/repos/54c2c15e69568066da0003ed/feed)
[![Test Coverage](https://codeclimate.com/repos/54c2c15e69568066da0003ed/badges/c6cc02c252d341b6eeb3/coverage.svg)](https://codeclimate.com/repos/54c2c15e69568066da0003ed/feed)
[![Build Status](https://magnum.travis-ci.com/booz-allen-hamilton/jellyfish-core.svg?token=hzrJLxrVn5bNaxiZp1bx&branch=master)](https://magnum.travis-ci.com/booz-allen-hamilton/jellyfish-core)

####Overview

Project Jellyfish is an IT broker system.  It allows admins to create a product catalog of any type of service (IaaS,
TaaS, PaaS, or even Staff) and allows them to be assigned a cost, and then users can create projects and add those
services to a project.  Jellyfish current supports IaaS via ManageIQ and Chef.

Project Jellyfish has 3 main components: Jellyfish-Core, Jellyfish-UX, and ManageIQ.  Jellyfish-Core is the API layer
of Jellyfish.  It provides a REST based API for Jellyfish-UX and for the Jellyfish Mobile application.


####Requirments

Jellyfish-Core has the following requirements

* Ruby 2.1.5
* PostgreSQL 9.3.x
* ManageIQ (Anand)

####Installation

Jellyfish-Core is a Ruby on Rails app, and you can install it as such.  Please see the appropriate installation
guide for specifics for how to install.

INSTALL-OSX.md - Mac OS Installation (generally used for development)
INSTALL-REHL.md - RedHat Linux installation

####License

See LICENSE


Copyright 2015 Booz Allen Hamilton
