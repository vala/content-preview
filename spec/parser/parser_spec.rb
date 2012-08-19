require "content-preview"

describe ContentPreview::Parser, '::process' do
  it "returns nil when url isn't well formatted" do
    preview = %w(example.com example http:/www.example.com www.example.com).reduce(nil) do |result, url|
      result = result || ContentPreview::Parser.process(url) != nil ? true : nil
    end
    preview.should eq nil
  end

  it "returns nil when domain name doesn't exist" do
    preview = ContentPreview::Parser.process "http://www.tezzdazfazfadada.dza"
    preview.should eq nil
  end

  it "returns nil if URL can't be found by the remote server" do
    preview = ContentPreview::Parser.process "http://www.google.com/oidajzodjaozjcaozcaozcnazocna"
    preview.should eq nil
  end
end