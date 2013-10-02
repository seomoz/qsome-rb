#! /usr/bin/env rake
# Encoding: utf-8

# Bundler
require 'bundler/gem_helper'
Bundler::GemHelper.install_tasks

# Rspec
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--profile --format progress]
  t.ruby_opts  = '-Ispec -rsimplecov_setup'
end

# Tasks surrounding qsome/core
namespace :core do
  qsome_core_dir = './lib/qsome/qsome-core'

  desc 'Builds the qsome-core lua scripts'
  task :build do
    Dir.chdir(some_core_dir) do
      sh 'make clean && make'
      sh 'cp qsome.lua ../lua'
    end
  end

  task :update_submodule do
    Dir.chdir(qsome_core_dir) do
      sh 'git checkout master'
      sh 'git pull --rebase'
    end
  end

  desc 'Updates qsome-core and rebuilds it'
  task update: [:update_submodule, :build]

  namespace :verify do
    script_files = %w[lib/qsome/lua/qsome.lua lib/qsome/lua/qsome-lib.lua]

    desc 'Verifies the script has no uncommitted changes'
    task :clean do
      script_files.each do |file|
        git_status = `git status -- #{file}`
        unless /working directory clean/.match(git_status)
          raise "#{file} is dirty: \n\n#{git_status}\n\n"
        end
      end
    end

    desc 'Verifies the script is current'
    task :current do
      require 'digest/md5'
      our_md5s = script_files.map do |file|
        Digest::MD5.hexdigest(File.read file)
      end

      canonical_md5s = Dir.chdir(qsome_core_dir) do
        sh 'make clean && make'
        script_files.map do |file|
          Digest::MD5.hexdigest(File.read(File.basename file))
        end
      end

      unless our_md5s == canonical_md5s
        raise 'The current scripts are out of date with qsome-core'
      end
    end
  end

  desc 'Verifies the committed script is current'
  task verify: %w[ verify:clean verify:current ]
end
