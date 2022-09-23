module Systemd
    module Journal
        class Unit 

            # extend Forwardable standard's library module for delegate a specified method to a designated object
            # in this case we use 'extend' for add class methods.
            extend Forwardable

            attr_reader :name, :command, :founded

            # we delegate the existence of the created unit to Systemd's exist? class method contained in systemd.rb
            delegate exist?:   :Systemd

            # we create a new object that accept 1 argument:
            # 1. the name of the unit to monitor (postgresql, redis etc..)
            # Example:
            # my_postgresql_log = Systemd::Journal::Unit.new('postgresql')
            def initialize(name)
                @name    = name
                @command = JOURNALCTL_COMMAND # constant contained in systemd.rb
                @founded = exist?(@name) # class method contained in systemd.rb
            end

            # method for display logs for a provided unit
            # this method accept 3 keyword arguments:
            # 1. since ('the log's initial period')  - String
            # 2. to    ('the log's end period')      - String
            # 3. lines ('the log's number of lines') - Integer - default 10 
            # Example:
            # if you call this method for a unit that doesn't exist
            # my_unit_that_does_not_exist.display_logs
            # - it call the the default_error_message method and return "-- No entries --" message
            # if you call this method without arguments
            # my_postgresql_log.display_logs
            # - it return an array with 10 lines of logs
            # for display a log interval from yesterday to 15:00 with 30 lines (if the log size is almost 30 lines long)
            # my_postgresql_log.display_logs(since: 'yesterday', to: '15:00', lines: 30) or
            # my_postgresql_log.display_logs(to: '15:00', lines: 30)                    
            # for display a log interval from last week to 15:00 with 30 lines (if the log size is almost 30 lines long)
            # my_postgresql_log.display_logs(since: '1 week ago', to: '15:00', lines: 30)
            # if you call this method with bad arguments
            # my_postgresql_log.display_logs(since: 'an incorrect period', to: 'another incorrect period', lines: 23)
            # - it return "Sorry but you have provided bad argument type!" message
            def display_logs(since: '', to: '', lines: 10)
                # it save the -S (--since) command of journalctl if the keyword argument 'since' is provided
                since_argument = "-S '#{since}' " if !since.empty? 
                # it save the -U (--until) command of journalctl if the keyword argument 'to' is provided
                to_argument    = "-U '#{to}' "    if !to.empty?    
                # this is the complete journalctl command for rettrieve unit logs
                journalctl     = `#{@command} -u #{@name} #{since_argument} #{to_argument} -n #{lines} 2>&1`
                # if the provided arguments are incorrect return the default error message otherwise return the lines of log
                unit_logs      = journalctl.match('Failed') ? journalctl.chomp : journalctl.split(/\n/)[0...lines] 
                # if the provided unit exist display the logs otherwise return the default error message
                @founded       ? unit_logs : default_error_message()

                # manage exception when a bad argument is passed
                rescue NoMethodError

                bad_arguments_message()
            end
            
            private 

            # method for return the default_error_message when a unit not exists
            def default_error_message
                "-- No entries --"
            end

            # method for return the bad_arguments_message when bad arguments are provided
            def bad_arguments_message
                "Sorry but you have provided bad argument type!"
            end
        end
    end 
end    