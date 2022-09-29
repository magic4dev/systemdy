module Systemd
    module Utility 
        class KeyValueFilter
            # method for filter an hash with a list of provided keys
            def self.filter_by_keys(hash, *list_of_keys)
                filtered_hash = hash.slice(*list_of_keys.flatten) 
            end
        end
    end
end