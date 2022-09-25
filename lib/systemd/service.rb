module Systemd
    class Service 

        # extend Forwardable standard's library module for delegate a specified method to a designated object
        extend Forwardable

        # list of supported actions on a provided service
        LIST_OF_ACTIONS   = %w( start restart stop enable disable reload mask unmask )

        # list of supported statuses on a provided service
        LIST_OF_STATUSES  = %w( enabled active )

        attr_reader :command, :validator

        # we create a new object that accept 1 argument:
        # 1. the name of the systemd service to control (postgresql, redis etc..)
        # Example:
        # my_postgresql_service = Systemd::Service.new('postgresql')
        def initialize(name)
            @command   = SYSTEMCTL_COMMAND # constant contained in systemd.rb
            @validator = Systemd::Utility::Validator.new(name) # class contained in systemd/utility/validator.rb
        end

        # we delegate the followed methods to Systemd::Utility::Validator class contained in systemd/utility/validator.rb
        # my_postgresql_service.name
        def_delegator :@validator, :service, :name
        # my_postgresql_service.exist?
        def_delegator :@validator, :check_if_a_service_exist, :exist?
        
        # delegate default_error_message to Systemd::Utility::Validator render_message method
        def_delegator :@validator, :render_message, :default_error_message
        # make default_error_message method as private
        private :default_error_message

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
                exist? ? `sudo #{@command} #{action} #{name}` : default_error_message("Unit #{name}.service could not be found.")
            end
        end

        # method for return the current status of the provided service
        # Example:
        # my_postgresql_service.status
        def status 
            exist? ? `#{@command} status #{name}`.split(/\n/).each(&:lstrip!)[1..5] : default_error_message("Unit #{name}.service could not be found.")
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
                exist? ? `#{@command} is-#{status} #{name}`.chomp == status : default_error_message("Unit #{name}.service could not be found.")
            end
        end
    end
end