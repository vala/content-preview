require 'open-uri'
require 'nokogiri'

module ContentPreview
  class Parser
    attr_accessor :title, :description, :images, :video

    def initialize(images = [])
      self.images = images
    end

    def process(url)
      return unless url =~ /^http\:\/\//

      begin
        document = Nokogiri::HTML(open(url))
        process_open_graph(document)
        process_meta_data(document, url)

        # Return computed data
        {
          'title' => self.title,
          'description' => self.description,
          'images' => self.images,
          'video' => self.video
        }
      rescue Exception => e
        nil
      end
    end

    def process_open_graph(document)
      unless document.xpath('//meta[starts-with(@property, "og:")]').empty?
        for tag in document.xpath('//meta[starts-with(@property, "og:")]') do
          case tag.first.last
          when 'og:title'
            self.title = tag['content']

          when 'og:description'
            self.description = tag['content']

          when 'og:image'
            self.images << tag['content']

          when 'og:video'
            self.video = tag['content']

          end
        end
      end
    end

    def process_meta_data(document, url)
      unless self.title
        unless document.css('title').empty?
          self.title = document.css('title').text
        end
      end

      if self.images.empty?
        list = []
        document.traverse do |el|
          [el[:src], el[:href]].grep(/\.(jpg)$/i).map{|l| URI.join(url, l).to_s}.first(10).each do |image|
            list << image
          end
        end

        self.images = list
      end

      unless self.description
        unless document.xpath('//meta[starts-with(@name, "")]').empty?
          for tag in document.xpath('//meta[starts-with(@name, "")]') do
            if %w(description).include?(tag.first.last)
              self.description = tag['content']
            end
          end
        end
      end
    end
  end
end