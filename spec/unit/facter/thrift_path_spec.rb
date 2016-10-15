require "spec_helper"

describe "Facter::Util::Fact" do
  before {
    Facter.clear
    allow(Facter.fact(:kernel)).to receive(:value).and_return("Linux")
  }

  describe "thrift_path" do
    it do
      allow(Facter::Util::Resolution).to receive(:exec).with("which thrift").
        and_return("/usr/local/bin/thrift")
      expect(Facter.fact(:thrift_path).value).to eql("/usr/local/bin/thrift")
    end
  end
end
