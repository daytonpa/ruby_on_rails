#
# Cookbook Name:: ruby_on_rails
# Attributes:: default
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#

default['ruby_on_rails'].tap do |rails|
  rails['user'] = node['install_ruby']['user']
  rails['group'] = node['install_ruby']['group']

  # Version of Ruby on Rails
  rails['version'] = '5.0.1'
  # Skip the installation of Rails with Ruby Indexing
  rails['no_ri'] = true
  # Skip the installation of Rails with Ruby Documentation
  rails['no_rdoc'] = true
end
