#
# Cookbook Name:: xrdp
# Recipe:: default
#
# Copyright 2013-2014, Thomas Boerger <thomas@webhippie.de>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node["platform_family"]
when "suse"
  include_recipe "zypper"

  zypper_repository node["xrdp"]["zypper"]["alias"] do
    uri node["xrdp"]["zypper"]["repo"]
    key node["xrdp"]["zypper"]["key"]
    title node["xrdp"]["zypper"]["title"]

    action [:add, :refresh]

    only_if do
      node["xrdp"]["zypper"]["enabled"]
    end
  end
end

node["xrdp"]["packages"].each do |name|
  package name do
    action :install
  end
end

template node["xrdp"]["sysconfig_file"] do
  source "sysconfig.conf.erb"
  owner "root"
  group "root"
  mode 0644

  variables(
    node["xrdp"]
  )

  notifies :restart, "service[xrdp]"

  not_if do
    node["xrdp"]["sysconfig_file"].empty?
  end
end

execute "xrdp_keygen" do
  command "xrdp-keygen #{node["xrdp"]["keygen_path"]}"

  not_if do
    if node["xrdp"]["keygen_path"] == "auto"
      ::File.exists? "/etc/xrdp/rsakeys.ini"
    else
      ::File.exists? node["xrdp"]["keygen_path"]
    end
  end
end

service "xrdp" do
  service_name node["xrdp"]["service_name"]
  action [:enable, :start]
end
