# frozen_string_literal: true

require_relative 'event'

# The class that contains all our events
class EventList
  def initialize(events = [])
    @events = events.map do |event|
      [event.id, event]
    end.to_h
  end

  def all_events
    @events.values
  end

  def event_by_id(id)
    @events[id]
  end

  def add_event(parameters)
    # pp @events.keys.max 
    event_id = if @events.empty?
                1
              else
                 @events.keys.max + 1
              end

    @events[event_id] = Event.new(
      id: event_id,
      name: parameters[:name],
      description: parameters[:description],
      start_time: parameters[:start_time],
      end_time: parameters[:end_time],
    )
    event_id
  end

  def update_events(id, parameters)
    events = @events[id]
    events.name = parameters[:name]
    events.description = parameters[:description]
    events.start_time = parameters[:start_time]
    events.end_time = parameters[:end_time]
  end

  def delete_event(id)
    @events.delete(id)
  end
end