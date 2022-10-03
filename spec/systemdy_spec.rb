# frozen_string_literal: true

describe Systemdy do
  it "has a version number" do
    expect(Systemdy::VERSION).not_to be nil
  end

  it "has a systemctl command" do
    expect(Systemdy::SYSTEMCTL_COMMAND).to be 'systemctl'
  end

  it "has a journalctl command" do
    expect(Systemdy::JOURNALCTL_COMMAND).to be 'journalctl'
  end
end
