require 'json'
require 'rack/cors'

require 'content-preview/server/router'

module ContentPreview
  class Server
    def initialize
      use Rack::CommonLogger
      use Rack::ShowExceptions
      use Rack::Lint
      #use Rack::Static, :urls => ["/static"]

      use Rack::Cors do
       allow do
        origins 'http://localhost:3000'
        resource %r{/},
          :headers => ['Origin', 'Accept', 'Content-Type'],
          :methods => [:get, :post]
       end
      end

      run Router::Base.new
    end

    class << self
      alias start new
    end
  end
end