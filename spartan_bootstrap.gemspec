# -*- encoding: utf-8 -*-
require_relative '../lib/spartan_bootstrap/version'

Gem::Specification.new do |s|
  s.name     = 'spartan_bootstrap'
  s.version  = SpartanBootstrap::VERSION
  s.date     = Date.today.strftime('%Y-%m-%d')
  s.authors  = ["Nicholas Peter Yianilos"]
  s.email    = 'spartandeveloper@gmail.com'
  s.homepage = 'https://github.com/spartan-developer/spartan_bootstrap'

  s.summary     = "Generate a Rails app configured just how I like it"
  s.description = <<-HERE
  I totally copied this from thoughtbot/suspenders.
  I got rid of a bunch of stuff and will use this as a foundation to improve my
  personal bootstrap as time goes on.
  HERE

  s.files = `git ls-files`.split("\n").
    reject { |file| file =~ /^\./ }.
    reject { |file| file =~ /^(rdoc|pkg)/ }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md LICENSE]

  s.add_dependency('rails', '3.2.3')
  s.add_dependency('bundler', '>= 1.1')

  #s.add_development_dependency('cucumber', '~> 1.1.9')
  #s.add_development_dependency('aruba', '~> 0.4.11')
end

