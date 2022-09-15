module Systemd
    class Service 
        # list of supported actions on a provided service
        LIST_OF_ACTIONS = %w( start restart stop enable disable reload )

        attr_reader :name, :command

        # we create a new object that accept 1 argument:
        # - the name of the systemd service to control (postgresql, redis etc..)
        # Example:
        # my_postgresql_service = Systemd::Service.new('postgresql')
        def initialize(name)
            @name = name
            @command = 'systemctl'
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
                "#{@command} #{action} #{@name}"
            end
        end
    end
end