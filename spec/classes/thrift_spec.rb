require 'spec_helper'

describe 'thrift', :type => :class do

  shared_examples 'on a Linux OS' do
    it { should compile.with_all_deps }
    it { should contain_class('thrift') }
    it { should contain_thrift__instool('thrift-0.9.1') }
  end

  context 'On Debian' do
    let(:facts) do
      {
        :osfamily => 'Debian'
      }
    end
    it_behaves_like 'on a Linux OS' do

    end
  end
  context 'On Redhat' do
    let(:facts) do
      {
        :osfamily => 'RedHat'
      }
    end
    it_behaves_like 'on a Linux OS' do

    end
  end
  context 'On Amazon' do
    let(:facts) do
      {
        :osfamily => 'Amazon'
      }
    end
    it_behaves_like 'on a Linux OS' do

    end
  end
  context 'On another OS' do
    let(:facts) do
      {
        :osfamily => 'xxx'
      }
    end
    it "should fail if OS family not supported" do
      expect { should compile }.to raise_error(/Unsupported OS Family/)
    end
  end
end
