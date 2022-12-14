describe Systemdy::Utility::Formatter do

    # a sample linux command
    let(:sample_command) { `ls -la` }

    # test method for convert `` calls to array based list
    describe ".return_an_array_from_system_command" do
        it "convert `` system call to array based list" do
            # test return_an_array_from_system_command
            expect(described_class).to respond_to("return_an_array_from_system_command").with(1).arguments
            # test class method result
            expect(described_class.return_an_array_from_system_command(sample_command)).to be_an_instance_of(Array)
        end
    end

    # test method for convert a complex string to array based list
    describe ".return_an_array_from" do
        it "convert a complex string to array based list" do
            # test return_an_array_from
            expect(described_class).to respond_to("return_an_array_from")
            # test class method result
            expect(described_class.return_an_array_from_system_command(sample_command)).to be_an_instance_of(Array)
        end
    end

    # test method for remove '\n' from `` calls to array based list
    describe ".remove_newline_from_system_command" do
        it 'remove \n from `` system calls' do
            # test remove_newline_from_system_command
            expect(described_class).to respond_to("remove_newline_from_system_command").with(1).arguments
            # test class method result
            expect(described_class.remove_newline_from_system_command(sample_command)).to_not include('\n')
        end
    end
end