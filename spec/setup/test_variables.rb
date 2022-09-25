# module for share variables in all specs
module TestVariables
  # method for share Systemd constant commands
  def systemd_module_constant
    let(:systemclt_command_constant)        { 'systemctl' }
  end

  # method for share initialization arguments as variables
  def provided_services_as_argument_for_initialization
    let(:real_service_name)                 { 'postgresql' }
    let(:dummy_service_name)                { 'service_that_not_exist' }
  end

  # method for share initialized Systemd::Utility::Validator objects as variables
  def initialized_validators
    let(:real_service_validator)            { Systemd::Utility::Validator.new real_service_name}
    let(:dummy_service_validator)           { Systemd::Utility::Validator.new dummy_service_name}
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
end