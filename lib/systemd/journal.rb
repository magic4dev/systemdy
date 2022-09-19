module Systemd
    module Journal
        class Unit 

            attr_reader :unit, :command, :founded

            # we create a new object that accept 1 argument:
            # 1. the name of the unit to monitor (postgresql, redis etc..)
            # Example:
            # my_postgresql_log = Systemd::Journal::Unit.new('postgresql')
            def initialize(unit)
                @unit    = unit
                @command = 'journalctl'
                @founded = exist?()
            end

            # method for check if a provided unit exist
            # Example:
            # my_postgresql_log.exist?
            def exist?
                `#{@command} -u #{@unit}`.chomp != default_error_message()
            end

            def display_logs(since, to, number_of_lines)
                `#{@command} -u #{@unit} -S #{since} -U #{to} -n #{number_of_lines}`.split(/\n/)[0...number_of_lines]
            end
            
            private 

            # method for return the default_error_message when an unit not exists
            def default_error_message
                "-- No entries --"
            end
        end
    end 
end