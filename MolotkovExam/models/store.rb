# frozen_string_literal: true

require 'psych'
require_relative 'topic_list'
require_relative 'topic' 

# Storage for all of our data
class Store
  attr_reader :topic_list

  DATA_STORE = File.expand_path('../db/data.yaml', __dir__)

  def initialize
    @topic_list = TopicList.new
    read_data
    at_exit {
       write_data 
       }
  end

  def read_data
    return unless File.exist?(DATA_STORE)

    yaml_data = File.read(DATA_STORE)
    raw_data = Psych.load(yaml_data, symbolize_names: true)
    pp raw_data
    raw_data[:topic_list].each do |raw_topic|
      @topic_list.add_real_topic(Topic.new(**raw_topic))
    end
  end

  def write_data
    raw_topics = @topic_list.all_topics.map(&:to_h)
    yaml_data = Psych.dump({
                             topic_list: raw_topics
                           })
    File.write(DATA_STORE, yaml_data)
  end
end
