# Encoding: utf-8

# External dependencies
require 'json'

# Internal dependencies
require 'qless'
require 'qsome/lua'
require 'qsome/job'
require 'qsome/queue'

module Qsome
  class ClientQueues < Qless::ClientQueues
    def [](name)
      Queue.new(name, @client)
    end
  end

  class ClientJobs < Qless::ClientJobs
    # So we can return a Qsome::Job, not a Qless::Job
    def tracked
      results = JSON.parse(@client.call('track'))
      results['jobs'] = results['jobs'].map { |j| Job.new(@client, j) }
      results
    end

    # So we can return a Qsome::Job, not a Qless::Job
    def get(jid)
      results = @client.call('get', jid)
      if results.nil?
        return nil
      end
      Job.new(@client, JSON.parse(results))
    end

    # So we can return a Qsome::Job, not a Qless::Job
    def multiget(*jids)
      results = JSON.parse(@client.call('multiget', *jids))
      results.map do |data|
        Job.new(@client, data)
      end
    end
  end

  class Client < Qless::Client
    def initialize(options = {})
      super(options)
      # Instead of the normal qless scripts, we'll use qsome
      @_qless = Qsome::LuaScript.new('qsome', @redis)

      # Access to queues, jobs, workers, etc.
      @queues = ClientQueues.new(self)
      @jobs = ClientJobs.new(self)
    end
  end
end
