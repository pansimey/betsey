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

  def goto(key_symbol)
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

      class VerbToken
        private
        def verb
        end

        def verb_renyou
        end

        def verb_renyou_ta
        end

        def verb_rentai
        end
      end

      class Reassembler
        def initialize(sequence)
          @sequence = sequence
        end

        def reassemble(token)
          candidate = reassemble_noun(@sequence, token)
          candidate = reassemble_verb(candidate, token)
          join_sequence(candidate)
        end

        private
        def reassemble_noun(sequence, token)
          if token[:noun]
            sequence.map{|item| item == :noun ? token[:noun] : item}
          else
            sequence
          end
        end

        def reassemble_verb(sequence, token)
          if token[:verb]
            map_with_verb(sequence, token[:verb])
          else
            sequence
          end
        end

        def map_with_verb(sequence, verb_token)
          sequence.map do |item|
            item.to_s[/^verb/] ? verb_token.conjugate(item) : item
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
