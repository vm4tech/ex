# frozen_string_literal: true

# The information about the good books
Book = Struct.new(:id, :name, :description, :start_time, :end_time, keyword_init: true)
