require 'spec_helper'

describe 'thrift', :type => :class do

  shared_examples_for 'a linux os' do
    context 'with default params' do
      it { should compile.with_all_deps }
      it { should contain_class('thrift').with(
        'version' => '0.9.1',
        'base_url' => 'https://archive.apache.org/dist/thrift'
      ) }
      it { should contain_thrift__instool('thrift-0.9.1').with(
        'url' => 'https://archive.apache.org/dist/thrift/0.9.1/thrift-0.9.1.tar.gz'
      ) }
    end
    context 'with param $version => "0.9.0"' do
      let(:params) {{ :version => '0.9.0' }}
      it { should compile.with_all_deps }
      it { should contain_class('thrift').with(
        'version' => '0.9.0',
        'base_url' => 'https://archive.apache.org/dist/thrift'
      ) }
      it { should contain_thrift__instool('thrift-0.9.0').with(
        'url' => 'https://archive.apache.org/dist/thrift/0.9.0/thrift-0.9.0.tar.gz'
      ) }
    end
    context 'with param $base_url => "http://hostname/path"' do
      let(:params) {{ :base_url => 'http://hostname/path' }}
      it { should compile.with_all_deps }
      it { should contain_class('thrift').with(
        'version' => '0.9.1',
        'base_url' => 'http://hostname/path'
      ) }
      it { should contain_thrift__instool('thrift-0.9.1').with(
        'url' => 'http://hostname/path/0.9.1/thrift-0.9.1.tar.gz'
      )
      }
    end
    context 'with param $base_url => "http://hostname/path" and $version => "0.9.0"' do
      let(:params) {
        { 
          :version => '0.9.0',
          :base_url => 'http://hostname/path',
        }
      }
      it { should compile.with_all_deps }
      it { should contain_class('thrift').with(
        'version' => '0.9.0',
        'base_url' => 'http://hostname/path'
      ) }
      it { should contain_thrift__instool('thrift-0.9.0').with(
        'url' => 'http://hostname/path/0.9.0/thrift-0.9.0.tar.gz'
      )
      }
    end
  end

  context 'supported operating systems' do
    ['Debian', 'RedHat', 'Amazon'].each do |osfamily|
      describe "thrift class without any parameters on #{osfamily}" do
        let(:facts) {{ :osfamily => osfamily, }}
        it_behaves_like 'a linux os' do
        end
      end
    end
  end
  context 'unsupported operating systems' do
    let(:facts) {{ :osfamily => 'xxx' }}
    it 'should fail if operating system family not supported' do
      expect { should compile }.to raise_error(/not supported/)
    end
  end
end
