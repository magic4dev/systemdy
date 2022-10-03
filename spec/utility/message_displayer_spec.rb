describe Systemdy::Utility::MessageDisplayer do

    # test method for render a custom message tho the user
    describe ".render_message" do
        it "return a custom message to the user" do
            # test render_message method for real service
            expect(described_class).to respond_to("render_message").with(1).arguments
            # test render_message method with a dummy message
            expect(described_class.render_message('my message')).to eq 'my message'
        end
    end
end