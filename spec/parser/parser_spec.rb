#encoding: UTF-8!
require 'nokogiri'
require 'open-uri'

require_relative '../../lib/content-preview'

describe ContentPreview::Parser, '::process' do

  before(:each) do
    @content_preview = ContentPreview::Parser.new
  end

  it 'should respond to %w(title description pictures) attributes' do
    @content_preview.should respond_to :title
    @content_preview.should respond_to :description
    @content_preview.should respond_to :images
  end

  describe ContentPreview::Parser, 'pictures attribute' do
    it 'should be a list' do
      @content_preview.images.should be_kind_of Array
    end
  end

  it 'should not return nil if the url is correct' do
    preview = @content_preview.process "http://www.google.com"
    preview.should_not be_nil
  end

  it "returns nil when url isn't well formatted" do
    preview = %w(example.com example http:/www.example.com www.example.com).reduce(nil) do |result, url|
      result = result || @content_preview.process(url) != nil ? true : nil
    end
    preview.should be_nil
  end

  it "returns nil when domain name doesn't exist" do
    preview = @content_preview.process "http://www.tezzdazfazfadada.dza"
    preview.should be_nil
  end

  it "returns nil if URL can't be found by the remote server" do
    preview = @content_preview.process "http://www.google.com/oidajzodjaozjcaozcaozcnazocna"
    preview.should be_nil
  end

  it 'should return valid information when processed with Google url' do
    preview = @content_preview.process "http://www.google.com"
    preview.should_not be_nil
    preview.should include({"title"=>"Google", "description"=>nil, "images"=>[]})

    @content_preview.title.should_not be_nil
  end

  it 'should return valid attributes when processed with a Youtube video url' do
    preview = @content_preview.process "http://www.youtube.com/watch?v=OK7pfLlsUQM"
    preview.should_not be_nil
    preview.should include(
      {
        "title"=>"The Artist - Official Trailer [HD]",
        "description"=>"Subscribe http://ow.ly/3UVvY | Facebook http://ow.ly/3UVxn | Twitter http://ow.ly/3UVyA Release Date: 23 November 2011 Genre: Romance | Comedy | Drama Cast: ...",
        "images"=>["http://i4.ytimg.com/vi/OK7pfLlsUQM/mqdefault.jpg"],
        "video" => "http://www.youtube.com/v/OK7pfLlsUQM?version=3&autohide=1"
      }
    )

    @content_preview.title.should_not be_nil
    @content_preview.images.should_not be_empty
    @content_preview.video.should_not be_nil
  end

end