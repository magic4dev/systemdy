# frozen_string_literal: true

# external gems or standard's library modules
require "forwardable"
require "etc"

# systemdy's class and modules
require_relative "systemdy/version"
require_relative "systemdy/utility/validator"
require_relative "systemdy/utility/formatter"
require_relative "systemdy/utility/message_displayer"
require_relative "systemdy/utility/key_value_filter"
require_relative "systemdy/service"
require_relative "systemdy/journal"

module Systemdy
  class Error < StandardError; end

  # systemctl command
  SYSTEMCTL_COMMAND  = 'systemctl'
  # journalctl command
  JOURNALCTL_COMMAND = 'journalctl'
end