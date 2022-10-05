module Systemdy
    # A module that contains a set of useful classes for add utilities to the Systemdy's core
    module Utility 
        # Allows to filter a key/value dataset
        class KeyValueFilter
            # a method for filter an hash with a list of provided keys
            #
            # @param hash [Hash] the hash to filter
            # @param list_of_keys [Array] the list of keys to extract from the hash
            # @return [Hash] a new hash that contains only the required keys
            # @example a very large hash to filter
            #   tasks = { task_one: 'learn ruby', task_two: 'learn rspec', task_three: 'create a good documentation', ... } 
            # @example hash filtered with provided keys
            #   filtered_hash = Systemdy::Utility::KeyValueFilter.filter_by_keys(tasks, 'task_one', 'task_two')
            #   #=> {"task_one"=>"learn ruby", "task_two"=>"learn rspec"}
            def self.filter_by_keys(hash, *list_of_keys)
                # convert all hash keys from :key to "key"
                hash_keys_converted_into_string      = Hash[hash.map{ |key, value| [key.to_s, value] }] 
                # convert array elements from ":key" to "key"
                array_elements_converted_into_string = list_of_keys.flatten.map { |element| element.start_with?(':') ? element.gsub(':','') : element }
                # return an hash with only provided keys 
                hash_keys_converted_into_string.slice(*array_elements_converted_into_string) 
            end
        end
    end
end