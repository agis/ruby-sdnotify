# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = "sd_notify"
  s.version     = "0.1.0"
  s.summary     = "Pure Ruby implementation of systemd's sd_notify(3)"
  s.description = "sd_notify can be used to notify systemd about various " \
                  "service status changes of Ruby programs"
  s.author      = "Agis Anastasopoulos"
  s.email       = "agis.anast@gmail.com"
  s.files       = ["lib/sd_notify.rb", "LICENSE", "README.md", "CHANGELOG.md"]
  s.homepage    = "https://github.com/agis/ruby-sdnotify"
  s.license     = "MIT"

  s.add_development_dependency "rubocop"
  s.add_development_dependency "rubocop-performance"
end
