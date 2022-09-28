module Systemd
    module Utility 
        class Formatter
            # method for convert `` system call to array based list
            def self.return_an_array_from_system_command(system_call)
                system_call.chomp!.split(/\n/)
            end
        end
    end
end