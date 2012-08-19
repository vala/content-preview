require 'open-uri'

module ContentPreview
  class Parser
    class << self
      def process url
        return unless url =~ /^http\:\/\//
        begin
          open url do |f|

          end
        rescue SocketError, OpenURI::HTTPError
          nil
        end
      end
    end
  end
end