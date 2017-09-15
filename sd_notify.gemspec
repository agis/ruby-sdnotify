Gem::Specification.new do |s|
  s.name        = "sd_notify"
  s.version     = "0.0.1"
  s.date        = "2017-09-15"
  s.summary     = "Pure Ruby implementation of systemd's sd_notify(3)"
  s.description = "sd_notify can be used to notify systemd about various " \
                  "service status changes of Ruby programs"
  s.author      = "Agis Anastasopoulos"
  s.email       = "agis.anast@gmail.com"
  s.files       = [Dir["lib/**/*"], "LICENSE", "README.md"]
  s.homepage    = "https://github.com/agis/ruby-sdnotify"
  s.license     = "MIT"
end
