# frozen_string_literal: true

# The information about the good books
Book = Struct.new(:id, :name, :description, :priority, :last_update,:event_list, keyword_init: true)
