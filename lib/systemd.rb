# frozen_string_literal: true

# external gems or standard's library modules
require "forwardable"

# systemd's class and modules
require_relative "systemd/version"
require_relative "systemd/utility/validator"
require_relative "systemd/utility/formatter"
require_relative "systemd/utility/message_displayer"
require_relative "systemd/utility/key_value_filter"
require_relative "systemd/service"
require_relative "systemd/journal"

module Systemd
  class Error < StandardError; end

  # systemctl command
  SYSTEMCTL_COMMAND  = 'systemctl'
  # journalctl command
  JOURNALCTL_COMMAND = 'journalctl'
end