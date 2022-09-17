module Systemd
    class Service 
        # list of supported actions on a provided service
        LIST_OF_ACTIONS = %w( start restart stop enable disable reload )

        attr_reader :name, :command, :founded

        # we create a new object that accept 1 argument:
        # 1. the name of the systemd service to control (postgresql, redis etc..)
        # Example:
        # my_postgresql_service = Systemd::Service.new('postgresql')
        # - for retrieve object's name
        #   my_postgresql_service.name
        # - for retrieve object's command
        #   my_postgresql_service.command
        # - for retrieve object's founded (if a service exist or not)
        #   my_postgresql_service.founded
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
                `sudo #{@command} #{action} #{@name}`
            end
        end

        # method for return the current status of the provided service
        # Example:
        # my_postgresql_service.status
        def status 
            `#{@command} status #{@name}` 
        end
    end
end