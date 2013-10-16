# Encoding: utf-8

require 'qless'
require 'qless/queue'

module Qsome
  # Represents a queue in Qsome
  class Queue < Qless::Queue
    def put(klass, hash, data, opts = {})
      opts = job_options(klass, data, opts)
      @client.call('put', @client.worker_name, @name,
                   (opts[:jid] || Qless.generate_jid),
                   klass.is_a?(String) ? klass : klass.name,
                   hash,
                   JSON.generate(data),
                   opts.fetch(:delay, 0),
                   'priority', opts.fetch(:priority, 0),
                   'tags', JSON.generate(opts.fetch(:tags, [])),
                   'retries', opts.fetch(:retries, 5),
                   'depends', JSON.generate(opts.fetch(:depends, []))
      )
    end

    def recur(klass, hash, data, interval, opts = {})
      raise NotImplementedError.new
    end

    # Pop a work item off the queue
    def pop(count = nil)
      jids = JSON.parse(@client.call('pop', @name, worker_name, (count || 1)))
      jobs = jids.map { |j| Job.new(@client, j) }
      # If no count was provided, return a job. Otherwise, return an array
      count.nil? ? jobs[0] : jobs
    end

    # Peek at a work item
    def peek(count = nil)
      jids = JSON.parse(@client.call('peek', @name, (count || 1)))
      jobs = jids.map { |j| Job.new(@client, j) }
      # If no count was provided, return a job. Otherwsie, return an array
      count.nil? ? jobs[0] : jobs
    end

    # How many items in the queue?
    def length
      @client.call('length', @name)
    end

    # Change the number of subqueues
    def resize(count)
      @client.call('queue.resize', @name, count)
    end

    # Enumerate all the subqueues
    def subqueues
      JSON.parse(@client.call('queue.subqueues', @name))
    end
  end
end
