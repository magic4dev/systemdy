# frozen_string_literal: true

require "systemd"

# module for share variables in all specs
module TestSetup 
  def test_variables
    let(:real_service_name)  { 'postgresql' }
    let(:dummy_service_name) { 'service_that_not_exist' }
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # extend TestSetup module for share variables in all specs
  config.extend TestSetup 

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
