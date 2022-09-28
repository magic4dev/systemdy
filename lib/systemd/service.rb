module Systemd
    class Service 

        # extend Forwardable standard's library module for delegate a specified method to a designated object
        extend Forwardable

        # list of supported actions on a provided service
        LIST_OF_ACTIONS   = %w( start restart stop enable disable reload mask unmask )

        # list of supported statuses on a provided service
        LIST_OF_STATUSES  = %w( enabled active )

        attr_reader :command, :name

        # we create a new object that accept 1 argument:
        # 1. the name of the systemd service to control (postgresql, redis etc..)
        # Example:
        # my_postgresql_service = Systemd::Service.new('postgresql')
        def initialize(name)
            @command   = SYSTEMCTL_COMMAND # constant contained in systemd.rb
            @name      = name 
        end

        # we delegate default_error_message method to Systemd::Utility::MessageDisplayer render_message class method contained in systemd/utility/message_displayer.rb
        def_delegator Systemd::Utility::MessageDisplayer, :render_message 
        # we delegate exist? method to Systemd::Utility::validator check_if_a_service_exist class method contained in systemd/utility/validator.rb
        def_delegator Systemd::Utility::Validator, :check_if_a_service_exist 

        # method for check if a created service exist
        # Example:
        # my_postgresql_service.exist?
        def exist? 
            check_if_a_service_exist(name)
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
                exist? ? `sudo #{command} #{action} #{name}` : render_message("Unit #{name}.service could not be found.")
            end
        end

        # method for return the current status of the provided service
        # Example:
        # my_postgresql_service.status
        def status 
            exist? ? `#{command} status #{name}`.split(/\n/).each(&:lstrip!)[1..5] : render_message("Unit #{name}.service could not be found.")
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
                exist? ? `#{command} is-#{status} #{name}`.chomp == status : render_message("Unit #{name}.service could not be found.")
            end
        end

        # make default_error_message method as private
        private :render_message
    end
end