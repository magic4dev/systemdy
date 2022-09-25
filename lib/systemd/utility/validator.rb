module Systemd
    module Utility 
        class Validator
            attr_reader :service

            def initialize(name)
                @service = name
            end

            # method for check if a service exist
            def check_if_a_service_exist
                `#{SYSTEMCTL_COMMAND} status #{@service} 2>&1`
                $?.success? 
            end
        end
    end
end