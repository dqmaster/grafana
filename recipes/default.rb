#
# Cookbook Name:: grafana
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

remote_file "/tmp/grafana-2.5.0-1.x86_64.rpm" do
  source node["grafana"]["package_url"]
  action :create
  mode '0755'
end

yum_package 'grafanaRPM' do
  action :install
  source "/tmp/grafana-2.5.0-1.x86_64.rpm"  
end

template "/etc/grafana/grafana.ini" do
  path "/etc/grafana/grafana.ini"
  source "grafana.ini.erb"
  variables(:site_url=> node['grafana']['site_url'])
  notifies :restart, "service[grafana-server]"
end

service "grafana-server" do
  supports :restart => true, :start => true, :stop => true
  action [:enable, :start]
end
