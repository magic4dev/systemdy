describe Systemd::Journal::Unit do 

    subject                   { Systemd::Journal::Unit.new('postgresql') }
    let(:unit_name)           { subject.unit }
    let(:unit_command)        { subject.command }
    let(:unit_founded)        { subject.founded }

    # log variables
    let(:log_start_period)    { 'today'  }
    let(:log_end_period)      { '15:00' }
    let(:log_number_of_lines) { 9 }

    # test name attribute
    it "has a unit attribute" do 
        expect(unit_name) 
    end

    # test command attribute
    it "has a command attribute with default value 'journalctl'" do 
        expect(unit_command) 
    end

    # test founded attribute
    it "has a founded boolean attribute" do 
        expect(unit_founded)
    end

    describe '#initialize' do
        it 'create a new object for control the provided unit service' do
            # test object's name attribute
            expect(unit_name).to eq 'postgresql'
            # test object's command attribute
            expect(unit_command).to eq 'journalctl'
            # test object's founded attribute
            expect(unit_founded).to eq true
        end
    end

    # test method for check if a provided unit exist
    describe '#exists?' do
        it 'check if a provided unit exist' do
            allow(subject).to receive("exists?").and_return(true)
        end

        # test when a provided unit does not exist
        context "when a provided unit does not exist" do 
            # the subject in this context is re-assigned for a dummy service
            subject { Systemd::Journal::Unit.new('my-service') }

            # the default error message
            let(:default_error_message) { "-- No entries --" }

            it "set founded instance variable to false" do 
                # test the exist? method
                expect(unit_founded).to eq false
            end
        end
    end

    # test method for display the logs of a provided unit
    describe '#display_logs' do
        it 'display logs of a provided unit' do
            # test method arguments type
            expect(subject).to respond_to("display_logs") do |first_argument, second_argument, third_argument|
                expect(first_argument).to be_an_instance_of(String)
                expect(second_argument).to be_an_instance_of(String)
                expect(third_argument).to be_an_instance_of(Integer)
            end
            # test that returned value from display_logs method is an array
            expect(subject.display_logs(log_start_period, log_end_period, log_number_of_lines)).to be_an_instance_of(Array)
            # test that returned value from display_logs method is an array with a number of elements equal to number_of_lines argument
            expect(subject.display_logs(log_start_period, log_end_period, log_number_of_lines).size).to eq log_number_of_lines
        end
    end
end