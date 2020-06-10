# frozen_string_literal: true

# The information about the good topics
Topic = Struct.new(:id, :name, :description, :priority, :last_update,:event_list, keyword_init: true)
