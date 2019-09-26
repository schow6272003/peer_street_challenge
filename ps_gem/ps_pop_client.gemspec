require File.expand_path("../lib/ps_pop_client/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'ps_pop_client'
  s.version     = PSClient::VERSION
  s.date        = '2019-09-16'
  s.summary     = "API To fetch population growth on CBSA"
  s.description = "Ruby Client to interact with CBSA api as described on PeerStreet take home assignment."
  s.authors     = ["Steven Chow"]
  s.email       = 'stevenwchow@gmail.com'
  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files -- bin/*`.split('\n').map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  s.homepage    = 'https://github.com/schow6272003/ps_gem'
  s.license       = 'MIT'
  s.add_dependency 'json'
  s.add_development_dependency 'rspec'
end
