# Encoding: utf-8

# The thing we're testing
require 'qsome/job'
require 'qsome/queue'

# Rspec stuff
require 'spec_helper'

module Qsome
  describe Job, :integration do
    let(:queue) { client.queues['foo'] }
    let(:job) { client.jobs[queue.put('Foo', 1, {})] }

    it 'exposes its hash' do
      expect(job.hsh).to eq(1)
    end

    it 'exposes its queue name properly' do
      # This should be 'foo', not foo-0
      expect(job.queue_name).to eq('foo')
    end

    it 'exposes its queue properly' do
      expect(job.queue.name).to eq('foo')
      expect(job.queue).to be_a(Qsome::Queue)
    end

    it 'has no build utility' do
      expect {
        Job.build(client, 'Foo')
      }.to raise_exception
    end
  end
end
