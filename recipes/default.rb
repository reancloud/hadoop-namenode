#
# Cookbook Name:: hadoop-namenode
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'hadoop::hadoop_hdfs_namenode'

package "default-jdk" do
  action :install
end

ruby_block  "set-env-java-home" do
  block do
    ENV["JAVA_HOME"] = '/usr/lib/jvm/java-7-openjdk-amd64'
    #ENV['PATH'] = "#{ENV['PATH']}:#{node['java']['path']}/bin"
  end
end

bash 'set-env-bashrc' do
  code <<-EOH
    echo -e "export JAVA_HOME=$JAVA_HOME" >> ~/.bash_profile
    echo -e "export PATH=$PATH" >> ~/.bash_profile
    source ~/.bash_profile
  EOH
end

ruby_block 'execute-hdfs-namenode-format' do
  block do
    resources('execute[hdfs-namenode-format]').run_action(:run)
  end
 end 


ruby_block 'service-hadoop-hdfs-namenode-start-and-enable' do
  block do
    %w(enable start).each do |action|
      resources('service[hadoop-hdfs-namenode]').run_action(action.to_sym)
    end
  end
end

