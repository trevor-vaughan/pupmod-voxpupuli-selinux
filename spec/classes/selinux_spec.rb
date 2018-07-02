require 'spec_helper'

describe 'vox_selinux' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to contain_class('vox_selinux').without_mode }
      it { is_expected.to contain_class('vox_selinux').without_type }
      it { is_expected.to contain_class('vox_selinux').without_module }
      it { is_expected.to contain_class('vox_selinux').without_port }
      it { is_expected.to contain_class('vox_selinux').without_fcontext }
      it { is_expected.to contain_class('vox_selinux').without_permissive }
      it { is_expected.to contain_class('vox_selinux::package') }
      it { is_expected.to contain_class('vox_selinux::config') }
      it { is_expected.to contain_class('vox_selinux::params') }
      it { is_expected.to contain_anchor('vox_selinux::start').that_comes_before('Class[vox_selinux::package]') }
      it { is_expected.to contain_anchor('vox_selinux::module pre').that_requires('Class[vox_selinux::config]') }
      it { is_expected.to contain_anchor('vox_selinux::module pre').that_comes_before('Anchor[vox_selinux::module post]') }
      it { is_expected.to contain_anchor('vox_selinux::module post').that_comes_before('Anchor[vox_selinux::end]') }
      it { is_expected.to contain_anchor('vox_selinux::end').that_requires('Anchor[vox_selinux::module post]') }

      context 'with module resources defined' do
        let(:params) do
          {
            module: {
              'mymodule1' =>  { 'source_te' => 'dummy' },
              'mymodule2' =>  { 'source_te' => 'dummy' }
            }
          }
        end

        it { is_expected.to contain_vox_selinux__module('mymodule1') }
        it { is_expected.to contain_vox_selinux__module('mymodule2') }
      end

      context 'with boolean resources defined' do
        let(:params) do
          {
            boolean: {
              'mybool1' => {},
              'mybool2' => {}
            }
          }
        end

        it { is_expected.to contain_vox_selinux__boolean('mybool1') }
        it { is_expected.to contain_vox_selinux__boolean('mybool2') }
      end

      context 'with port resources defined' do
        let(:params) do
          {
            port: {
              'myport1' => { 'seltype' => 'dummy', 'port' => 444, 'protocol' => 'tcp' },
              'myport2' => { 'seltype' => 'dummy', 'port' => 445, 'protocol' => 'tcp' }
            }
          }
        end

        it { is_expected.to contain_vox_selinux__port('myport1') }
        it { is_expected.to contain_vox_selinux__port('myport2') }
      end

      context 'with permissive resources defined' do
        let(:params) do
          {
            permissive: {
              'domain1' => { 'seltype' => 'domain1' },
              'domain2' => { 'seltype' => 'domain2' }
            }
          }
        end

        it { is_expected.to contain_vox_selinux__permissive('domain1') }
        it { is_expected.to contain_vox_selinux__permissive('domain2') }
      end

      context 'with fcontext resources defined' do
        let(:params) do
          {
            fcontext: {
              'myfcontext1'    => { 'seltype' => 'mysqld_log_t', 'pathspec' => '/u01/log/mysql(/.*)?' },
              'myfcontext2'    => { 'seltype' => 'mysqld_log_t', 'pathspec' => '/u02/log/mysql(/.*)?' },
              '/path/spec(.*)' => { 'seltype' => 'mysqld_log_t', 'pathspec' => '/path/spec(.*)' }
            }
          }
        end

        it { is_expected.to contain_vox_selinux__fcontext('myfcontext1') }
        it { is_expected.to contain_vox_selinux__fcontext('myfcontext2') }
        it { is_expected.to contain_vox_selinux__fcontext('/path/spec(.*)') }
      end
    end
  end
end
