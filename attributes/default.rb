#
# Cookbook Name:: xrdp
# Attributes:: default
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

default["xrdp"]["packages"] = %w(
  xrdp
)

default["xrdp"]["service_name"] = "xrdp"
default["xrdp"]["service_options"] = ""
default["xrdp"]["sesman_options"] = ""

default["xrdp"]["sysconfig_file"] = value_for_platform_family(
  "debian" => "/etc/default/xrdp",
  "ubuntu" => "/etc/default/xrdp",
  "suse" => "/etc/sysconfig/xrdp"
)

default["xrdp"]["zypper"]["alias"] = "x11-remotedesktop"
default["xrdp"]["zypper"]["title"] = "X11 RemoteDesktop"
default["xrdp"]["zypper"]["repo"] = "http://download.opensuse.org/repositories/X11:/RemoteDesktop/openSUSE_#{node["platform_version"]}/"
default["xrdp"]["zypper"]["key"] = "#{node["xrdp"]["zypper"]["repo"]}repodata/repomd.xml.key"
