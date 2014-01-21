# thincloud-messagebus

* [Homepage](https://github.com/elskwid/thincloud-messagebus#readme)
* [Issues](https://github.com/elskwid/thincloud-messagebus/issues)
* [Documentation](http://rubydoc.info/gems/thincloud-messagebus/frames)
* [Email](mailto:don at elskwid.net)

## Description

TODO: Description

## Features

## Examples

    require 'thincloud/messagebus'

```ruby
##
# Probably should put this in an initializer
# Load all subscribers since the subscriber directory is not auto-loaded.
#
# We don't want to auto-load the directory because we don't have
# class/module/filename parity in there.
#
Dir["#{Rails.root}/app/subscribers/*.rb"].each do |file|
  require_dependency file
end
```

```ruby
require "thincloud/messagebus"
require "thincloud/messagebus/active_record"

module MyApp
  extend Thincloud::Messagebus
  extend Thincloud::Messagebus::ActiveRecord
end

class Foo < ActiveRecord::Base
  include Thincloud::Messagebus::ActiveRecord
end
```

## Requirements

## Install

    $ gem install thincloud-messagebus

## Copyright

Copyright (c) 2014 New Leaders

See LICENSE.txt for details.


