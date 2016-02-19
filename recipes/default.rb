#
# Cookbook Name:: hadoop-namenode
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'hadoop::hadoop_hdfs_namenode'

file '/tmp/namenode_postinstall.sh' do
  content 'echo configuring…; chef-client -o recipe[hadoop-wrapper-cookbook::postinstall_namenode] 2>&1 >/dev/null'
  mode '0755'
end