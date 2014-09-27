$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__)) + '/lib/'
require 'fission-app-packager/version'
Gem::Specification.new do |s|
  s.name = 'fission-app-packager'
  s.version = FissionApp::Packager::VERSION.version
  s.summary = 'Fission App Packager'
  s.author = 'Heavywater'
  s.email = 'fission@hw-ops.com'
  s.homepage = 'http://github.com/heavywater/fission-app-packager'
  s.description = 'Fission packager'
  s.require_path = 'lib'
  s.add_dependency 'fission-app'
  s.add_dependency 'fission-app-jobs'
  s.files = Dir['**/*']
end
