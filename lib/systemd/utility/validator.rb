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

            # method for render custom message if an error occurred
            def render_message(message)
                message
            end
        end
    end
end