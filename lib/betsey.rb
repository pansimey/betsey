current_dir = File.expand_path(File.dirname(__FILE__))
$:.unshift current_dir + '/betsey'

require 'mecab19u'
require 'betsey_dsl'

class Betsey
  include BetseyDSL
  @@tagger = MeCab::Tagger.new

  def initialize(script_path = nil)
    @initials = []
    @finals = []
    @quits = []
    @keyword_detectors = []
    eval(open(script_path || default_script_path).read)
  end

  def greet
    @initials.shuffle.first
  end

  def response(string)
    compose(@@tagger.parse_to_node(string))
  end

  def say_goodbye
    @finals.shuffle.first
  end

  private
  def default_script_path
    File.expand_path(File.dirname(__FILE__)) + '/betsey/script.rb'
  end

  def compose(node)
    @keyword_detectors.find_all{|detector|
      detector.compose_response(node)
    }.max_by{|response| response.priority}
  end
end
