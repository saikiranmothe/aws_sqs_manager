require 'yaml'
require 'shoryuken'

# load SQS credentials
# config = YAML.load File.read(File.join(File.expand_path('..', __FILE__), 'config/shoryuken.yml'))

sqs = AWS::SQS.new(
  :access_key_id => 'YOUR_ACCESS_KEY_ID',
  :secret_access_key => 'YOUR_SECRET_ACCESS_KEY')

#create a queue
queue = sqs.queues.create("myqueue")

#get queues from account
pp sqs.queues.collect(&:url)

#send msg to queue
msg = queue.send_message("HELLO")
puts "Sent message: #{msg.id}"

#polling for messages
queue.poll do |msg|
  puts "Got message: #{msg.body}"
end