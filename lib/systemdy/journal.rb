module Systemdy
    # Allows to filter journalctl logs
    class Journal 

        # extend SingleForwardableForwardable standard's library module for delegate a specified method to a designated object
        extend SingleForwardable
               
        # list of options for execute journalctl command that not accept arguments
        # @note The meaning of this constant is that in linux the command ``` journalctl -k ``` not accept arguments
        LIST_OF_OPTIONS_THAT_NOT_ACCEPT_ARGUMENTS = { kernel: '-k' }
        
        # list of options for execute journalctl command that accept arguments
        # @note The meaning of this constant is that in linux the command ``` journalctl -b ``` can accept arguments, if executed without argument return the last boot logs
        LIST_OF_OPTIONS_THAT_ACCEPT_AN_ARGUMENT   = { boot: '-b' }

        # list of options for execute journalctl command that require arguments
        # @note The meaning of this constant is that in linux the command like ``` journalctl -u ``` require arguments, if executed without argument return an error
        LIST_OF_OPTIONS_THAT_REQUIRE_AN_ARGUMENT  = { unit: '-u', group_id: '_GID', user_id: '_UID' }

        # we delegate return_an_array_from_system_command method to Systemdy::Utility::Formatter class contained in Systemdy/utility/formatter.rb
        def_delegator Systemdy::Utility::Formatter,        :return_an_array_from_system_command
        # we delegate render_message method to Systemdy::Utility::MessageDisplayer class contained in Systemdy/utility/message_displayer.rb
        def_delegator Systemdy::Utility::MessageDisplayer, :render_message 

        # create dynamically methods based on LIST_OF_OPTIONS_THAT_NOT_ACCEPT_ARGUMENTS constant
        # @!scope class
        # @!method display_kernel_logs
        #   display the +kernel logs+
        #   @param  since [String] the log's initial period - **default**: +today+
        #   @param  to [String] the log's end period - **default**: +timenow+
        #   @param  lines [Integer] the log's number of lines - **default**: +10+
        #   @return [Array] a list of kernel logs
        #   @example display the last 10 lines of kernel logs since today to the time execution method
        #       Systemdy::Journal.display_kernel_logs #=> [...]
        #   @example display the last the last 20 log lines ranging from a week ago to yesterday
        #       Systemdy::Journal.display_kernel_logs(since: '1 week ago', to: 'yesterday', lines: 20) #=> [...]
        #   @example You can also filter the logs by specific dates in the format 'YYYY-MM-DD'
        #       Systemdy::Journal.display_kernel_logs(since: '2022-08-27', lines: 200) #=> [...]
        #   @note This method is generated with use of metaprogramming techniques
        #
        LIST_OF_OPTIONS_THAT_NOT_ACCEPT_ARGUMENTS.each do |from, option|
            define_singleton_method "display_#{from}_logs" do |since: 'today', to: Time.now.strftime('%H:%M'), lines: 10|
                # logs from system call
                logs = `#{JOURNALCTL_COMMAND} #{option} -S '#{since}' -U '#{to}' -n #{lines} | tail -n #{lines} 2>&1`
                # logs from system call converted into array
                return_an_array_from_system_command(logs) # class method contained in Systemdy/utility/formatter.rb
            end
        end
        
        # create dynamically methods based on LIST_OF_OPTIONS_THAT_ACCEPT_AN_ARGUMENT constant
        # @!scope class
        # @!method display_boot_logs
        #   display the +boot logs+
        #   @param  argument [Integer] the boot number
        #   @param  since [String] the log's initial period - **default**: +today+
        #   @param  to [String] the log's end period - **default**: +timenow+
        #   @param  lines [Integer] the log's number of lines - **default**: +10+
        #   @return [Array] a list of boot logs
        #   @example display the last 10 lines of kernel logs since today to the time execution method
        #       Systemdy::Journal.display_boot_logs #=> [...]
        #   @example display the last 50 log lines of the second boot ranging from a month ago to 10:00 of the current day
        #       Systemdy::Journal.display_boot_logs(argument: 2, since: '1 month ago', to: '10:00', lines: 50) #=> [...]
        #   @example display the last 20 log of the third boot lines ranging from a week ago to yesterday
        #       Systemdy::Journal.display_boot_logs(argument: 3, since: '1 week ago', to: 'yesterday', lines: 20) #=> [...]
        #   @example You can also filter the logs by specific dates in the format 'YYYY-MM-DD'
        #       Systemdy::Journal.display_boot_logs(since: '2022-08-27', lines: 200) #=> [...]
        #   @note This method is generated with use of metaprogramming techniques
        #
        LIST_OF_OPTIONS_THAT_ACCEPT_AN_ARGUMENT.each do |from, option|
            define_singleton_method "display_#{from}_logs" do |argument: '', since: 'today', to: Time.now.strftime('%H:%M'), lines: 10|
                # logs from system call
                logs = `#{JOURNALCTL_COMMAND} #{option} #{argument} -S '#{since}' -U '#{to}' -n #{lines} | tail -n #{lines} 2>&1`
                # logs from system call converted into array
                return_an_array_from_system_command(logs) # class method contained in Systemdy/utility/formatter.rb
            end
        end
        
        # create dynamically class methods based on LIST_OF_OPTIONS_THAT_REQUIRE_AN_ARGUMENT constant
        # @!scope class
        # @!method display_unit_logs
        #   display the +unit logs+
        #   @param  argument [string] the unit name
        #   @param  since [String] the log's initial period - **default**: +today+
        #   @param  to [String] the log's end period - **default**: +timenow+
        #   @param  lines [Integer] the log's number of lines - **default**: +10+
        #   @return [Array] a list of unit logs
        #   @example display the last 50 log lines of the potsgresql service ranging from a month ago to 10:00 of the current day
        #       Systemdy::Journal.display_unit_logs(argument: 'postgresql', since: '1 month ago', to: '10:00', lines: 50) #=> [...]
        #   @example display the last 20 log lines of the potsgresql service ranging from a week ago to yesterday
        #       Systemdy::Journal.display_unit_logs(argument: 'postgresql', since: '1 week ago', to: 'yesterday', lines: 20) #=> [...]
        #   @example You can also filter the logs by specific dates in the format 'YYYY-MM-DD'
        #       Systemdy::Journal.display_unit_logs(argument: 'postgresql', since: '2022-08-27', lines: 200) #=> [...]
        #   @note This method is generated with use of metaprogramming techniques
        #   @todo This method require the unit name as argument. For more information check out the examples below
        #
        # @!method display_group_id_logs
        #   display the +group_id logs (GUID)+
        #   @param  argument [Integer] the group id
        #   @param  since [String] the log's initial period - **default**: +today+
        #   @param  to [String] the log's end period - **default**: +timenow+
        #   @param  lines [Integer] the log's number of lines - **default**: +10+
        #   @return [Array] a list of group id logs
        #   @example display the last 50 log lines of the GUID 1000 ranging from a month ago to 10:00 of the current day
        #       Systemdy::Journal.display_group_id_logs(argument: 1000, since: '1 month ago', to: '10:00', lines: 50) #=> [...]
        #   @example display the last 20 log lines of the GUID 1000 ranging from a week ago to yesterday
        #       Systemdy::Journal.display_group_id_logs(argument: 1000, since: '1 week ago', to: 'yesterday', lines: 20) #=> [...]
        #   @example You can also filter the logs by specific dates in the format 'YYYY-MM-DD'
        #       Systemdy::Journal.display_group_id_logs(argument: 1000, since: '2022-08-27', lines: 200) #=> [...]
        #   @note This method is generated with use of metaprogramming techniques
        #   @todo This method require the GUID as argument. For more information check out the examples below
        #
        # @!method display_user_id_logs
        #   display the +user_id logs (UID)+
        #   @param  argument [Integer] the user id
        #   @param  since [String] the log's initial period - **default**: +today+
        #   @param  to [String] the log's end period - **default**: +timenow+
        #   @param  lines [Integer] the log's number of lines - **default**: +10+
        #   @return [Array] a list of user id logs
        #   @example display the last 50 log lines of the UID 1000 ranging from a month ago to 10:00 of the current day
        #       Systemdy::Journal.display_user_id_logs(argument: 1000, since: '1 month ago', to: '10:00', lines: 50) #=> [...]
        #   @example display the last 20 log lines of the UID 1000 ranging from a week ago to yesterday
        #       Systemdy::Journal.display_user_id_logs(argument: 1000, since: '1 week ago', to: 'yesterday', lines: 20) #=> [...]
        #   @example You can also filter the logs by specific dates in the format 'YYYY-MM-DD'
        #       Systemdy::Journal.display_user_id_logs(argument: 1000, since: '2022-08-27', lines: 200) #=> [...]
        #   @note This method is generated with use of metaprogramming techniques
        #   @todo This method require the UID as argument. For more information check out the examples below
        #
        LIST_OF_OPTIONS_THAT_REQUIRE_AN_ARGUMENT.each do |from, option|
            define_singleton_method "display_#{from}_logs" do |argument: '', since: 'today', to: Time.now.strftime('%H:%M'), lines: 10|
                # return an error message if the required argument is not provided
                # render_message class method contained in Systemdy/utility/message_displayer.rb
                return render_message("display_#{from}_logs require an argument!") if argument.to_s.empty?
                # combination of option and argument based on typology
                # '-u postgresql' or '_GUID=1000' or '_UID=1000'
                option_with_argument = merge_option_with_argument_based_on_option_typology(from, option, argument)
                # logs from system call
                logs                 = `#{JOURNALCTL_COMMAND} #{option_with_argument} -S '#{since}' -U '#{to}' | tail -n #{lines} 2>&1`
                # logs from system call converted into array
                return_an_array_from_system_command(logs) # class method contained in Systemdy/utility/formatter.rb
            end
        end

        # @!scope class
        # @!method return_an_array_from_system_command
        #   @param system_call [String] system call to convert to an array
        #   @return [Array] an array-based list of the values ​​returned by making a system call
        #   @note check out more about this method in Systemdy/utility/formatter.rb
        #
        # @!scope class
        # @!method render_message
        #   @param message [String] the message to render 
        #   @return [String] the content of the message
        #   @note check out more about this method in Systemdy/utility/message_displayer.rb
        #

        # method for return formatted option
        #
        # @param  type [String] the type of command to bind
        # @param  option [String] the option 
        # @param  argument [String] the argument
        # @return [String] the formatted option
        # @example return formatted option
        #   merge_option_with_argument_based_on_option_typology(:unit, '-u', 'postgresql') #=> '-u postgresql'
        #   merge_option_with_argument_based_on_option_typology(:group_id, '_GUID', 1000) #=> '_GUID=1000'
        #   merge_option_with_argument_based_on_option_typology(:user_id, '_UID', 1000) #=> '_UID=1000'
        def self.merge_option_with_argument_based_on_option_typology(type, option, argument)
            type == :unit ? "#{option} #{argument}" : "#{option}=#{argument}"
        end

        # make the methods below as private
        private_class_method :return_an_array_from_system_command, :render_message, :merge_option_with_argument_based_on_option_typology
    end 
end    