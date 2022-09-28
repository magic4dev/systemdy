describe Systemd::Journal do 
    
    # load shared variables for specs for avoid repetition
    log_variables # TestVariables module's method contained in spec/setup/test_variables.rb
    services_names # TestVariables module's method contained in spec/setup/test_variables.rb

    # test LIST_OF_OPTIONS_THAT_NOT_ACCEPT_ARGUMENTS constant
    it "has a list of options that not accept arguments" do
        expect(Systemd::Journal::LIST_OF_OPTIONS_THAT_NOT_ACCEPT_ARGUMENTS).to include({ kernel: '-k' })
    end

    # test LIST_OF_OPTIONS_THAT_ACCEPT_AN_ARGUMENT constant
    it "has a list of options that accept an argument" do
        expect(Systemd::Journal::LIST_OF_OPTIONS_THAT_ACCEPT_AN_ARGUMENT).to include({ boot: '-b' })
    end

    # test LIST_OF_OPTIONS_THAT_REQUIRE_AN_ARGUMENT constant
    it "has a list of options that require an argument" do
        expect(Systemd::Journal::LIST_OF_OPTIONS_THAT_REQUIRE_AN_ARGUMENT).to include({ unit: '-u', group_id: '_GID', user_id: '_UID' })
    end
    
    # dynamically test methods based on LIST_OF_OPTIONS_THAT_NOT_ACCEPT_ARGUMENTS constant
    Systemd::Journal::LIST_OF_OPTIONS_THAT_NOT_ACCEPT_ARGUMENTS.each do |message_from, option|
        describe ".display_#{message_from}_logs" do
            it "display logs for #{message_from}" do
                # test class method 
                expect(described_class).to respond_to("display_#{message_from}_logs")
                # test that returned option from the method is an array
                expect(described_class.send("display_#{message_from}_logs")).to be_an_instance_of(Array)
                # test that returned option from the method is an array with a default number of elements of 10
                expect(described_class.send("display_#{message_from}_logs").size).to eq log_number_of_lines
            end
        end
    end

    # dynamically test methods based on LIST_OF_OPTIONS_THAT_ACCEPT_AN_ARGUMENT constant
    Systemd::Journal::LIST_OF_OPTIONS_THAT_ACCEPT_AN_ARGUMENT.each do |message_from, option|
        describe ".display_#{message_from}_logs" do
            it "display logs for #{message_from}" do
                # test class method 
                expect(described_class).to respond_to("display_#{message_from}_logs")
                # test that returned option from the method is an array
                expect(described_class.send("display_#{message_from}_logs")).to be_an_instance_of(Array)
                # test that returned option from the method is an array with a default number of elements of 10
                expect(described_class.send("display_#{message_from}_logs").size).to be <= log_number_of_lines
            end
        end
    end

    # dynamically test methods based on LIST_OF_OPTIONS_THAT_REQUIRE_AN_ARGUMENT constant
    Systemd::Journal::LIST_OF_OPTIONS_THAT_REQUIRE_AN_ARGUMENT.each do |message_from, option|
        describe ".display_#{message_from}_logs" do
            it "display logs for #{message_from}" do
                # test class method 
                expect(described_class).to respond_to("display_#{message_from}_logs")
                case message_from
                when :unit
                    expect(described_class.send("display_#{message_from}_logs", argument: real_service_name)).to be_an_instance_of(Array)
                    expect(described_class.send("display_#{message_from}_logs", argument: real_service_name).size).to be <=  log_number_of_lines
                else !:unit
                    expect(described_class.send("display_#{message_from}_logs", argument: 1000)).to be_an_instance_of(Array)
                    expect(described_class.send("display_#{message_from}_logs", argument: 1000).size).to be <= log_number_of_lines
                end
            end
        end
    end

    # test when a required argument is not passed to a method that require an argument
    context "when a required argument is not passed to a method that require an argument" do 
        it "return the default error message" do 
            Systemd::Journal::LIST_OF_OPTIONS_THAT_REQUIRE_AN_ARGUMENT.each do |message_from, option|
                # call dynamically the method
                executed_method = described_class.send("display_#{message_from}_logs")
                # test display method if argument is not provided
                expect(executed_method).to eq "display_#{message_from}_logs require an argument!"
            end
        end
    end

    # test when a bad argument is passed to a method that accept or require an argument
    context "when a bad argument is passed to a method that accept or require an argument" do 
        it "return the default error message" do 
            Systemd::Journal::LIST_OF_OPTIONS_THAT_REQUIRE_AN_ARGUMENT.each do |message_from, option|
                case message_from
                when :unit
                    expect(described_class.send("display_#{message_from}_logs", argument: dummy_service_name)).to include("-- No entries --")
                else !:unit
                    expect(described_class.send("display_#{message_from}_logs", argument: 'absbc')).to include("-- No entries --")
                end
            end
        end
    end
end