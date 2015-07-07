node[:deploy].each do |application, deploy|
  node.set[:deploy][application][:environment_variables]["AMQP_HOST"]=node[:opsworks][:layers][node['rabbitmq']['opsworks']['layer_name']][:instances].values.map{ |x| x[:private_ip] } * ","
end
