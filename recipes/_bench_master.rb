package "pssh" do
    action :install
end

package "tmux" do
    action :install
end

homedir = node['ndb']['user'].eql?("root") ? "/root" : "/home/#{node['ndb']['user']}"

bench_dir = "#{homedir}/benchmarks"

directory bench_dir do
    owner node['ndb']['user']
    group node['ndb']['group']
    action :create
end

bench_nodes = node['ndb']['_bench_node']['private_ips'].join("\n")
bench_nodes += "\n"

file "#{bench_dir}/bench_nodes" do
    owner node['ndb']['user']
    group node['ndb']['group']
    mode '644'
    content bench_nodes.to_s
    action :create
end

ndb_nodes = node['ndb']['ndbd']['private_ips'].join("\n")
ndb_nodes += "\n"

file "#{bench_dir}/ndb_nodes" do
    owner node['ndb']['user']
    group node['ndb']['group']
    mode '644'
    content ndb_nodes.to_s
    action :create
end

template "#{bench_dir}/run_nmon.sh" do
    source "bench/run_nmon.sh.erb"
    owner node['ndb']['user']
    group node['ndb']['group']
    mode 0750
end
  
template "#{bench_dir}/stop_and_collect_nmon.sh" do
    source "bench/stop_and_collect_nmon.sh.erb"
    owner node['ndb']['user']
    group node['ndb']['group']
    mode 0750
end 

template "#{bench_dir}/start_cluster.sh" do
    source "bench/start_cluster.sh.erb"
    owner node['ndb']['user']
    group node['ndb']['group']
    mode 0750
end

template "#{bench_dir}/stop_cluster.sh" do
    source "bench/stop_cluster.sh.erb"
    owner node['ndb']['user']
    group node['ndb']['group']
    mode 0750
end


template "#{bench_dir}/bench_example.sh" do
    source "bench/bench_example.sh.erb"
    owner node['ndb']['user']
    group node['ndb']['group']
    mode 0750
end