#
# Cookbook Name:: web
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
%w{nginx php5 php5-fpm curl}.each do |pkg|
  package pkg do
    action :install
  end
end

log "Disable apache2"
service 'apache2' do
  action [:disable, :stop]
end

log "Enabled nginx"
service 'nginx' do
  action [:enable, :start]
end

log "Enabled php5-fpm"
service 'php5-fpm' do
  action [:enable, :start]
end

template "/etc/nginx/sites-enabled/default" do
  mode 00644
  source 'nginx/default.erb'
  owner 'root'
  group 'root'
  action :create
  notifies :restart, "service[nginx]"
end


template "/usr/share/nginx/www/index.php" do
  mode 00644
  source 'nginx/index.php.erb'
  owner 'root'
  group 'root'
  action :create
  notifies :restart, "service[php5-fpm]"
end

