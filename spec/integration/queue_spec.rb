# Encoding: utf-8

# The thing we're testing
require 'qsome/queue'

# Rspec stuff
require 'spec_helper'

module Qsome
  describe Queue, :integration do
    let(:queue) { client.queues['foo'] }

    it 'can put a job in a basic way' do
      expect(queue.put('Foo', 1, {})).to be
    end

    it 'can recur a job in a basic way' do
      # First, make sure that it raises an exception
      expect {
        queue.recur('foo', 1, {}, 10)
      }.to raise_exception
      pending('This is not required yet, so it remains unimplemented')
    end

    it 'can pop jobs' do
      queue.put('Foo', 1, {})
      expect(queue.pop).to be_a(Qsome::Job)
    end

    it 'can peek jobs' do
      queue.put('Foo', 1, {})
      expect(queue.peek).to be_a(Qsome::Job)
    end

    it 'can get the length of the queue' do
      100.times do |index|
        queue.put('Foo', index, {})
      end
      expect(queue.length).to eq(100)
    end

    it 'exposes subqueues' do
      queue.resize(10)
      expected = (1..10).map { |i| "foo-#{i}" }
      expect(queue.subqueues).to eq(expected)
    end

    it 'exposes resize' do
      expect(queue.subqueues.length).to eq(1)
      queue.resize(10)
      expect(queue.subqueues.length).to eq(10)
    end
  end
end
