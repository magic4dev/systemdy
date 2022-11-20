module Systemdy
    # A module that contains a set of useful classes for add utilities to the Systemdy's core
    module Utility 
        # Allows to formatting provided data into another type
        class Formatter
            # method for convert system calls into an array 
            #
            # @param  system_call [String] system call to convert to an array
            # @return [Array] an array-based list of the values ​​returned by making a system call
            # @example convert a backtick system call into an array
            #   list_of_files_in_my_folder = Systemdy::Utility::Formatter.return_an_array_from_system_command(`ls -la`)
            # @todo execute system calls with backtick instead of system() beacuse system() return only true or false and not the expected value
            def self.return_an_array_from_system_command(system_call)
                system_call_without_new_line = remove_newline_from_system_command(system_call)    # remove \n from system call returned value
                return system_call_without_new_line if !$?.success?                               # return system error message if the process has non-zero exit status
                return_an_array_from(system_call_without_new_line)                                # convert values returned by `` system call to an array-based list based on argument_splitter value
            end

            # method for convert a string into an array without blank elements
            #
            # @param  string_to_parse [String] string to convert to an array
            # @param  argument_splitter [String] character for split string to an array 
            # @param  remove_blank_elements [Boolean] remove blank elements or not 
            # @return [Array] an array-based list of the values ​​returned by argument_splitter
            # @example convert a complex string into an array 
            #   list_of_info = Systemdy::Utility::Formatter.return_an_array_from("5432/tcp  info", argument_splitter: '/', remove_blank_elements: false) #=> ["5432", "tcp", "", "", "info"]
            # @example convert a complex string into an array without blank elements
            #   list_of_info_without_blank_elements = Systemdy::Utility::Formatter.return_an_array_from("5432/tcp  info", argument_splitter: '/') #=> ["5432", "tcp", "info"]
            def self.return_an_array_from(string_to_parse, argument_splitter: '\n', remove_blank_elements: true)
                remove_blank_elements ? string_to_parse.split(/#{argument_splitter}/).reject(&:empty?) : string_to_parse.split(/#{argument_splitter}/) 
            end

            # method for remove +\n+ characters from system calls
            #
            # @param  system_call [String] system call to remove +\n+ characters from
            # @return [String] the result of a system call without +\n+ characters
            # @example remove +\n+ characters from system calls
            #   command_without_new_line = Systemdy::Utility::Formatter.remove_newline_from_system_command(`ls -la`)
            # @todo execute system calls with backtick instead of system() beacuse system() return only true or false and not the expected value
            def self.remove_newline_from_system_command(system_call)
                system_call.chomp!    # remove \n from system call returned value
            end
        end
    end
end