module Systemd
    class Service 
        # list of supported actions on a provided service
        LIST_OF_ACTIONS   = %w( start restart stop enable disable reload mask unmask )

        # list of supported statuses on a provided service
        LIST_OF_STATUSES  = %w( enabled active )

        attr_reader :name, :command, :founded

        # we create a new object that accept 1 argument:
        # 1. the name of the systemd service to control (postgresql, redis etc..)
        # Example:
        # my_postgresql_service = Systemd::Service.new('postgresql')
        def initialize(name)
            @name    = name
            @command = 'systemctl'
            @founded = exist?()
        end

        # method for check if a provided service exist
        # Example:
        # my_postgresql_service.exist?
        def exist? 
            service_existence = `#{@command} list-units --type=service --all | grep -w #{@name}`
            service_existence.nil? || service_existence.empty? ? false : true
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
                @founded == true ? `sudo #{@command} #{action} #{@name}` : default_error_message()
            end
        end

        # method for return the current status of the provided service
        # Example:
        # my_postgresql_service.status
        def status 
            @founded == true ? `#{@command} status #{@name}` : default_error_message()
        end

        # create dynamically methods based on LIST_OF_STATUSES constant
        # after created a new object we can call the methods:
        # my_postgresql_service.is_enabled?
        # my_postgresql_service.is_active?
        LIST_OF_STATUSES.each do |status|
            define_method "is_#{status}?" do 
                @founded == true ? `#{@command} is-#{status} #{@name}` : default_error_message()
            end
        end

        private 

        # method for return the default_error_message when a service not exists
        def default_error_message 
            "#{@name}.service not found"
        end
    end
end