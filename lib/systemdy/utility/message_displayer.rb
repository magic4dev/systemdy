module Systemdy
    # A module that contains a set of useful classes for add utilities to the Systemdy's core
    module Utility 
        # Allows to display messages to the user
        class MessageDisplayer
            # a method for render custom message to the user
            #
            # @param message [String] the message to render 
            # @return [String] the content of the message
            # @example a custom message to show to the user
            #   custom_message = Systemdy::Utility::MessageDisplayer.render_message('my custom message')
            #   #=> "my custom message"
            def self.render_message(message)
                message # the content of the message
            end
        end
    end
end