require "bundler/gem_tasks"
require 'rake/testtask'

require File.expand_path(File.dirname(__FILE__)) + "/test/config"
require File.expand_path(File.dirname(__FILE__)) + "/test/support/config"

desc 'Run mysql2 tests by default'
task :default => :test

desc 'Run mysql2 tests'
task :test => :test_mysql2

desc 'Build MySQL and PostgreSQL test databases'
namespace :db do
  task :create => ['db:mysql:build', 'db:postgresql:build']
  task :drop => ['db:mysql:drop', 'db:postgresql:drop']
end

%w( mysql2 postgresql sqlite3 ).each do |adapter|
  namespace :test do
    Rake::TestTask.new(adapter => "#{adapter}:env") { |t|
      t.libs << 'test'
      t.test_files = Dir.glob( "test/cases/**/*_test.rb" ).sort

      t.warning = true
      t.verbose = true
    }
  end

  namespace adapter do
    task :test => "test_#{adapter}"

    # Set the connection environment for the adapter
    task(:env) { ENV['ARCONN'] = adapter }
  end

  # Make sure the adapter test evaluates the env setting task
  task "test_#{adapter}" => ["#{adapter}:env", "test:#{adapter}"]
end

namespace :db do
  namespace :mysql do
    desc 'Build the MySQL test databases'
    task :build do
      config = ARTest.config['connections']['mysql2']
      %x( mysql --user=#{config['arunit']['username']} -e "create DATABASE #{config['arunit']['database']} DEFAULT CHARACTER SET utf8" )
    end

    desc 'Drop the MySQL test databases'
    task :drop do
      config = ARTest.config['connections']['mysql2']
      %x( mysqladmin --user=#{config['arunit']['username']} -f drop #{config['arunit']['database']} )
    end

    desc 'Rebuild the MySQL test databases'
    task :rebuild => [:drop, :build]
  end

  namespace :postgresql do
    desc 'Build the PostgreSQL test databases'
    task :build do
      config = ARTest.config['connections']['postgresql']
      %x( createdb -E UTF8 -T template0 #{config['arunit']['database']} )
      %x( createdb -E UTF8 -T template0 #{config['arunit2']['database']} )

      # prepare hstore
      if %x( createdb --version ).strip.gsub(/(.*)(\d\.\d\.\d)$/, "\\2") < "9.1.0"
        puts "Please prepare hstore data type. See http://www.postgresql.org/docs/current/static/hstore.html"
      end
    end

    desc 'Drop the PostgreSQL test databases'
    task :drop do
      config = ARTest.config['connections']['postgresql']
      %x( dropdb #{config['arunit']['database']} )
    end

    desc 'Rebuild the PostgreSQL test databases'
    task :rebuild => [:drop, :build]
  end
end

task :build_mysql_databases => 'db:mysql:build'
task :drop_mysql_databases => 'db:mysql:drop'
task :rebuild_mysql_databases => 'db:mysql:rebuild'

task :build_postgresql_databases => 'db:postgresql:build'
task :drop_postgresql_databases => 'db:postgresql:drop'
task :rebuild_postgresql_databases => 'db:postgresql:rebuild'
