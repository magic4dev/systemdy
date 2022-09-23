# frozen_string_literal: true

# external gems or standard's library modules
require "forwardable"

# systemd's class and modules
require_relative "systemd/version"
require_relative "systemd/service"
require_relative "systemd/journal"

module Systemd
  class Error < StandardError; end

  # systemctl command
  SYSTEMCTL_COMMAND  = 'systemctl'
  # journalctl command
  JOURNALCTL_COMMAND = 'journalctl'


  # method for check if a provided service(or unit) exist
  def self.exist?(service_name)
    `#{SYSTEMCTL_COMMAND} status #{service_name} 2>&1`
    $?.success? 
  end
end