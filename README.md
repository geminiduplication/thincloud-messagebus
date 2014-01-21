[![Build Status](https://travis-ci.org/newleaders/thincloud-messagebus.png)](https://travis-ci.org/newleaders/thincloud-messagebus)
[![Code
Climate](https://codeclimate.com/github/newleaders/thincloud-messagebus.png)](https://codeclimate.com/github/newleaders/thincloud-messagebus)

# thincloud-messagebus

* [Homepage](https://github.com/newleaders/thincloud-messagebus#readme)
* [Issues](https://github.com/newleaders/thincloud-messagebus/issues)
* [Email](mailto:dmorrison at newleaders.com)

## Description

A thin wrapper around the `event_bus` gem to provide a simple interface
for Thincloud applications. Still a **work in progress**.

## Features

## Examples

### Add Messagebus

```ruby
require 'thincloud/messagebus'

# Mix it into your application wherever you want

module MyApplication
  extend Thincloud::Messagebus
end

# Now you have `publish` and `subscribe` methods
MyApplication.publish()

MyApplication.subscribe()
```

### Using it with Rails

Mix it in to your application as above and optionally bring along
ActiveRecord goodness.

```ruby
require "thincloud/messagebus/active_record"

class Foo < ActiveRecord::Base
  include Thincloud::Messagebus::ActiveRecord
end

#### Now you can subscribe to the model
MyApplication.subscribe_to_model()
```

#### Example of wiring up subscribers
```ruby
# Load all subscribers since the subscriber directory is not auto-loaded.
#
# We don't want to auto-load the directory because we don't have
# class/module/filename parity in there.

Dir["#{Rails.root}/app/subscribers/*.rb"].each do |file|
  require_dependency file
end
```

## Requirements

* `event_bus` gem

## Install

    $ gem install thincloud-messagebus

## Copyright

Copyright (c) 2014 New Leaders

See LICENSE.txt for details.
