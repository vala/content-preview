require 'open-uri'

module ContentPreview
  class Parser
    class << self
      def process url
        return unless url =~ /^http\:\/\//
        begin
          open url do |f|
            # Parsing management here ...
          end
        # Rescue from know errors
        rescue SocketError, OpenURI::HTTPError
          nil
        end
      end
    end
  end
end