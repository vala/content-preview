require 'rack'
require 'rack/cors'
require 'content-preview/router'

app = Rack::Builder.new do
  use Rack::CommonLogger
  # use Rack::ShowExceptions
  # use Rack::Lint

  use Rack::Cors do
   allow do
    origins origin
    resource %r{/},
      :headers => ['Origin', 'Accept', 'Content-Type'],
      :methods => [:get, :post]
   end
  end

  run ContentPreview::Router::Base
end.to_app