require 'json'
require 'rack'
require 'yaml'
require 'rack/cors'

require 'content-preview/server'
# require 'content-preview/server'

use ::Rack::CommonLogger
use ::Rack::ShowExceptions
use ::Rack::Lint
#use Rack::Static, :urls => ["/static"]

use Rack::Cors do
 allow do
  origins 'http://localhost:3000'
  resource %r{/},
    :headers => ['Origin', 'Accept', 'Content-Type'],
    :methods => [:get, :post]
 end
end

run ContentPreview::Router::Base.new