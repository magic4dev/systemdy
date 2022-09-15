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
        end
    end

    # dynamically test methods based on LIST_OF_ACTIONS constant
    Systemd::Service::LIST_OF_ACTIONS.each do |action|
        describe "##{action}" do
            it "#{action} the created service" do
                # test object's action method 
                expect(subject).to respond_to("#{action}")

                # object's action method 
                action_method = subject.send(action)
                # test returned value from object's action method 
                expect(action_method).to eq "#{subject.command} #{action} #{subject.name}"
            end
        end
    end
end