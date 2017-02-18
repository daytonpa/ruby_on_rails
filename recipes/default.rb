#
# Cookbook Name:: ruby_on_rails
# Recipe:: default
# Author:: Patrick Dayton daytonpa@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#

# Install the latest stable version of Ruby
include_recipe 'install_ruby::default'

include_recipe 'nodejs'

cmd = "gem install rails -v #{node['ruby_on_rails']['version']}"
if node['ruby_on_rails']['no_ri']
  cmd += " --no-ri"
end
if node['ruby_on_rails']['no_rdoc']
  cmd += " --no-rdoc"
end

execute 'install Ruby on Rails' do
  user node['ruby_on_rails']['user']
  group node['ruby_on_rails']['group']
  command cmd
end

execute 'rbenv rehash' do
  user node['ruby_on_rails']['user']
  group node['ruby_on_rails']['group']
  command 'rbenv rehash'
end
