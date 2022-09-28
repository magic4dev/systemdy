# module for share variables in all specs
module TestVariables
  # method for share Systemd constant commands
  def systemd_module_constant
    let(:systemclt_command_constant)        { 'systemctl' }
  end

  # method for test services name as variables
  def services_names
    let(:real_service_name)                 { 'postgresql' }
    let(:dummy_service_name)                { 'service_that_not_exist' }
  end

  # method for share initialized Systemd::Service objects as variables
  def initialized_services
    let(:real_service)                      { Systemd::Service.new real_service_name}
    let(:dummy_service)                     { Systemd::Service.new dummy_service_name}
  end

  # method for share initialized Systemd::Service objects attributes as variables
  def services_attributes
    let(:real_service_name_attribute)       { real_service.name }
    let(:real_service_command_attribute)    { real_service.command }
    let(:real_service_validator_attribute)  { real_service.validator }
  end

  # method for share log variables for Systemd::Journal class
  def log_variables
    let(:log_start_period)    { 'today' }
    let(:log_end_period)      { Time.now.strftime('%H:%M') }
    let(:log_number_of_lines) { 10 }
  end
end