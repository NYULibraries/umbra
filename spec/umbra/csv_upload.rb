require 'spec_helper'

describe Umbra::CsvUpload do

  let(:user) { create(:user_with_admin_collections) }
  let(:csv_file) { csv_fixture("csv_sample.csv") }
  let(:csv_upload) { Umbra::CsvUpload.new(csv_file, user) }

  describe ".new" do
    subject { csv_upload }
    context "when CSV file is blank" do
      let(:csv_file) { "" }
      expect { subject }.to raise_error(ArgumentError)
    end
  end

  describe "#upload" do
    subject { csv_upload.upload }

  end

end
