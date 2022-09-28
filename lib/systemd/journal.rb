module Systemd
    class Journal 

        # extend SingleForwardableForwardable standard's library module for delegate a specified method to a designated object
        extend SingleForwardable
               
        # list of options for execute journalctl command that not accept arguments
        # Example command: journalctl -k
        # the '-k' option not accept arguments
        # journalctl -k [argument] return
        # Failed to add match [argument]: Invalid argument
        LIST_OF_OPTIONS_THAT_NOT_ACCEPT_ARGUMENTS = { kernel: '-k' }
        
        # list of options for execute journalctl command that accept arguments
        # Example command: journalctl -b
        # the '-b' option accept an argument (the number of the boot)
        # journalctl -b postgresql return the boots's logs
        # journalctl -b 3 return the third of the availables boot logs
        LIST_OF_OPTIONS_THAT_ACCEPT_AN_ARGUMENT   = { boot: '-b' }

        # list of options for execute journalctl command that accept arguments
        # Example command: journalctl -u
        # the '-u' option require an argument (the name of the unit)
        # journalctl -u postgresql return the postgresql's logs
        # journalctl -u without an argument return
        # journalctl: option requires an argument -- 'u' 
        LIST_OF_OPTIONS_THAT_REQUIRE_AN_ARGUMENT  = { unit: '-u', group_id: '_GID', user_id: '_UID' }

        # we delegate return_an_array_from_system_command method to Systemd::Utility::Formatter class contained in systemd/utility/formatter.rb
        def_delegator Systemd::Utility::Formatter,        :return_an_array_from_system_command
        # we delegate render_message method to Systemd::Utility::MessageDisplayer class contained in systemd/utility/message_displayer.rb
        def_delegator Systemd::Utility::MessageDisplayer, :render_message 

        # create dynamically class methods based on LIST_OF_OPTIONS_THAT_NOT_ACCEPT_ARGUMENTS constant
        # we can call the methods:
        # Systemd::Journal.display_kernel_logs
        # this method accept 3 keyword arguments:
        # 1. since ('the log's initial period')  - String  - default 'yesterday' 
        # 2. to    ('the log's end period')      - String  - default Time.now.strftime('%H:%M')
        # 3. lines ('the log's number of lines') - Integer - default 10 .display_kernel_logs
        # Example:
        # Systemd::Journal.display_kernel_logs(since: '1 month ago', lines: 50)
        # if you call this method without arguments
        # - it return an array with 10 lines of logs
        LIST_OF_OPTIONS_THAT_NOT_ACCEPT_ARGUMENTS.each do |message_from, option|
            define_singleton_method "display_#{message_from}_logs" do |since: 'today', to: Time.now.strftime('%H:%M'), lines: 10|
                # logs from system call
                logs = `#{JOURNALCTL_COMMAND} #{option} -S '#{since}' -U '#{to}' -n #{lines} 2>&1`
                # logs from system call converted into array
                return_an_array_from_system_command(logs) # class method contained in systemd/utility/formatter.rb
            end
        end
        
        # create dynamically class methods based on LIST_OF_OPTIONS_THAT_ACCEPT_AN_ARGUMENT constant
        # we can call the methods:
        # Systemd::Journal.display_boot_logs
        # this method accept 4 keyword arguments:
        # 1. argument ('the boot's number')      - Integer - optional
        # 2. since ('the log's initial period')  - String  - default 'yesterday' 
        # 3. to    ('the log's end period')      - String  - default Time.now.strftime('%H:%M')
        # 4. lines ('the log's number of lines') - Integer - default 10 
        # Example:
        # Systemd::Journal.display_boot_logs(argument: 3, since: '1 month ago', lines: 50)
        # if you call this method without arguments
        # - it return an array with 10 lines of logs
        LIST_OF_OPTIONS_THAT_ACCEPT_AN_ARGUMENT.each do |message_from, option|
            define_singleton_method "display_#{message_from}_logs" do |argument: '', since: 'today', to: Time.now.strftime('%H:%M'), lines: 10|
                # logs from system call
                logs = `#{JOURNALCTL_COMMAND} #{option} #{argument} -S '#{since}' -U '#{to}' -n #{lines} 2>&1`
                # logs from system call converted into array
                return_an_array_from_system_command(logs) # class method contained in systemd/utility/formatter.rb
            end
        end
        
        # create dynamically class methods based on LIST_OF_OPTIONS_THAT_REQUIRE_AN_ARGUMENT constant
        # we can call the methods:
        # Systemd::Journal.display_unit_logs
        # Systemd::Journal.display_group_id_logs
        # Systemd::Journal.display_user_id_logs
        # this method accept 4 keyword arguments:
        # 1. argument ('the unit, the group_id or user_id) - String  - required
        # 2. since ('the log's initial period')  - String  - default 'yesterday' 
        # 3. to    ('the log's end period')      - String  - default Time.now.strftime('%H:%M')
        # 4. lines ('the log's number of lines') - Integer - default 10 
        # Example:
        # Systemd::Journal.display_unit_logs(argument: 'postgresql', since: '1 month ago', lines: 50)
        # Systemd::Journal.display_user_id_logs(argument: 1000, since: '1 month ago', lines: 50)
        # Systemd::Journal.display_group_id_logs(argument: 1000, since: '1 month ago', lines: 50)
        LIST_OF_OPTIONS_THAT_REQUIRE_AN_ARGUMENT.each do |message_from, option|
            define_singleton_method "display_#{message_from}_logs" do |argument: '', since: 'today', to: Time.now.strftime('%H:%M'), lines: 10|
                # return an error message if the required argument is not provided
                # render_message class method contained in systemd/utility/message_displayer.rb
                return render_message("display_#{message_from}_logs require an argument!") if argument.to_s.empty?
                # combination of option and argument based on typology
                # '-u postgresql' or '_GUID=1000' or '_UID=1000'
                option_with_argument = merge_option_with_argument_based_on_option_tipology(message_from, option, argument)
                # logs from system call
                logs                 = `#{JOURNALCTL_COMMAND} #{option_with_argument} -S '#{since}' -U '#{to}' -n #{lines} 2>&1`
                # logs from system call converted into array
                return_an_array_from_system_command(logs) # class method contained in systemd/utility/formatter.rb
            end
        end

        # method for return formatted option
        # Example
        # merge_option_with_argument_based_on_option_tipology(:unit, '-u', 'postgresql') return
        # '-u postgresql'
        # merge_option_with_argument_based_on_option_tipology(:group_id, '_GUID', 1234566) return
        # '_GUID=1000'
        def self.merge_option_with_argument_based_on_option_tipology(message_from, option, argument)
            message_from == :unit ? "#{option} #{argument}" : "#{option}=#{argument}"
        end

        # make the methods below as private
        private_class_method :return_an_array_from_system_command, :render_message, :merge_option_with_argument_based_on_option_tipology

    end 
end    