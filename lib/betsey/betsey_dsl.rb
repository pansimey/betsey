module BetseyDSL
  private
  def initial(utterance)
    @initials << utterance
  end

  def final(utterance)
    @finals << utterance
  end

  def quit(word)
    @quits << word
  end

  def key(keyword, priority, &block)
    keyword_detector = KeywordDetector.new(keyword, priority)
    keyword_detector.instance_exec(&block)
    @keyword_detectors << keyword_detector
  end

  def noun(number = 1)
    NounVariable.new(:noun, number)
  end

  def verb(number = 1, &block)
    form = block ? block.call : nil
    VerbVariable.new(:verb, number, form)
  end

  def goto(key_symbol)
  end

  class POSVariable
    def initialize(pos, number)
      @pos = pos
      @number = number
    end
    attr_reader :pos, :number, :form

    def substitute(token)
      token[@pos][@number]
    end
  end

  class NounVariable < POSVariable
  end

  class VerbVariable < POSVariable
    def initialize(pos, number, form)
      super(pos, number)
      @form = form
    end

    def substitute(token)
      @form ? super.inflect(@form) : super
    end
  end

  class KeywordDetector
    def initialize(keyword, priority)
      @keyword = keyword
      @priority = priority
      @decomposers = []
    end
    attr_reader :priority

    def compose_response(node)
      return nil unless keyword_matched?(node)
      response_string = @decomposers.find{|item| item.respond(node)}
      Response.new(response_string, @priority)
    end

    def decomp(*pattern, &block)
      decomposer = Decomposer.new(pattern)
      decomposer.instance_exec(&block)
      @decomposers << decomposer
    end

    private
    def keyword_matched?(node)
      return true if @keyword == :xnone
      until node.next.eos?
        node = node.next
        break true if node.infinite == @keyword
      end
    end

    class Response < String
      def initialize(string, priority)
        super(string)
        @priority = priority
      end
      attr_reader :priority
    end

    class Decomposer
      def initialize(pattern)
        @pattern = pattern
        @reassemblers = []
        @reassemblers_for_memory = []
      end

      def respond(node)
        return nil unless token = sequencial_match(node)
        @reassemblers.rotate!.first.reassemble(token)
      end

      def reasmb(*sequence)
        @reassemblers << Reassembler.new(sequence)
      end

      def reasmb_for_memory(*sequence)
        @reassemblers_for_memory << Reassembler.new(sequence)
      end

      private
      def sequencial_match(node)
      end

      class Reassembler
        def initialize(sequence)
          @sequence = sequence
        end

        def reassemble(token)
          candidate = @sequence.map{|item| reassemble_token(item, token)}
          join_sequence(candidate)
        end

        private
        def reassemble_token(element, token)
          if element.is_a(String)
            element
          else
            element.substitute(token)
          end
        end

        def join_sequence(sequence)
          begin
            sequence.join
          rescue
            raise 'value of word variables are not given'
          end
        end
      end
    end
  end
end
