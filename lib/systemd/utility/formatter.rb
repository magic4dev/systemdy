module Systemd
    module Utility 
        class Formatter
            # method for convert `` system call to array based list
            def self.return_an_array_from_system_command(system_call)
                # remove \n from system call returned value
                system_call_without_new_line = system_call.chomp!
                # return system error message 
                return(system_call_without_new_line) if !$?.success?
                # convert `` system call to array based list
                system_call_without_new_line.split(/\n/)
            end
        end
    end
end