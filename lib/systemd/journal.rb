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

        # we delegate return_an_array_from to Systemd::Utility::Formatter return_an_array_from_system_command class method contained in systemd/utility/formatter.rb
        def_delegator Systemd::Utility::Formatter, :return_an_array_from_system_command

        LIST_OF_OPTIONS_THAT_NOT_ACCEPT_ARGUMENTS.each do |message_from, option|
            define_singleton_method "display_#{message_from}_logs" do |since: 'yesterday', to: Time.now.strftime('%H:%M'), lines: 10|
                logs = `#{JOURNALCTL_COMMAND} #{option} -S '#{since}' -U '#{to}' -n #{lines}`
                return_an_array_from_system_command(logs) # class method contained in systemd/utility/formatter.rb
            end
        end
        
        LIST_OF_OPTIONS_THAT_ACCEPT_AN_ARGUMENT.each do |message_from, option|
            define_singleton_method "display_#{message_from}_logs" do |argument: '', since: 'today', to: Time.now.strftime('%H:%M'), lines: 10|
                logs = `#{JOURNALCTL_COMMAND} #{option} #{argument} -S '#{since}' -U '#{to}' -n #{lines}`
                return_an_array_from_system_command(logs) # class method contained in systemd/utility/formatter.rb
            end
        end
        
        LIST_OF_OPTIONS_THAT_REQUIRE_AN_ARGUMENT.each do |message_from, option|
            define_singleton_method "display_#{message_from}_logs" do |argument: '', since: 'today', to: Time.now.strftime('%H:%M'), lines: 10|
                # logs = `#{JOURNALCTL_COMMAND} #{option} #{argument} -S '#{since}' -U '#{to}' -n #{lines}`
                # return_an_array_from_system_command(logs) # class method contained in systemd/utility/formatter.rb
            end
        end

        # make return_an_array_from method as private
        private_class_method :return_an_array_from_system_command

    end 
end    