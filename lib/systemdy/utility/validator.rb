module Systemdy
    module Utility 
        class Validator
            # method for check if a service exist
            def self.check_if_a_service_exist(service)
                `#{SYSTEMCTL_COMMAND} list-unit-files #{service}.service | wc -l`.to_i > 3
                # 'systemctl list-unit-files name_of_service.service | wc -l' command output:
                #  3  when there are not matching units
                #  >3 when there are matching units
            end
        end
    end
end