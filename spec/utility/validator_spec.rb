describe Systemd::Utility::Validator do

    # load shared variables for specs for avoid repetition
    provided_services_as_argument_for_initialization # TestVariables module's method contained in spec/setup/test_variables.rb
    initialized_validators # TestVariables module's method contained in spec/setup/test_variables.rb

    # test service attribute
    it "has a service attribute" do 
        expect(real_service_validator.service) 
    end

    describe '#initialize' do
        it 'create a new validator for the provided service' do
            # test object's service attribute
            expect(real_service_validator.service).to eq real_service_name
        end
    end  
    
    # test method render a custom message if an error occurred
    describe "#render_message" do
        it "it render a custom message if an error occurred" do
            # test render_message method for real service
            expect(real_service_validator).to respond_to("render_message").with(1).arguments
        end
    end

    # test method for check if a service exist
    describe "#check_if_a_service_exist" do
        it "check if a provided service or unit exist" do
            # test check_if_a_service_exist method for real service
            expect(real_service_validator).to respond_to("check_if_a_service_exist")
            # test a method with a real systemd service
            expect(real_service_validator.check_if_a_service_exist).to eq true
        end

        # test when a provided service not exist
        context "when a provided service does not exist" do 
            # test check_if_a_service_exist method for dummy service
            it "return false" do 
                # test a method with a dummy systemd service
                expect(dummy_service_validator.check_if_a_service_exist).to eq false
            end
        end
    end
end