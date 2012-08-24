require 'content-preview/router/handlers/default'

module ContentPreview
  module Router
    class Base
      def initialize(path = File.expand_path('../router/routes.yml', __FILE__))
        @routes = YAML.load_file path
      end

      def call(env)
        path = env['PATH_INFO']

        until @routes.has_key? path do
          path = path.rpartition('/').first
          path = '/' if path.empty?
        end

        # require File.dirname(__FILE__) + '/' + @routes[path]

        class_name = @routes[path].capitalize
        Handlers.const_get(class_name).call env
      end

      class << self
        def call *args
          new.call *args
        end
      end
    end
  end
end