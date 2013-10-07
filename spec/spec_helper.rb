# Encoding: utf-8

begin
  # use `bundle install --standalone' to get this...
  require_relative '../bundle/bundler/setup'
rescue LoadError
  # fall back to regular bundler if the developer hasn't bundled standalone
  require 'bundler'
  Bundler.setup
end

require 'qsome'
require 'rspec/fire'

# Some rspec configuration
RSpec.configure do |conf|
  conf.treat_symbols_as_metadata_keys_with_true_values = true
  conf.filter_run :f
  conf.run_all_when_everything_filtered = true
end

# You know, for integration tests
shared_context 'redis integration', :integration do
  def new_client
    Qsome::Client.new
  end

  def new_redis
    Redis.new
  end

  # A qless client subject to the redis configuration
  let(:client) { new_client }
  # A plain redis client with the same redis configuration
  let(:redis)  { new_redis }

  # Ensure we've got an empty redis database and remove any old scripts
  before(:each) do
    pending 'Must start with empty Redis DB' if redis.keys('*').length > 0
    redis.script(:flush)
  end

  # Empty the redis DB after we're done
  after(:each) do
    redis.flushdb
  end
end
