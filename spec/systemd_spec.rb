# frozen_string_literal: true

describe Systemd do
  it "has a version number" do
    expect(Systemd::VERSION).not_to be nil
  end

  it "has a systemctl command" do
    expect(Systemd::SYSTEMCTL_COMMAND).to be 'systemctl'
  end

  it "has a journalctl command" do
    expect(Systemd::JOURNALCTL_COMMAND).to be 'journalctl'
  end
end
