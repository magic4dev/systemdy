describe Systemd::Service do 

    # load shared variables for specs for avoid repetition
    systemd_module_constant # TestVariables module's method contained in spec/setup/test_variables.rb
    services_names # TestVariables module's method contained in spec/setup/test_variables.rb
    initialized_services # TestVariables module's method contained in spec/setup/test_variables.rb
    services_attributes # TestVariables module's method contained in spec/setup/test_variables.rb

    # test LIST_OF_ACTIONS constant
    it "has a list of supported actions" do
        expect(Systemd::Service::LIST_OF_ACTIONS).to eq %w( start restart stop enable disable reload mask unmask )
    end
    
    # test LIST_OF_STATUSES constant
    it "has a list of supported statuses" do
        expect(Systemd::Service::LIST_OF_STATUSES).to eq %w( enabled active )
    end

    # test LIST_OF_STATUS_PROPERTIES constant 
    it "has a list of status properties" do
        expect(Systemd::Service::LIST_OF_STATUS_PROPERTIES).to eq %w( Id Description ExecMainPID LoadState 
            ActiveState FragmentPath ActiveEnterTimestamp InactiveEnterTimestamp ActiveExitTimestamp InactiveExitTimestamp
        )
    end 

    # test name attribute
    it "has a name attribute" do
        expect(real_service_name_attribute)
    end

    # test command attribute
    it "has a command attribute with default value 'systemctl'" do
        expect(real_service_command_attribute)
    end

    describe '#initialize' do
        it "create a new object for control the provided service" do
            # test object's name attribute
            expect(real_service_name_attribute).to eq real_service_name
            # test object's command attribute
            expect(real_service_command_attribute).to eq systemclt_command_constant
        end
    end

    # test method exist? for check if provided service exist
    describe '#exist?' do
        it "check if provided service exist" do
            # test exist? method
            expect(real_service).to respond_to("exist?")
        end
    end

    # dynamically test methods based on LIST_OF_ACTIONS constant
    Systemd::Service::LIST_OF_ACTIONS.each do |action|
        describe "##{action}" do
            it "#{action} the created service" do
                # test object's action method 
                expect(real_service).to respond_to("#{action}")
                # test system call from object's action method 
                expect(real_service).to receive(:`).with("sudo #{real_service_command_attribute} #{action} #{real_service_name_attribute}")
                # object's action method 
                real_service.send(action)
            end
        end
    end

    # test method for return a key/value pair of the provided service's properties
    describe "#properties" do 
        it "return a key/value pair of the provided service's properties" do 
            # test object's status method 
            expect(real_service).to respond_to("properties")
            # test that returned value from object's status method is an array
            expect(real_service.properties).to be_an_instance_of(Hash)
        end
    end

    # test method for return the current status of the provided service
    describe "#status" do 
        it "return the current status of the provided service" do 
            # test object's status method 
            expect(real_service).to respond_to("status")
            # test that returned value from object's status method is an hash
            expect(real_service.status).to be_an_instance_of(Hash)
            # test that returned value is an hash with a number of elements equal to Systemd::Service::LIST_OF_STATUS_PROPERTIES elements 
            expect(real_service.status.size).to eq Systemd::Service::LIST_OF_STATUS_PROPERTIES.size
        end
    end

    # dynamically test methods based on LIST_OF_STATUSES constant
    Systemd::Service::LIST_OF_STATUSES.each do |status|
        describe "#is_#{status}?" do
            it "check if the created service is #{status}" do
                # test object's status method 
                expect(real_service).to respond_to("is_#{status}?")
                # object's status method 
                expect(real_service.send("is_#{status}?")).to eq true
            end
        end
    end

    # test when a provided service does not exist
    context "when a provided service does not exist" do 
        # the default error message
        let(:default_error_message) { "Unit #{dummy_service.name}.service could not be found." }

        it "return the default error message" do 
            # test the status method
            expect(dummy_service.status).to eq default_error_message
            # test the action method
            Systemd::Service::LIST_OF_ACTIONS.each do |action|
                expect(dummy_service.send(action)).to eq default_error_message
            end
        end
    end
end