describe Systemd::Utility::Validator do

    # load shared variables for specs for avoid repetition
    services_names # TestVariables module's method contained in spec/setup/test_variables.rb

    # test method for check if a service or unit exist
    describe ".check_if_a_service_exist" do
        it "check if a provided service or unit exist" do
            # test check_if_a_service_exist method for real service
            expect(described_class).to respond_to("check_if_a_service_exist")
            # test a method with a real systemd service
            expect(described_class.check_if_a_service_exist(real_service_name)).to eq true
        end

        # test when a provided service or unit not exist
        context "when a provided service or unit does not exist" do 
            # test check_if_a_service_exist method for dummy service
            it "return false" do 
                # test a method with a dummy systemd service
                expect(described_class.check_if_a_service_exist(dummy_service_name)).to eq false
            end
        end
    end
end