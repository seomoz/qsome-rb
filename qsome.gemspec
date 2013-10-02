# Encoding: utf-8
# -*- ruby -*-

Gem::Specification.new do |gem|
  gem.name        = 'qsome'
  gem.version     = '0.1.0'
  gem.date        = '2013-10-02'
  gem.summary     = 'Qsome Queueing'
  gem.description = 'Queues comprised of subqueues'
  gem.authors     = ['Dan Lecocq']
  gem.email       = 'dan@moz.com'
  gem.files       = %w{README.md Gemfile} +
                    Dir.glob('lib/**/*.rb') +
                    Dir.glob('bin/*.rb')

  gem.add_development_dependency 'rake',         '~> 10'
  gem.add_development_dependency 'rspec',        '~> 2.13'
  gem.add_development_dependency 'rspec-fire',   '~> 1.2'
  gem.add_development_dependency 'simplecov',    '~> 0.7'
  gem.add_development_dependency 'rubocop',      '~> 0.13.1'
end

