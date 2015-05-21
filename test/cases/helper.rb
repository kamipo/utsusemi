require 'bundler'
Bundler.setup

require 'utsusemi'
require 'config'

require 'active_support/testing/autorun'
require 'stringio'

require 'active_record'
require 'cases/test_case'
require 'active_support/dependencies'
require 'active_support/logger'
require 'active_support/core_ext/string/strip'

require 'support/config'
require 'support/connection'

# TODO: Move all these random hacks into the ARTest namespace and into the support/ dir

Thread.abort_on_exception = true

# Show backtraces for deprecated behavior for quicker cleanup.
ActiveSupport::Deprecation.debug = true

# Enable raise errors in after_commit and after_rollback.
ActiveRecord::Base.tap do |klass|
  klass.raise_in_transactional_callbacks = true if klass.respond_to?(:raise_in_transactional_callbacks=)
end

# Connect to the database
ARTest.connect

# FIXME: we have tests that depend on run order, we should fix that and
# remove this method call.
require 'active_support/test_case'
ActiveSupport::TestCase.tap do |klass|
  klass.test_order = :sorted if klass.respond_to?(:test_order=)
end

def load_schema
  # silence verbose schema loading
  original_stdout = $stdout
  $stdout = StringIO.new

  load SCHEMA_ROOT + "/schema.rb"
ensure
  $stdout = original_stdout
end

load_schema
