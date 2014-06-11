require 'spec_helper'

describe ApplicationController do
  describe "#repository_info" do
    subject(:repository_info) { controller.repository_info }
    it { should be_instance_of(HashWithIndifferentAccess) }

    context "when repository is VBL" do
      subject(:repository) { repository_info[:repositories][:vbl] }
      it { expect(repository[:display]).to eql("Virtual Business Library") }
      it { expect(repository[:url]).to eql("vbl") }
      it { expect(repository[:admin_code]).to eql("VBL") }
    end

    context "when repository is DataServices " do
      subject(:repository) { repository_info[:repositories][:dataservices] }
      it { expect(repository[:display]).to eql("Data Services") }
      it { expect(repository[:url]).to eql("dataservices") }
      it { expect(repository[:admin_code]).to eql("DataServices") }
    end
  end
end
