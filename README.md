[![Code Climate](https://codeclimate.com/github/tmuntan1/cavy.png)](https://codeclimate.com/github/tmuntan1/cavy)
[![Build Status](https://travis-ci.org/tmuntan1/cavy.png)](https://travis-ci.org/tmuntan1/cavy)

# Cavy

Cavy is a Ruby on Rails Mountable Engine CMS that strives to make it easier for developers to make better localized websites for their clients.

**Warning:**
*Cavy is still in development. Use at your own risk.*

## Installation

### Gemfile

I don't have the gem in alpha yet, so you will have to pull it off the github repository.  You can do this with the following line in your `Gemfile`.

    gem 'cavy', '0.1.0.beta1'

### Mounting the Engine to your Application

Go into your `config/routes.rb` file and add the following line near the top.

    mount Cavy::Engine => '/'

*Remember to mount the application where you want, `'/'` will mount it to the root of your domain.*

### Installing the Migrations

You can get the migrations with the following commands.

```
bin/rails cavy:install:migrations
bin/rails db:migrate
```

### Cavy Configuration

You are able to configure some aspects of Cavy to personalize your install and to enable certain features.  In order to do this, you need to make a configuration file such as `config/initializers/cavy.rb`. Here is an example configuration file taken from the dummy application.

```ruby
Cavy.config do |config|
    config.root = 'home'
    config.title = 'Cavy Test'
    config.locales = [:en,:de]
    config.default_locale = :en
end
```

Here is the explanation of the configuration variables.

* `config.root` is the root page of the app that you want to load when a user hits your application.
* `config.title` is the title of your application.  It is not really needed but it will show the name in the backend.
* Localization
    * `config.locales` is the list of your supported locales in an array.
    * `config.default_locale` is the default locale for your application.

### Everything Else

When you start the application, you will be asked to make an administration account. You can also create the administration account yourself through the console or a seed. If you do this, then you will not be asked to create an account.

## Uploading Files to S3

You can upload images to S3 using the gem `fog-aws`

```
gem 'fog-aws'
```

Then you can create an initializer to setup your connection.
```ruby
require 'carrierwave'

CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'Your secret key id',
      aws_secret_access_key: 'Your secret access key',
      region: 'Your s3 region',
      path_style: true
  }
  config.fog_directory = 'Your s3 bucket'
end

module Cavy
  class FogUploader < CarrierWave::Uploader::Base
    storage :fog
  end
end

Cavy.config do |config|
  config.uploader = Cavy::FogUploader.new
end
```

## Tutorials

You can view the tutorials at our [wiki](http://www.github.com/tmuntan1/cavy/wiki).
