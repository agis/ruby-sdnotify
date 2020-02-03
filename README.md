# ruby-sdnotify

[![Gem Version](https://badge.fury.io/rb/sd_notify.svg)](https://badge.fury.io/rb/sd_notify)
[![Build Status](https://travis-ci.org/agis/ruby-sdnotify.svg?branch=master)](https://travis-ci.org/agis/ruby-sdnotify)
[![Documentation](http://img.shields.io/badge/yard-docs-blue.svg)](http://www.rubydoc.info/github/agis/ruby-sdnotify)
[![License](https://img.shields.io/github/license/mashape/apistatus.svg)](LICENSE)


A pure-Ruby implementation of [sd_notify(3)](https://www.freedesktop.org/software/systemd/man/sd_notify.html) that can be used to
communicate state changes of Ruby programs to [systemd](https://www.freedesktop.org/wiki/Software/systemd/).

Refer to the [API documentation](http://www.rubydoc.info/github/agis/ruby-sdnotify) for more info.

## Getting started

Install ruby-sdnotify:

```shell
$ gem install sd_notify
```

If you're using Bundler, add it to your Gemfile:

```ruby
gem "sd_notify"
```

## Usage

The [API](http://www.rubydoc.info/github/agis/ruby-sdnotify) is mostly tied to
the official implementation, therefore refer to the [sd_notify(3) man pages](https://www.freedesktop.org/software/systemd/man/sd_notify.html)
for detailed description of how the notification mechanism works.

An example involving a dummy workload (assuming the program is shipped as a
systemd service):

```ruby
require "sd_notify"

puts "Hello! Booting..."

# doing some initialization work...
sleep 2

# notify systemd that we're ready
SdNotify.ready

sum = 0
5.times do |i|
  # doing our main work...
  sleep 1

  sum += 1

  # notify systemd of our progress
  SdNotify.status("{sum} jobs completed")
end

puts "Finished working. Shutting down..."

# notify systemd we're shutting down
SdNotify.stopping

# doing some cleanup work...
sleep 2

puts "Bye"
```

## License

ruby-sdnotify is licensed under MIT. See [LICENSE](LICENSE).
