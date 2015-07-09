layer = node['rabbitmq']['opsworks']['layer_name']
layerId = node[:opsworks][:layers][layer][:id]
node[:opsworks][:stack]['elb-load-balancers'].each do |elb|
  if elb[:layer_id] == layerId
    Chef::Log.info("elb for #{layer} found  with dns: #{elb[:dns_name]}.")
    node[:deploy].each do |application, deploy|
      node.set[:deploy][application][:environment_variables]["AMQP_HOST"]=elb[:dns_name]
    end
  end
end
