require 'spec_helper'

describe 'storm_webdav' do

  let(:facts) { { :osfamily => 'RedHat' } }

  context 'with default values for all parameters' do

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('storm_webdav::install') }

    it { is_expected.to contain_file('/storage').with( 
      :owner => 'storm',
      :group => 'storm',
      :ensure => 'directory'
    )}

    it { is_expected.to contain_user('storm').with(
      :ensure => 'present'
    )}
  end

  context 'with not default values for all parameters' do

    let(:params) do 
      {
        'storm_user_name' => 'test',
        'storm_storage_root_directory' => '/another_storage'
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('storm_webdav::install') }

    it { is_expected.to contain_file('/another_storage').with( 
      :owner => 'test',
      :group => 'test',
      :ensure => 'directory'
    )}

    it { is_expected.to contain_user('test').with(
      :ensure => 'present'
    )}
  end
end
