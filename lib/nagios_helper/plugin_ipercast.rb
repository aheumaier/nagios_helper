require 'open-uri'
require 'benchmark'

module NagiosHelper
  class NagiosHelper::PluginIpercast < NagiosHelper::Plugin

    def initialize(args = {})
      super
      @opts.on("-u", "--url URL", "TARGET URL") do |u|
        @url = u
      end
      @opts.on("-i", "--id ID", "ARTICLE ID") do |i|
        @article_id = i
      end
      @opts.on("-t", "--type TYPE", "SWITCH TYPE") do |t|
        @type = t
      end
    end

    # actually does the check
    def run
      @uri = urlize()
      validate_content validate_url( @uri, 'rt' ).read
    end

    def urlize()
      unknown("No target url given") if @url.nil?
      @id_split = @article_id.split('').join('/') +'/'
      return 'http://' + @url + '/gentoken/3000/6000/*/3709/' + @id_split + @article_id + '.m4a/' + @type + '/'
    end


    def validate_url(url, bench_field = 'rt' )
      time = Benchmark.realtime do
        begin
          @response = open(url)
        rescue Exception => e
          critical( e.message )
        end
      end
      if @response.status.join =~ /200/
        add_perfdata :field => bench_field, :data => time
        return @response
      else
        critical( @response.status.join )
      end
    end

    def validate_content (content )
      case @type
        when 'e'
          test_rtmpe(content)
        when 'r'
          test_rtmp(content)
        when 'd'
          test_download(content)
        when 'h'
          test_hls(content)
        when 'p'
          test_rtsp(content)
        else
          unknown('missing internal content type classifier for type '+@type)
      end
    end

    def test_rtmp(string)
      if string.match(/^rtmp:\/\//)
        ok('found url type rtmp://')
      else
        critical('wrong url type found')
      end
    end

    def test_rtmpe(string)
      if string.match(/^rtmpe:\/\//)
        ok('found url type rtmpe://')
      else
        critical('wrong url type found')
      end
    end

    def test_hls(string)
      if string.match(/playlist.m3u/)
        validate_url( string, 'hls_rt')
        ok('found url type playlist.m3u')
      else
        critical('wrong url type found')
      end
    end

    def test_rtsp(string)
      if string.match(/^rtsp:\/\//)
        ok('found url type rtsp://')
      else
        critical('wrong url type found')
      end
    end

    def test_download(string)
      if string.match(/^http:\/\//) and string.match(/(m4a)$/)
        validate_url( string, 'download_rt')
        ok('found url type http://*.m4a')
      else
        critical('wrong url type found')
      end
    end


  end
end