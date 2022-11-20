# module for share variables in all specs
module TestVariables
  # method for share Systemdy constant commands
  def systemd_module_constant
    let(:systemclt_command_constant)          { 'systemctl' }
  end

  # method for test services name as variables
  def services_names
    let(:real_service_name)                   { 'postgresql' }
    let(:real_service_essential_info_lookup)  { %w( 5432 tcp ) }
    let(:dummy_service_name)                  { 'service_that_not_exist' }
  end

  # method for share initialized Systemdy::Service objects as variables
  def initialized_services
    let(:real_service)                        { Systemdy::Service.new real_service_name}
    let(:dummy_service)                       { Systemdy::Service.new dummy_service_name}
  end

  # method for share initialized Systemdy::Service objects attributes as variables
  def services_attributes
    let(:real_service_name_attribute)         { real_service.name }
    let(:real_service_command_attribute)      { real_service.command }
    let(:real_service_validator_attribute)    { real_service.validator }
  end

  # method for share log variables for Systemdy::Journal class
  def log_variables
    let(:log_start_period)                    { 'today' }
    let(:log_end_period)                      { Time.now.strftime('%H:%M') }
    let(:log_number_of_lines)                 { 10 }
  end
end