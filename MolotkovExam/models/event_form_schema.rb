# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'

EventFormSchema = Dry::Schema.Params do

  required(:name).filled(SchemaTypes::StrippedString)
  required(:description).filled(SchemaTypes::StrippedString)
  # required(:start_date).filled(:date)
  # required(:end_date).filled(:date)
  required(:start_time).filled(:time)
  required(:end_time).filled(:time)
  
  # required(:end_time).filled(:start_time > :end_time)
  
end
