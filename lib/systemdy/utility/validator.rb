module Systemdy
    # A module that contains a set of useful classes for add utilities to the Systemdy's core
    module Utility 
        # Allows to add validation to a class
        class Validator
            # a method for check if a service is intalled on the system
            #
            # @param name_of_the_service [String] the name of the service
            # @return [Boolean] the presence of the service on the system
            # @example check if a service is intalled on the system
            #   postgresql_service = Systemdy::Utility::Validator.check_if_a_service_exist('postgresql')
            #   #=> true
            def self.check_if_a_service_exist(name_of_the_service)
                `#{SYSTEMCTL_COMMAND} list-unit-files #{name_of_the_service}.service | wc -l`.to_i > 3
                # 'systemctl list-unit-files name_of_service.service | wc -l' command output:
                #  3  when there are not matching units(the service not exist because isn't installed on the system)
                #  >3 when there are matching units(the service exist because is installed on the system)
            end
        end
    end
end