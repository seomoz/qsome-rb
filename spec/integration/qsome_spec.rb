# Encoding: utf-8

# The thing we're testing
require 'qsome'

# Rspec stuff
require 'spec_helper'

module Qsome
  describe Client, :integration do
    describe ClientJobs do
      let(:queue) { client.queues['foo'] }

      it 'can get a Qsome job' do
        job = client.jobs[queue.put('foo', 1, {})]
        expect(job).to be_a(Qsome::Job)
      end

      it 'returns nil for nonexistent jobs' do
        expect(client.jobs['foo']).to_not be
      end

      it 'gets Qsome jobs for tracked jobs' do
        job = client.jobs[queue.put('foo', 1, {})]
        job.track
        expect(client.jobs.tracked['jobs'][0]).to be_a(Qsome::Job)
      end

      it 'multigets Qsome jobs' do
        jids = 10.times.map { queue.put('foo', 1, {}) }
        jobs = client.jobs.multiget(*jids)
        expect(jobs.length).to eq(10)
        jobs.each do |job|
          expect(job).to be_a(Qsome::Job)
        end
      end
    end

    describe ClientQueues do
      it 'is a Qsome queue, not a qless one' do
        expect(client.queues['foo']).to be_a(Qsome::Queue)
      end
    end
  end
end
