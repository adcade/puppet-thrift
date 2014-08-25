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
    it { should contain_class('ant') }
    it { should contain_archive('download_and_untar') }
    it { should contain_file('/usr/local/src/thrift-0.9.1').with_ensure('directory') }
    it { should contain_exec('./configure --without-python --without-tests').that_comes_before('Exec[make]')}
    it { should contain_exec('make').that_comes_before('Exec[make install]')}
    it { should contain_exec('make install').that_comes_before('Exec[make clean]')}
    it { should contain_exec('make clean')}
  end
end
