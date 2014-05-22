require 'spec_helper'

describe UserSession do

  setup :activate_authlogic

  let(:user_session) { UserSession.new }

  describe "#additional_attributes" do
    subject { user_session.additional_attributes }

    xit { should eql "" }

  end

end
