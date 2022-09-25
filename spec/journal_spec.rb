# describe Systemd::Journal::Unit do 

#     subject                   { Systemd::Journal::Unit.new('postgresql') }
#     let(:unit_name)           { subject.name }
#     let(:unit_command)        { subject.command }
#     let(:unit_founded)        { subject.founded }

#     # log variables
#     let(:log_start_period)    { '1 week ago' }
#     let(:log_end_period)      { '15:00' }
#     let(:log_number_of_lines) { 10 }

#     # test name attribute
#     it "has a unit attribute" do 
#         expect(unit_name) 
#     end

#     # test command attribute
#     it "has a command attribute with default value 'journalctl'" do 
#         expect(unit_command) 
#     end

#     # test founded attribute
#     it "has a founded boolean attribute" do 
#         expect(unit_founded)
#     end

#     describe '#initialize' do
#         it 'create a new object for manage journactl utility for the provided unit' do
#             # test object's name attribute
#             expect(unit_name).to eq 'postgresql'
#             # test object's command attribute
#             expect(unit_command).to eq 'journalctl'
#             # test object's founded attribute
#             expect(unit_founded).to eq true
#         end
#     end    

#     # test method for display the logs of a provided unit
#     describe '#display_logs' do
#         it 'display logs of a provided unit' do
#             # test method arguments type
#             expect(subject).to respond_to("display_logs") do |first_argument, second_argument, third_argument|
#                 expect(first_argument).to be_an_instance_of(String)
#                 expect(second_argument).to be_an_instance_of(String)
#                 expect(third_argument).to be_an_instance_of(Integer)
#             end
#             # test that returned value from display_logs method is an array
#             expect(subject.display_logs(since: log_start_period, to: log_end_period, lines: log_number_of_lines)).to be_an_instance_of(Array)
#             # test that returned value from display_logs method is an array with a number of elements equal to number_of_lines argument
#             expect(subject.display_logs(since: log_start_period, to: log_end_period, lines: log_number_of_lines).size).to eq log_number_of_lines
#         end

#         # test when no arguments are provided
#         context "when no arguments are provided" do 
#             it "return the last 10 lines of logs for the provided unit" do 
#                 # test that returned value from display_logs method is an array with a number of elements equal to 10 (the default lines of logs for the provided unit)
#                 expect(subject.display_logs.size).to eq log_number_of_lines
#             end
#         end

#         # test when provided arguments are incorrect
#         context "when provided arguments are incorrect" do 
#             it "return the default error message" do 
#                 # test display_logs method with default journalctl error
#                 expect(subject.display_logs(since: 'an incorrect period', to: 'another incorrect period', lines: log_number_of_lines)).to match(/Failed to parse/)
#             end
#         end

#         # test when provided arguments are incorrect
#         context "when argument types are incorrect" do 

#             # the rescue nomethod error message
#             let(:method_error) { "Sorry but you have provided bad argument type!" }

#             it "return the bad arguments message" do 
#                 # test display_logs method with bad_arguments_message error method
#                 allow(subject).to receive('display_logs').with(since: 1, lines: log_number_of_lines).once.and_call_original
#                 expect(subject.display_logs(since: 1, lines: log_number_of_lines)).to eq method_error
#             end
#         end
#     end

#     # test when a provided unit does not exist
#     context "when a provided unit does not exist" do 
#         # the subject in this context is re-assigned for a dummy unit
#         subject { Systemd::Journal::Unit.new('my-service') }

#         it "set founded instance variable to false" do 
#             # test the exist? method
#             expect(unit_founded).to eq false
#         end

#         # the default error message
#         let(:default_error_message) { "-- No entries --" }

#         it "return the default error message" do 
#             # test display_logs method
#             expect(subject.display_logs(since: log_start_period, to: log_end_period, lines: log_number_of_lines)).to eq default_error_message
#         end
#     end
# end