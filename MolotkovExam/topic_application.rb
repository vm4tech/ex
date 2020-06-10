# frozen_string_literal: true

require 'date'
require 'forme'
require 'roda'

require_relative 'models'

# The application class
class TopicApplication < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :forme
  plugin :render
  plugin :status_handler

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:topics] = TopicList.new(
    [
      Topic.new(
        id: 25,
        name: 'Programming Ruby 1.9 & 2.0',
        description: 'Dave Thomas',
        priority: 2,
        last_update: Date.parse('2013-06-20'),
        event_list: EventList.new([
          Event.new(
            id: 1,
            name: 'Vlad',
            description: 'Molotkov',
            start_time: '2000-07-20',
            end_time: '2000-07-22'
          ),
          Event.new(
            id: 30,
            name: 'Den',
            description: 'Zyablitcev',
            start_time: '2000-07-23',
            end_time: '2000-07-24'
          )
        ])
      ),
      Topic.new(
        id: 5,
        name: 'The Pragmatic Programmer',
        description: 'Dave Thomas, Andreyw Hunt',
        priority: 4,
        last_update: Date.parse('1999-10-01'),
        event_list: []
      )
    ]
  )

  status_handler(404) do
    view('not_found')
  end

  route do |r|
    r.public if opts[:serve_static]

    r.root do
      r.redirect '/topics'
    end

    r.on 'topics' do
      r.is do
        @topics = opts[:topics].all_topics
        view('topics')
      end

      r.on Integer do |topic_id|
        @topic = opts[:topics].topic_by_id(topic_id)
        @events = @topic.event_list.all_events
        # pp @events
        next if @topic.nil?
        
        r.is do
          view('topic')
        end

        r.on 'new' do
          r.get do
            @parameters = {}
            view('event_new')
          end
  
          r.post do
            @parameters = DryResultFormeWrapper.new(EventFormSchema.call(r.params))
            if @parameters.success?
              event_id = opts[:topics].topic_by_id(topic_id).event_list.add_event(@parameters)
              r.redirect "/topics/#{topic_id}"
            else
              view('event_new')
            end
          end
        end
        
        r.on Integer do |event_id|
          @event = @topic.event_list.event_by_id(event_id)
          next if @event.nil?
          r.is do
            view('event')
          end

          r.on 'edit' do
              r.get do 
                @parameters = @event.to_h
                view('event_edit')
              end

              r.post do
                @parameters = DryResultFormeWrapper.new(EventFromSchema.call(r.params))
                if @parameters.success?
                  opts[:topics].topic_by_id(topic_id).event_list.update_events(@event.id, @parameters)
                end
              end
          end

          r.on 'delete' do
            r.get do
              @parameters = {}
              view('event_delete')
            end

            r.post do
              @parameters = DryResultFormeWrapper.new(DeleteSchema.call(r.params))
              if @parameters.success?
                opts[:topics].topic_by_id(topic_id).event_list.delete_event(@event.id)
                r.redirect "/topics/#{@topic.id}"
              else
                view('event_delete')
              end
            end
          end
          
        end

        r.on 'edit' do
          r.get do
            @parameters = @topic.to_h
            view('topic_edit')
          end
            
          r.post do
            @parameters = DryResultFormeWrapper.new(TopicFormSchema.call(r.params))
            if @parameters.success?
              opts[:topics].update_topic(@topic.id, @parameters)
              
              r.redirect "/topics/#{@topic.id}"
            else
              view('topic_edit')
            end
          end
        end
        

        r.on 'delete' do
          r.get do
            @parameters = {}
            view('topic_delete')
          end

          r.post do
            @parameters = DryResultFormeWrapper.new(DeleteSchema.call(r.params))
            if @parameters.success?
              opts[:topics].delete_topic(@topic.id)
              r.redirect('/topics')
            else
              view('topic_delete')
            end
          end
        end
      end

      r.on 'new' do
        r.get do
          @parameters = {}
          view('topic_new')
        end

        r.post do
          @parameters = DryResultFormeWrapper.new(TopicFormSchema.call(r.params))
          if @parameters.success?
            topic_id = opts[:topics].add_topic(@parameters)
            r.redirect "/topics/#{topic_id}"
          else
            view('topic_new')
          end
        end
      end
    end
  end
end
