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

  describe ".exist?" do
    it 'check if a provided service or unit exist' do
      # test exist? class method 
      expect(subject).to respond_to("exist?").with(1).arguments
      # test a method with a real systemd service
      expect(subject.exist?('postgresql')).to eq true
      # test a method with a dummy systemd service
      expect(subject.exist?('my-service')).to eq false
    end
  end
end
