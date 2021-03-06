class EsiForRack

  class Node
    
    IncludeFailedError = Class.new(RuntimeError)
    
    attr_reader :node, :context
    
    def init(node, context)
      @node = node
      @context = context
      self
    end
      
    def execute_in_place!
      node.replace(Nokogiri::XML::CDATA.new(node.document, execute.to_s))
    end

    class Include < Node
      
      def resolved_src
        EsiAttributeLanguage::SimpleGrammar.parse(@node['src']).execute(context.resolver)
      end
      
      def resolved_alt
        EsiAttributeLanguage::SimpleGrammar.parse(@node['alt']).execute(context.resolver) if @node['alt']
      end

      def continue_on_error?
        node['onerror'] == 'continue'
      end
      
      def execute
        context.lookup(resolved_src) or
        (resolved_alt && context.lookup(resolved_alt)) or
        (!continue_on_error? && raise(IncludeFailedError.new)) or nil
      end

    end
    
    class Vars < Node
      def execute
        EsiAttributeLanguage::SimpleGrammar.parse(node.to_str).execute(context.resolver)
      end
    end
    
    class Try < Node
      
      def execute
        unless @esi_attempt = node.css('esi_attempt')[0]
          raise "no attempt within try"
        end
        
        unless @esi_except = node.css('esi_except')[0]
          raise "no except within try"
        end
        
        val = ''
        begin
          context.process(@esi_attempt)
          @esi_attempt.inner_html
        rescue IncludeFailedError
          context.process(@esi_except)
          @esi_except.inner_html
        end
      end
    end
    
    class Choose < Node
      def execute
        whens = node.css('esi_when').to_a
        raise "choose block contains no when elements" if whens.empty?
        
        otherwise = node.css('esi_otherwise')[0]

        whens.each do |esi_when|
          if EsiAttributeLanguage::Grammar.parse(esi_when['test']).execute(context.resolver).equal?(true)
            context.process(esi_when)
            return esi_when.to_str
          end
        end
        if otherwise
          context.process(otherwise)
          return otherwise.to_str
        end
        nil
      end
    end
    
    class Context
      
      attr_reader :resolver, :doc
      
      def initialize(resolver, lookup)
        @resolver = resolver
        @lookup = lookup.is_a?(Array) ? lookup : [lookup]
        @include = Include.new
        @choose = Choose.new
        @vars = Vars.new
        @try = Try.new
        
      end
    
      def lookup(url)
        @lookup.each do |l|
          resolved_body = l[url]
          return resolved_body if resolved_body
        end
        nil
      end
    
      def parse(document)
        document.gsub!('esi:', 'esi_')
        document.gsub!(/(<\/?esi_[^>]*>)/, ']]>\1<![CDATA[')
        document[0,0] = %|<?xml version="1.0"?>\n<esi_root><![CDATA[|
        document << ']]></esi_root>'
        
        @doc = Nokogiri::XML(document)
        
        @doc.css('esi_comment').each do |esi_comment|
          esi_comment.replace(Nokogiri::XML::CDATA.new(doc, ''))
        end
        
        process(@doc.css('esi_root')[0])
        
        result = ''
        @doc.css('esi_root')[0].children.each do |n|
          result << n.to_str
        end
        
        result
      end

      def process(doc_fragment)
        # have to go one at a time because of limitation of .css, its not a live list.
        # ps, i'll only break if i totally have to
        loop do
          should_break = true
          doc_fragment.css('esi_try,esi_choose,esi_vars,esi_include').each do |esi_node|
            case esi_node.name.to_sym
            when :esi_include
              @include.init(esi_node, self).execute_in_place!
            when :esi_choose
              @choose.init(esi_node, self).execute_in_place!
            when :esi_vars
              @vars.init(esi_node, self).execute_in_place!
            when :esi_try
              @try.init(esi_node, self).execute_in_place!
              should_break = false
              break
            end
          end
          break if should_break
        end
      end
      
    end
    
  end
  
end