# ruby-sdnotify

[![Gem Version](https://badge.fury.io/rb/ruby-sdnotify.svg)](https://badge.fury.io/rb/ruby-sdnotify)
[![Documentation](http://img.shields.io/badge/yard-docs-blue.svg)](http://www.rubydoc.info/github/agis/ruby-sdnotify)

A pure Ruby implementation of [sd_notify(3)](https://www.freedesktop.org/software/systemd/man/sd_notify.html) that can be used to
communicate state changes of Ruby programs to systemd.

Refer to the [API documentation](http://www.rubydoc.info/github/agis/ruby-sdnotify) for more info.

## Getting started

Install ruby-sdnotify:

```shell
$ gem install ruby-sdnotify
```

If you're using Bundler, add it to your Gemfile:

```ruby
gem "ruby-sdnotify"
```

and run `bundle install`.

## Usage

The [API](http://www.rubydoc.info/github/agis/ruby-sdnotify) is mostly tied to
the official implementation, therefore refer to the [sd_notify(3) man pages](https://www.freedesktop.org/software/systemd/man/sd_notify.html)
for detailed description of how the notification mechanism works.

A simple example:

```ruby
require "sd_notify"

puts "Hello. Booting..."
sleep 2 # do some initialization work ...
SdNotify.ready

sum = 0
5.times do |i|
  sleep 1 # perform some work
  sum += 1
  SdNotify.status("{sum} jobs completed")
end

puts "Finished working, shutting down..."
SdNotify.stopping
sleep 2 # do cleanup work...
```

## License

ruby-sdnotify is licensed under MIT. See [LICENSE](LICENSE).
