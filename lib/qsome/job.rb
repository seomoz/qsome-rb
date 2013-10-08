# Encoding: utf-8

require 'qless/job'

module Qsome
  # Represents a job in qsome
  class Job < Qless::Job
    attr_reader :hash

    def self.build(client, klass, attributes = {})
      raise NotImplementedError.new
    end

    def initialize(client, atts)
      super(client, atts)
      @hash = atts['hash']
    end

    def queue
      @queue ||= Queue.new(@queue_name, @client)
    end

    # Move this from it's current queue into another
    def move(queue, opts = {})
      note_state_change :move do
        @client.call('put', queue, @jid, @klass_name, hash,
                     JSON.dump(opts.fetch(:data, @data)),
                     opts.fetch(:delay, 0),
                     'priority', opts.fetch(:priority, @priority),
                     'tags', JSON.dump(opts.fetch(:tags, @tags)),
                     'retries', opts.fetch(:retries, @original_retries),
                     'depends', JSON.dump(opts.fetch(:depends, @dependencies))
        )
      end
    end
  end
end
