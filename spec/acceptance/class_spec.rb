require 'spec_helper_acceptance'

describe 'thrift class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
      include thrift
      EOS

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end
  end
  context 'with $version => "0.9.0"' do
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'thrift':
        version => '0.9.0',
      }
      EOS

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end
  end
  context 'with $base_url => "http://apache.mirrors.pair.com/thrift/"' do
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'thrift':
        base_url => 'http://apache.mirrors.pair.com/thrift/',
      }
      EOS

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end
  end
end
