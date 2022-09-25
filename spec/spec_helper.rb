# frozen_string_literal: true

require "systemd"
require "setup/test_variables"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # extend TestVariables module for share variables in all specs
  config.extend TestVariables # module contained in setup/test_variables.rb

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
