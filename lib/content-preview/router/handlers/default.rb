module ContentPreview
  module Router
    module Handlers
      class Default
        def self.call(env)
          req = Rack::Request.new(env)
          if req.get?
            [404, {'Content-Type' => 'text/html'}, StringIO.new('No content param found.')] if !req.params['url']
            result = ContentPreview::Parser.new.process(req.params["url"])
            if result
              [200, {'Content-Type' => 'text/json'}, StringIO.new(result.to_json)]
            else
              [404, {'Content-Type' => 'text/html'}, StringIO.new('The content you asked could not be found.')]
            end
          else
            [403, {'Content-Type' => 'text/html'}, StringIO.new('Unauthorized.')]
          end
        end
      end
    end
  end
end
