#
# Cookbook Name:: lb
# Recipe:: default
#
# Copyright (C) 2015 base2Services
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


log "Apt-get update"
execute 'apt-update' do
 command 'apt-get update'
action :run
end

log "Installing packages"
%w{nginx haproxy curl}.each do |pkg|
  package pkg do
    action :install
  end
end

log "Enabled haproxy"
service 'haproxy' do
  action [:enable, :start]
end


template "/etc/haproxy/haproxy.cfg" do
  mode 00644
  source 'haproxy/default.erb'
  owner 'root'
  group 'root'
  action :create
  notifies :restart, "service[haproxy]"
end
