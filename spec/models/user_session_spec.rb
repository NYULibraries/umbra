require 'spec_helper'

describe UserSession do

  setup :activate_authlogic

  let(:user_session) { UserSession.new }

  describe "#additional_attributes" do
    subject { user_session.additional_attributes }
    context "when there is no PDS user" do
      it { should be_empty }
    end
  end

end
