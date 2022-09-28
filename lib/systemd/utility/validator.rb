module Systemd
    module Utility 
        class Validator
            # method for check if a service exist
            def self.check_if_a_service_exist(service)
                `#{SYSTEMCTL_COMMAND} status #{service} 2>&1`
                $?.success? 
            end
        end
    end
end