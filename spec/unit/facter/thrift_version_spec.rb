require "spec_helper"

describe "Facter::Util::Fact" do
  before {
    Facter.clear
    allow(Facter.fact(:kernel)).to receive(:value).and_return("Linux")
  }

  describe "thrift_version" do
    it do
      allow(Facter::Util::Resolution).to receive(:exec).with("thrift --version").
        and_return("Thrift version 0.9.0")
      expect(Facter.fact(:thrift_version).value).to eql("0.9.0")
    end
  end
end
