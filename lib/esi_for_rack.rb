require 'nokogiri'
require 'set'

require 'esi_attribute_language'
require 'parse_user_agent'

require File.join(File.dirname(__FILE__), 'esi_for_rack', 'node')
require File.join(File.dirname(__FILE__), 'esi_for_rack', 'lookup')

class EsiForRack
  
  def initialize(app, lookup = nil)
    @app = app
    @lookup = lookup
  end
  
  def call(env)
    @lookup ||= Lookup::PassThrough.new(@app, env)
    
    request = Rack::Request.new(env)
    result = @app.call(env)
    response = Rack::Response.new(result[2], result[0], result[1])

    if response['Content-Type'] =~ /text\/html/
      body = ""
      response.body.each do |part|
        body << part
      end
      
      user_agent_hash = {}
      begin
        user_agent = ParseUserAgent.new.parse(env['HTTP_USER_AGENT'] || '-')
        user_agent_hash['browser'] = case user_agent.browser
        when  'Firefox' then 'MOZILLA'
        when  'MSIE'    then 'MSIE'
        else;                'OTHER'
        end

        user_agent_hash['version'] = user_agent.browser_version_major

        user_agent_hash['os'] = case user_agent.ostype
        when  'Windows'   then 'WIN'
        when  'Macintosh' then 'MAC'
        else;                  'OTHER'
        end

      rescue
        # error parsing ua
      end
      
      
      
      binding = {
        :HTTP_ACCEPT_LANGUAGE => Set.new((env['HTTP_ACCEPT_LANGUAGE'] || '').split(',').map{|l| l.strip.gsub(/q=[0-9]\.[0-9]{1,3}/, '').gsub(';','')}),
        :HTTP_COOKIE => request.cookies,
        :HTTP_HOST => request.host,
        :HTTP_REFERER => request.referer,
        :HTTP_USER_AGENT => user_agent_hash,
        :QUERY_STRING => request.GET
      }
      context = Node::Context.new(binding, @lookup)
      [response.status, response.headers, [context.parse(body).to_s]]
    else
      result
    end
    
  end
  
  class IOWrapper
    def initialize(body)
      @body = body.each
    end

    def read
      @body.end?
    end
    
    def close
      #no-op
    end
  end
  
end