[![Code Climate](https://codeclimate.com/github/tmuntan1/cavy.png)](https://codeclimate.com/github/tmuntan1/cavy)
[![Build Status](https://travis-ci.org/tmuntan1/cavy.png)](https://travis-ci.org/tmuntan1/cavy)
[![Coverage Status](https://coveralls.io/repos/tmuntan1/cavy/badge.png?branch=master)](https://coveralls.io/r/tmuntan1/cavy)

# Cavy

Cavy is a Ruby on Rails Mountable Engine CMS that strives to make it easier for developers to make better websites for their clients.

**Cavy is still in development and in an unpolished state.  Use at your own risk.**

**Warning 1:**
*This is not an engine for the non-developer, it requires you to go into the guts of the system to make your pages and add new features.*

**Warning 2:**
*You will have to remove active record if you don't want to have a secondary useless database.*

## Features

* MongoDB NoSQL database
* Easy page localization
* In-Page-Editing with MercuryEditor
* Administration backend
    * Partial privileges mode for clients. (To prevent future mistakes)
    * Analytics dashboard with the Google Analytics API.  *You will need Google Analytics setup for this.*
    * Editing page meta content (meta title, meta description)
    * Editing of dynamic content

## Installation

### Gemfile

I don't have the gem in alpha yet, so you will have to pull it off the github repository.  You can do this with the following line in your `Gemfile`.

    gem 'cavy', github: 'tmuntan1/cavy'

Because Cavy uses Rails 4, you will also have to add the repository version of mongoid because the Rails 4 compatible version has not been published yet.

    gem 'mongoid', github: 'mongoid/mongoid'

### Mounting the Engine to your Application

Go into your `config/routes.rb` file and add the following line near the top.

    mount Cavy::Engine => '/'

*Remember to mount the application where you want, `'/'` will mount it to the root of your domain.*

### Mongoid Config

Make a mongoid config file `mongoid.yml` with your information.  You can make a config file with the following command in your console:

    rails g mongoid:config

You can then add your mongodb connection information.

### Cavy Configuration

Make a configuration file such as `config/initializers/cavy.rb` so that you can configure your install. Here is an example configuration file taken from the dummy application.

    Cavy.config do |config|
      config.root = 'home'
      config.title = 'Cavy Test'
      config.locales = [:en,:de]
      config.default_locale = :en
      config.google_analytics_username    = ENV['GOOGLE_ANALYTICS_USERNAME']
      config.google_analytics_password    = ENV['GOOGLE_ANALYTICS_PASSWORD']
      config.google_analytics_property_id = ENV['GOOGLE_ANALYTICS_PROPERTY_ID']
    end

* `config.root` is the root page of the app that you want to load when a user hits your application.
* `config.title` is the title of your application.  It is not really needed but it will show the name in the backend.
* `config.locales` is the list of your supported locales in an array.
* `config.default_locale` is the default locale for your application.
* `config.google_analytics_username` is the username for your Google Analytics account.
* `config.google_analytics_password` is the password for your Google Analytics account.
* `config.google_analytics_property_id` is the property id for your website for Google Analytics.

### Everything Else

Now when you start the application, you will be asked to make an administration account.  You can also create the administration account yourself through the console or a seed.  If you do this, then you will not be asked to create an account.

## Tutorials

I still need to make the tutorials.  When I finalize more aspects of Cavy, then I will make some.