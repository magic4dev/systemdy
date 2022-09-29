describe Systemd::Utility::KeyValueFilter do

    # test method for filter an hash with a list of provided key
    describe ".filter_by_keys" do

        let(:hash)          { { "Type"=>"oneshot", "Restart"=>"no", "NotifyAccess"=>"none" } }
        let(:filtered_hash) { { "Type"=>"oneshot", "Restart"=>"no" } }

        it "filter an hash with a list of provided keys" do
            # test filter_by_keys 
            expect(described_class).to respond_to("filter_by_keys")
            # test that a method return an hash
            expect(described_class.filter_by_keys(hash, "Type", "Restart")).to be_an_instance_of(Hash)
            # test that a method return an hash of size equal to the expected filtered hash
            expect(described_class.filter_by_keys(hash, "Type", "Restart").size).to eq filtered_hash.size
            # test that a method return to the expected filtered hash
            expect(described_class.filter_by_keys(hash, "Type", "Restart")).to eq filtered_hash
        end
    end
end