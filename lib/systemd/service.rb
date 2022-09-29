module Systemd
    class Service 

        # extend Forwardable standard's library module for delegate a specified method to a designated object
        extend Forwardable

        # list of supported actions on a provided service
        LIST_OF_ACTIONS           = %w( start restart stop enable disable reload mask unmask )

        # list of supported statuses on a provided service
        LIST_OF_STATUSES          = %w( enabled active )

        # list of status properties on a provided service when status command is called
        LIST_OF_STATUS_PROPERTIES = %w( Names Description ExecMainPID LoadState ActiveState FragmentPath 
                                        ActiveEnterTimestamp InactiveEnterTimestamp ActiveExitTimestamp InactiveExitTimestamp 
                                    )

        attr_reader :command, :name

        # we create a new object that accept 1 argument:
        # 1. the name of the systemd service to control (postgresql, redis etc..)
        # Example:
        # my_postgresql_service = Systemd::Service.new('postgresql')
        def initialize(name)
            @command   = SYSTEMCTL_COMMAND # constant contained in systemd.rb
            @name      = name 
        end

        # we delegate return_an_array_from_system_command method to Systemd::Utility::Formatter class contained in systemd/utility/formatter.rb
        def_delegator Systemd::Utility::Formatter,        :return_an_array_from_system_command
        # we delegate render_message method to Systemd::Utility::MessageDisplayer class contained in systemd/utility/message_displayer.rb
        def_delegator Systemd::Utility::MessageDisplayer, :render_message 
        # we delegate check_if_a_service_exist method to Systemd::Utility::Validator class contained in systemd/utility/validator.rb
        def_delegator Systemd::Utility::Validator,        :check_if_a_service_exist 
        # we delegate filter_by_keys method to Systemd::Utility::KeyValueFilter class contained in systemd/utility/key_value.rb
        def_delegator Systemd::Utility::KeyValueFilter,   :filter_by_keys 

        # method for check if a created service exist
        # Example:
        # my_postgresql_service.exist?
        # if the provided service exist this method return
        # - true
        # otherwise return
        # - false
        def exist? 
            check_if_a_service_exist(name) # class method contained in systemd/utility/validator.rb
        end
        
        # create dynamically methods based on LIST_OF_ACTIONS constant
        # after created a new object we can call the methods:
        # my_postgresql_service.start
        # my_postgresql_service.restart
        # my_postgresql_service.stop
        # my_postgresql_service.enable
        # my_postgresql_service.disable
        # my_postgresql_service.reload
        LIST_OF_ACTIONS.each do |action|
            define_method action do 
                exist? ? `sudo #{command} #{action} #{name}` : default_error_message()
            end
        end

        # method for return a key/value pair of the provided service's properties
        # Example:
        # my_postgresql_service.properties
        # return a key/value pair of the provided service's properties
        # { "Type"=>"oneshot",
        #   "Restart"=>"no",
        #   "NotifyAccess"=>"none",
        #   ....
        # }
        def properties
            array_of_properties = return_an_array_from_system_command(`#{command} show #{name}`)
            array_of_properties.collect { |property| { property.split('=')[0] => property.split('=')[1] } }.reduce({}, :merge)
        end

        # method for return the current status of the provided service
        # Example:
        # my_postgresql_service.status
        # return a key/value pair of the provided service's status
        # { "Names"=>"postgresql.service",              
        #   "Description"=>"PostgreSQL RDBMS",          
        #   "ExecMainPID"=>"48615",
        #   "LoadState"=>"loaded",
        #   "ActiveState"=>"active",
        #   "FragmentPath"=>"/lib/systemd/system/postgresql.service",
        #   "ActiveEnterTimestamp"=>"Thu 2022-09-29 17:13:07 CEST",
        #   "InactiveEnterTimestamp"=>"Thu 2022-09-29 17:12:44 CEST",
        #   "ActiveExitTimestamp"=>"Thu 2022-09-29 17:12:44 CEST",
        #   "InactiveExitTimestamp"=>"Thu 2022-09-29 17:13:07 CEST"
        # } 
        def status 
            exist? ? filter_by_keys(properties, LIST_OF_STATUS_PROPERTIES) : default_error_message()
        end

        # create dynamically methods based on LIST_OF_STATUSES constant
        # after created a new object we can call the methods:
        # my_postgresql_service.is_enabled?
        # my_postgresql_service.is_active?
        # if the provided service is active or enabled this method return
        # - true
        # otherwise return
        # - false
        LIST_OF_STATUSES.each do |status|
            define_method "is_#{status}?" do 
                exist? ? return_an_array_from_system_command(`#{command} is-#{status} #{name}`).include?(status) : default_error_message()
            end
        end

        # method for display error when a service or unit not exist
        def default_error_message
            render_message("Unit #{name}.service could not be found.") # class method contained in systemd/utility/message_displayer.rb
        end

        # make the methods below as private
        private :render_message, :default_error_message, :return_an_array_from_system_command, :filter_by_keys 
    end
end