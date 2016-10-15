require 'spec_helper'

describe 'thrift::instool', :type => :define do
  let(:title) { 'thrift-0.9.1' }
  shared_examples_for 'a linux os' do
    context 'With title \'thrift-0.9.1\' and param url => \'http://theurl\'' do
      let(:params) do
        {
          :url => 'http://theurl',
        }
      end
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_thrift__instool('thrift-0.9.1') }
      it { is_expected.to contain_class('ant') }
      it { is_expected.to contain_archive('download_and_untar') }
      it { is_expected.to contain_file('/usr/local/src/thrift-0.9.1').with_ensure('directory') }
      it { is_expected.to contain_exec('./configure --without-python --without-tests').that_comes_before('Exec[make]')}
      it { is_expected.to contain_exec('make').that_comes_before('Exec[make install]')}
      it { is_expected.to contain_exec('make install').that_comes_before('Exec[make clean]')}
      it { is_expected.to contain_exec('make clean')}
    end
  end
  context 'supported operating systems' do
    ['Debian', 'RedHat', 'Amazon'].each do |osfamily|
      let(:facts) {
        {
          :operatingsystem => osfamily,
          :osfamily => osfamily,
          :kernel => "Linux",
        }
      }
      it_behaves_like 'a linux os'
    end
  end
end
