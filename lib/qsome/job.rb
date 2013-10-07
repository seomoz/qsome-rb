# Encoding: utf-8

require 'qless/job'

module Qsome
  class Job < Qless::Job
    attr_reader :hsh

    def self.build(client, klass, attributes = {})
      raise NotImplementedError.new
    end

    def initialize(client, atts)
      super(client, atts)
      @hsh = atts['hash']
    end

    def queue
      @queue ||= Queue.new(@queue_name, @client)
    end    
  end
end
