homedir = node['ndb']['user'].eql?("root") ? "/root" : "/home/#{node['ndb']['user']}"

# Add the mgmd hosts' public key, so that it can start/stop the ndbd on this node using passwordless ssh.
kagent_keys "#{homedir}" do
  cb_user "#{node['ndb']['user']}"
  cb_group "#{node['ndb']['group']}"
  cb_name "ndb"
  cb_recipe "mgmd"
  action :get_publickey
end

package "nmon" do
  action :install
end