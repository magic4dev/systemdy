module Systemdy
    # Allows to control a life-cycle of a systemd's service
    # @attr_reader command [String] the default 'systemctl' command
    # @attr_reader name [String] the name of the service
    class Service 
            
        # extend Forwardable standard's library module for delegate a specified method to a designated object
        extend Forwardable

        # list of supported actions on a provided service
        LIST_OF_ACTIONS           = %w( start restart stop enable disable reload mask unmask )

        # list of supported statuses on a provided service
        LIST_OF_STATUSES          = %w( enabled active )

        # list of status properties on a provided service when status command is called
        LIST_OF_STATUS_PROPERTIES = %w( Id Description ExecMainPID LoadState ActiveState FragmentPath 
                                        ActiveEnterTimestamp InactiveEnterTimestamp ActiveExitTimestamp 
                                        InactiveExitTimestamp 
                                    )

        attr_reader :command, :name

        # method for create a new Systemdy::Service object 
        #
        # @param  name [String] the name of the systemd service to control
        # @return [Systemdy::Service] a new Systemdy::Service object
        # @example Create an object
        #    my_postgresql_service = Systemdy::Service.new('postgresql')
        def initialize(name)
            @command   = SYSTEMCTL_COMMAND # constant contained in Systemdy.rb
            @name      = name 
        end

        # delegate return_an_array_from_system_command method to Systemdy::Utility::Formatter class contained in Systemdy/utility/formatter.rb
        def_delegator Systemdy::Utility::Formatter,        :return_an_array_from_system_command
        # delegate render_message method to Systemdy::Utility::MessageDisplayer class contained in Systemdy/utility/message_displayer.rb
        def_delegator Systemdy::Utility::MessageDisplayer, :render_message 
        # delegate check_if_a_service_exist method to Systemdy::Utility::Validator class contained in Systemdy/utility/validator.rb
        def_delegator Systemdy::Utility::Validator,        :check_if_a_service_exist 
        # delegate filter_by_keys method to Systemdy::Utility::KeyValueFilter class contained in Systemdy/utility/key_value.rb
        def_delegator Systemdy::Utility::KeyValueFilter,   :filter_by_keys 

        # method for check if a created service +exist+
        #
        # @return [Boolean] the presence of the service on the system
        # @example Create an object
        #   my_postgresql_service.exist? #=> true
        def exist? 
            check_if_a_service_exist(name) # class method contained in Systemdy/utility/validator.rb
        end
        
        # create dynamically methods based on LIST_OF_ACTIONS constant
        # @!method start
        #   execute action +start+ on the service
        #   @example start a service
        #       my_postgresql_service.start
        #   @note This method is generated with use of metaprogramming techniques
        #
        # @!method restart
        #   execute action +restart+ on the service
        #   @example restart a service
        #       my_postgresql_service.restart
        #   @note This method is generated with use of metaprogramming techniques
        #
        # @!method stop
        #   execute action +stop+ on the service
        #   @example stop a service
        #       my_postgresql_service.stop
        #   @note This method is generated with use of metaprogramming techniques
        #
        # @!method enable
        #   execute action +anable+ on the service
        #   @example enable a service
        #       my_postgresql_service.enable
        #   @note This method is generated with use of metaprogramming techniques
        #
        # @!method disable
        #   execute action +disable+ on the service
        #   @example disable a service
        #       my_postgresql_service.disable
        #   @note This method is generated with use of metaprogramming techniques
        #
        # @!method reload
        #   execute action +reload+ on the service
        #   @example reload a service
        #       my_postgresql_service.reload
        #   @note This method is generated with use of metaprogramming techniques
        #
        # @!method mask
        #   execute action +mask+ on the service
        #   @example mask a service
        #       my_postgresql_service.mask
        #   @note This method is generated with use of metaprogramming techniques
        #
        # @!method unmask
        #   execute action +unmask+ on the service
        #   @example unmask a service
        #       my_postgresql_service.unmask
        #   @note This method is generated with use of metaprogramming techniques
        #
        LIST_OF_ACTIONS.each do |action|
            define_method action do 
                sudo = Etc.getpwuid(Process.uid).name != 'root' ? 'sudo' : ''
                exist? ? `#{sudo} #{command} #{action} #{name}` : default_error_message()
            end
        end

        # method for return a key/value pair of the service's properties
        #
        # @return [Hash] the service's properties
        # @example display all the properties related to a service
        #   
        #   my_postgresql_service.properties 
        #
        #     {
        #       "Type"=>"oneshot",              
        #       "Restart"=>"no",          
        #       "ExecMainPID"=>"48615",
        #       "NotifyAccess"=>"none"
        #     }
        #
        # @note For the sake of brevity, all service-related properties are not shown in this example
        def properties
            array_of_properties = return_an_array_from_system_command(`#{command} show #{name}`)
            array_of_properties.collect { |property| { property.split('=')[0] => property.split('=')[1] } }.reduce({}, :merge)
        end

        # method for return the current status of the provided service
        #
        # @return [Hash] the service's current status
        # @example display the current status of the service
        #   my_postgresql_service.status
        #
        #     {
        #       "Id"=>"postgresql.service",              
        #       "Description"=>"PostgreSQL RDBMS",          
        #       "ExecMainPID"=>"48615",
        #       "LoadState"=>"loaded",
        #       "ActiveState"=>"active",
        #       "FragmentPath"=>"/lib/Systemdy/system/postgresql.service",
        #       "ActiveEnterTimestamp"=>"Thu 2022-09-29 17:13:07 CEST",
        #       "InactiveEnterTimestamp"=>"Thu 2022-09-29 17:12:44 CEST",
        #       "ActiveExitTimestamp"=>"Thu 2022-09-29 17:12:44 CEST",
        #       "InactiveExitTimestamp"=>"Thu 2022-09-29 17:13:07 CEST"
        #     }
        #
        def status 
            exist? ? filter_by_keys(properties, LIST_OF_STATUS_PROPERTIES) : default_error_message()
        end

        # create dynamically methods based on LIST_OF_STATUSES constant
        # @!method is_enabled?
        #   check if the service is +enabled+
        #   @return [Boolean] the service is enabled
        #   @example check if a service is enabled
        #       my_postgresql_service.is_enabled? #=> true
        # @note This method is generated with use of metaprogramming techniques
        #
        # @!method is_active?
        #   check if the service is +active+
        #   @return [Boolean] the service is active
        #   @example check if a service is active
        #       my_postgresql_service.is_active? #=> true
        # @note This method is generated with use of metaprogramming techniques
        LIST_OF_STATUSES.each do |status|
            define_method "is_#{status}?" do 
                exist? ? return_an_array_from_system_command(`#{command} is-#{status} #{name}`).include?(status) : default_error_message()
            end
        end

        # method to show a message when an action is performed on a service not installed on the system
        # @return [String] the error message
        # @example the action start on a service not installed on the system
        #     a_service_not_installed.start #=> "Unit a_service_not_installed.service could not be found."
        def default_error_message
            render_message("Unit #{name}.service could not be found.") # class method contained in Systemdy/utility/message_displayer.rb
        end

        # @!method return_an_array_from_system_command
        #   @param system_call [String] system call to convert to an array
        #   @return [Array] an array-based list of the values ​​returned by making a system call
        #   @note check out more about this method in Systemdy/utility/formatter.rb
        #
        # @!method filter_by_keys
        #   @param hash [Hash] the hash to filter
        #   @param list_of_keys [Array] the list of keys to extract from the hash
        #   @return [Hash] a new hash that contains only the required keys
        #   @note check out more about this method in Systemdy/utility/key_value_filter.rb
        #

        # make the methods below as private
        private :render_message, :default_error_message, :return_an_array_from_system_command, :filter_by_keys 
    end
end