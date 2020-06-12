# frozen_string_literal: true

require_relative 'topic'
require_relative 'event_list'

# The class that contains all our topics
class TopicList
  def initialize(topics = [])
    @topics = topics.map do |topic|
      [topic.id, topic]
    end.to_h
  end

  def all_topics
    @topics.values
  end

  def topic_by_id(id)
    @topics[id]
  end

  def add_topic(parameters)
      if @topics.empty?
        topic_id = 1
      else
        topic_id = @topics.keys.max + 1
      end    

    # topic_id = 1
    @topics[topic_id] = Topic.new(
      id: topic_id,
      name: parameters[:name],
      description: parameters[:description],
      priority: parameters[:priority],
      last_update: parameters[:last_update],
      event_list: EventList.new
    )
    topic_id
  end

  def add_real_topic(topic)
    @topics[topic.id] = topic
  end

  def update_topic(id, parameters)
    
    topic = @topics[id]
    topic.name = parameters[:name]
    topic.description = parameters[:description]
    topic.priority = parameters[:priority]
    # topic.last_update = parameters[:last_update]
  end

  def delete_topic(id)
    @topics.delete(id)
  end
end