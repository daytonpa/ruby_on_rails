#
# Cookbook Name:: ruby_on_rails
# Spec:: default
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'ruby_on_rails::default' do
  { 'ubuntu' => '16.04',
    'centos' => '7.2.1511'
  }.each do |platform, v|
    context "When installing Ruby on Rails on #{platform.capitalize} #{v}, with default attributes" do
      let(:version) { '5.0.1' }
      let(:user) { 'default' }
      let(:group) { 'default' }

      let(:chef_run) do
        ChefSpec::ServerRunner.new(platform: platform, version: v) do |node|
          node.normal['ruby_on_rails']['no_ri'] = true
          node.normal['ruby_on_rails']['no_rdoc'] = true
          node.normal['ruby_on_rails']['user'] = user
          node.normal['ruby_on_rails']['group'] = group
        end.converge(described_recipe)
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      it "includes the default recipe from the 'install_ruby' cookbook" do
        expect(chef_run).to include_recipe('install_ruby::default')
      end

      it "includes the default recipe form the 'nodejs' cookbook" do
        expect(chef_run).to include_recipe('nodejs::default')
      end

      it 'installs Ruby on Rails on the node without indexing or documentation' do
        expect(chef_run).to run_execute('install Ruby on Rails').with(
          user: user,
          group: group,
          command: "gem install rails -v #{version} --no-ri --no-rdoc"
        )
      end

      it 'installs the bundler' do
        expect(chef_run).to run_execute('rbenv rehash').with(
          user: user,
          group: group,
          command: 'rbenv rehash'
        )
      end
    end

    context "When installing Ruby on Rails on #{platform.capitalize} #{v}, with indexing and documentation" do
      let(:version) { '5.0.1' }
      let(:user) { 'default' }
      let(:group) { 'default' }

      let(:chef_run) do
        ChefSpec::ServerRunner.new(platform: platform, version: v) do |node|
          node.normal['ruby_on_rails']['no_ri'] = false
          node.normal['ruby_on_rails']['no_rdoc'] = false
          node.normal['ruby_on_rails']['user'] = user
          node.normal['ruby_on_rails']['group'] = group
        end.converge(described_recipe)
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      it 'installs Ruby on Rails on the node with indexing and documentation' do
        expect(chef_run).to run_execute('install Ruby on Rails').with(
          user: user,
          group: group,
          command: "gem install rails -v #{version}"
        )
      end
    end
  end
end
