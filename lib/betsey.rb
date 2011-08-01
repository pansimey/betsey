# -*- coding: utf-8 -*-

require 'MeCab'
current_dir = File.expand_path(File.dirname(__FILE__))
$:.unshift current_dir + '/betsey'
require 'mecab_utf8_only'
require 'betsey_dsl'

class Betsey
  include BetseyDSL
  @@tagger = MeCab::Tagger.new
  def initialize(script_path = nil)
    @initials = []
    @finals = []
    @quits = []
    @keyword_detectors = []
    current_dir = File.expand_path(File.dirname(__FILE__))
    script_path = '/betsey/script.rb'
    script = open(current_dir + script_path).read
    eval(script)
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
  def compose(node)
    @keyword_detectors.find_all{|detector|
      detector.compose_response(node)
    }.max_by{|response| response.priority}
  end
end
