describe Systemd::Service do 

    subject               { Systemd::Service.new('postgresql') }
    let(:service_name)    { subject.name }
    let(:service_command) { subject.command }
    let(:service_founded) { subject.founded }

    # test LIST_OF_ACTIONS constant
    it "has a list of supported actions" do
        expect(Systemd::Service::LIST_OF_ACTIONS).to eq %w( start restart stop enable disable reload mask unmask )
    end
    
    # test LIST_OF_STATUSES constant
    it "has a list of supported statuses" do
        expect(Systemd::Service::LIST_OF_STATUSES).to eq %w( enabled active )
    end

    # test name attribute
    it "has a name attribute" do
        expect(service_name)
    end

    # test command attribute
    it "has a command attribute with default value 'systemctl'" do
        expect(service_command)
    end

    # test founded attribute
    it "has a founded boolean attribute" do
        expect(service_founded)
    end

    describe '#initialize' do
        it 'create a new object for control the provided service' do
            # test object's name attribute
            expect(service_name).to eq 'postgresql'
            # test object's command attribute
            expect(service_command).to eq 'systemctl'
            # test object's founded attribute
            expect(service_founded).to eq true
        end
    end

    # dynamically test methods based on LIST_OF_ACTIONS constant
    Systemd::Service::LIST_OF_ACTIONS.each do |action|
        describe "##{action}" do
            it "#{action} the created service" do
                # test object's action method 
                expect(subject).to respond_to("#{action}")
                # test system call from object's action method 
                expect(subject).to receive(:`).with("sudo #{service_command} #{action} #{service_name}")
                # object's action method 
                subject.send(action)
            end
        end
    end

    # test method for return the current status of the provided service
    describe "#status" do 
        it "return the current status of the provided service" do 
            # test object's status method 
            expect(subject).to respond_to("status")
            # test that returned value from object's status method is an array
            expect(subject.status).to be_an_instance_of(Array)
            # test that returned value from object's status method is an array with 5 elements
            expect(subject.status.size).to be 5
        end
    end

    # dynamically test methods based on LIST_OF_STATUSES constant
    Systemd::Service::LIST_OF_STATUSES.each do |status|
        describe "#is_#{status}?" do
            it "check if the created service is #{status}" do
                # test object's status method 
                expect(subject).to respond_to("is_#{status}?")
                # object's status method 
                expect(subject.send("is_#{status}?")).to eq true
            end
        end
    end

    # test when a provided service does not exist
    context "when a provided service does not exist" do 
        # the subject in this context is re-assigned for a dummy service
        subject { Systemd::Service.new('my-service') }

        # the default error message
        let(:default_error_message) { "Unit #{service_name}.service could not be found." }

        
        it "set founded instance variable to false" do 
            # test the exist? method
            expect(service_founded).to eq false
        end

        it "return the default error message" do 
            # test the status method
            expect(subject.status).to eq default_error_message
            # test the action method
            Systemd::Service::LIST_OF_ACTIONS.each do |action|
                expect(subject.send(action)).to eq default_error_message
            end
        end
    end
end