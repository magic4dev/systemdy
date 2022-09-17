describe Systemd::Service do 

    subject { Systemd::Service.new('my-service') }

    it "has a list of supported actions on a service" do
        expect(Systemd::Service::LIST_OF_ACTIONS).to eq %w( start restart stop enable disable reload )
    end

    
    describe '#initialize' do
        it 'create a new object for control the provided service' do
            # test object's name attribute
            expect(subject.name).to eq 'my-service'
            # test object's command attribute
            expect(subject.command).to eq 'systemctl'
            # test object's founded attribute
            expect(subject.founded).to eq false
        end
    end

    # test method for check if a provided service exist
    describe "#exist?" do         
        it "check if a provided service exist" do 
            # test object's exist? method 
            expect(subject).to respond_to("exist?")

            # test system call from object's exist? method 
            expect(subject).to receive(:`).with("#{subject.command} list-units --type=service --all | grep -w #{subject.name}")
            # object's exist method 
            subject.send("exist?")
        end

        context "when a provided service exist" do 
            # the subject in this context is re-assigned for thest a real postgresql service
            subject { Systemd::Service.new('postgresql') }

            it "return true" do 
                expect(subject.send("exist?")).to eq true
            end
        end

        # the subject in this context is the dummy 'my-service' service
        context "when a provided service not exist" do 
            it "return false" do 
                expect(subject.send("exist?")).to eq false
            end
        end
    end

    # dynamically test methods based on LIST_OF_ACTIONS constant
    Systemd::Service::LIST_OF_ACTIONS.each do |action|
        describe "##{action}" do
            it "#{action} the created service" do
                # test object's action method 
                expect(subject).to respond_to("#{action}")

                # test system call from object's action method 
                expect(subject).to receive(:`).with("sudo #{subject.command} #{action} #{subject.name}")
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

            # test system call from object's status method 
            expect(subject).to receive(:`).with("#{subject.command} status #{subject.name}")
            # object's status method 
            subject.send("status")
        end
    end
end