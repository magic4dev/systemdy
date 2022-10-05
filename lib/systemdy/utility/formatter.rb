module Systemdy
    # A module that contains a set of useful classes for add utilities to the Systemdy's core
    module Utility 
        # Allows to formatting provided data into another type
        class Formatter
            # a method for convert system calls into an array 
            #
            # @param  [String] a system call to convert to an array
            # @return [Array]  an array based list of a system call execution
            # @example convert a backtick system call into an array
            #   list_of_files_in_my_folder = Systemdy::Utility::Formatter.return_an_array_from_system_command(`ls -la`)
            # @todo execute system calls with backtick instead of system() beacuse system() return only true or false and not the data that you expect
            def self.return_an_array_from_system_command(system_call)
                system_call_without_new_line = system_call.chomp!    # remove \n from system call returned value
                return(system_call_without_new_line) if !$?.success? # return system error message if the process has non-zero exit status
                system_call_without_new_line.split(/\n/)             # convert `` system call to array based list
            end
        end
    end
end