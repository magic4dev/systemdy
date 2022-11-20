## [0.4.1] - 2022-11-22

### Fixed

- Systemdy::Utility::Formatter return_an_array_from error for empty array and nil returned object

## [0.4.0] - 2022-11-22

### Added

- Systemdy::Utility::Formatter return_an_array_from class method for convert a complex string into array with custom splitter
- Systemdy::Service port method for return service port if available
- Systemdy::Service protocol method for return service protocol if available

### Changed

- Logic for Systemd::Utility::Formatter return_an_array_from_system_command class method 

## [0.3.2] - 2022-10-21 

### Fixed

- documentation_uri in gemspec

## [0.3.1] - 2022-10-21 

### Changed

- Documentation syntax for Systemdy::Utility::Formatter.remove_newline_from_system_command class method
- documentation_uri in gemspec

## [0.3.0] - 2022-10-21 

### Added

- Method remove_newline_from_system_command to Systemdy::Utility::Formatter class for remove \n characters from system calls

### Changed

- Logic for class Systemdy::Service is_active? and is_enabled? instance methods

## [0.2.1] - 2022-10-11 

### Fixed

- documentation_uri in gemspec

## [0.2.0] - 2022-10-10 

### Added

- Yard documentation of all gem's modules, classes, constants and methods(included methods generated with metaprogramming techniques)

## [0.1.0] - 2022-10-07 

### Added

- Yard-like comments for documentation of the remained gem's classes, constants and modules
- Yard-like comments for documentation of private methods

### Changed

- Changed markdown README.md structure for yard documentation

## [0.1.0] - 2022-10-06 

### Changed

- URL image path on README.md for proper yard documentation
- Comments in Systemdy::Utility::Validator class with a yard-like syntax for generate documentation
- Comments in Systemdy::Service with a yard-like syntax for generate documentation

## [0.1.0] - 2022-10-05 

### Changed

- Systemdy::Utility::Formatter comment section to yard-like syntax for generating documentation
- Variable name sudo_command to sudo in Systemdy::Service class
- Logic for the Systemdy::Utility::KeyValueFilter.filter_by_keys class method

### Added

- Yard-style comments for the Systemdy::Utility::Validator.check_if_a_service_exist class method
- Yard-style comments for the Systemdy::Utility::MessageDisplayer.display_message class method
- Yard-style comments for the Systemdy::Utility::KeyValueFilter.filter_by_keys class method

### Fixed 

- Yard params description in Systemdy::Utility::Formatter class

## [0.1.0] - 2022-10-04 

### Changed

- README.md for load image logo

### Added

- Image logo

## [0.1.0] - 2022-10-03 

### Changed

- Gem name from Systemd to Systemdy to avoid name conflicts with other rubygems with the same namespace

### Added

- Badges in README.md for render essential metadata of the project

## [0.1.0] - 2022-09-29 

### Changed

- Status method of Systemd::Service class
- Systemd::Utility::Validator.check_if_a_service_exist class method

### Added 

- Systemd::Utility::KeyValueFilter.filter_by_keys class method
- Systemd::Utility::KeyValueFilter class for filter hash with provided keys

## [0.1.0] - 2022-09-28 

### Changed

- Moved render_message method from Systemd::Utility::Validator class to Systemd::Utility::MessageDisplayer class

### Added

- Custom exception for Systemd::Utility::Formatter.return_an_array_from_system_command class method 
- Systemd::Utility::Formatter return_an_array_from_system_command class method 
- Systemd::Utility::Formatter class
- Systemd::Utility::MessageDisplayer class with render_message class method

## [0.1.0] - 2022-09-25 

### Added

- Custom test variables to TestVariables module in spec/setup/test_variables.rb with test refactor
- TestSetup module in spech_helper for share spec's variables

## [0.1.0] - 2022-09-23 

### Changed

- Systemd::Utility::Validator.exist? method with forwardable module for delegation pattern

## [0.1.0] - 2022-09-22 

### Changed

- Removed Systemd::Journal::Unit class in favour of a universal api design 

## [0.1.0] - 2022-09-19 

### Changed

- Methods is_active? and is_enabled? for return a boolean value instead of a string 

### Added

- Systemd::Journal::Unit.display_logs method for manage journalctl units
- Systemd::Journal::Unit class 

## [0.1.0] - 2022-09-18 

### Added

- Methods mask and unmask to the Systemd::Service class
- Methods is_enabled? and is_active? and rspec tests the Systemd::Service class for check if a service is enabled or active

## [0.1.0] - 2022-09-17 

### Changed 

- Values of gemspec code_of_conduct and changelog url paths

### Added

- Founded attribute to Systemd::Service class to mark a provided service if is found or not on the system
- Method exist? for check if a service exist
- Method status to Systemd::Service class with rspec test
- Actions method for execute different actions on a systemd service

## [0.1.0] - 2022-09-15

- Initial release