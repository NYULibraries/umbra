require 'spec_helper'

describe Umbra::Record do

  describe ".index?" do

    subject { Umbra::Record.new }
    it { expect(subject.index?).to be_true }

  end

end
