describe Systemd::Utility::Validator do

    # load shared variables for specs for avoid repetition
    test_variables # method contained TestSetup module in spec/spech_helper

    # test variables
    let(:real_service)  { Systemd::Utility::Validator.new real_service_name}
    let(:dummy_service) { Systemd::Utility::Validator.new dummy_service_name}
    let(:service_name)  { real_service.service }

    # test service attribute
    it "has a service attribute" do 
        expect(service_name) 
    end

    describe '#initialize' do
        it 'create a new validator for the provided service' do
            # test object's service attribute
            expect(service_name).to eq 'postgresql'
        end
    end    

    # test method for check if a service exist
    describe "#check_if_a_service_exist" do
        it "check if a provided service or unit exist" do
            # test check_if_a_service_exist method for real service
            expect(real_service).to respond_to("check_if_a_service_exist")
            # test a method with a real systemd service
            expect(real_service.check_if_a_service_exist).to eq true
        end

        # test when a provided service not exist
        context "when a provided service does not exist" do 
            # test check_if_a_service_exist method for dummy service
            it "return false" do 
                # test a method with a dummy systemd service
                expect(dummy_service.check_if_a_service_exist).to eq false
            end
        end
    end
end