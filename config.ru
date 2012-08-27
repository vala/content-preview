require 'rack'
require 'rack/cors'
require 'content-preview/router'


use Rack::CommonLogger

use Rack::Cors do
 allow do
  origins '*'
  resource %r{/},
    :headers => ['Origin', 'Accept', 'Content-Type'],
    :methods => [:get, :post]
 end
end

run ContentPreview::Router::Base
