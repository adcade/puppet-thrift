require 'spec_helper'

describe 'thrift::instool', :type => :define do
  let(:title) { 'thrift-0.9.1' }
  context 'With title \'thrift-0.9.1\' and param url => \'http://theurl\'' do
    let(:params) do
      {
        :url => 'http://theurl',
      }
    end
    it { should compile.with_all_deps }
    it { should contain_thrift__instool('thrift-0.9.1') }
    it { should contain_class('wget') }
    ['make', 'tar'].each do |package|
      it { should contain_package(package) }
    end
    it { should contain_file('/tmp/thrift-0.9.1').with(
      'ensure' => 'directory'
    ) }
    it { should contain_exec('download_and_untar').with(
      'command' => 'wget -qO- http://theurl | tar xzf - -C /tmp'
    ) }
    it { should contain_file('/usr/local/lib/thrift-0.9.1').with(
      'ensure' => 'directory',
      'recurse' => 'true',
      'source' => '/tmp/thrift-0.9.1'
    ) }
    ['./configure --without-python --without-tests', 'make', 'make install', 'make clean'].each do |exec|
      it { should contain_exec(exec).with(
        'cwd' => '/usr/local/lib/thrift-0.9.1'
      ) }
    end
  end
end
