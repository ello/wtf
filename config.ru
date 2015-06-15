require 'newrelic_rpm'
require 'new_relic/rack/agent_hooks'

app = Rack::Builder.new do
  map '/wtf' do
    use NewRelic::Rack::AgentHooks
    use Rack::Static, urls: [''], root: '_site', index: 'index.html'

    run lambda { |env|
      [
        302,
        {
          'Location' => '/wtf/',
          'Content-Type' => 'text/html'
        }, ['Redirecting to /wtf/']
      ]
    }
  end
end

run app
