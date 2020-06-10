# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'

TopicFormSchema = Dry::Schema.Params do
  required(:name).filled(SchemaTypes::StrippedString)
  required(:description).filled(SchemaTypes::StrippedString)
  required(:start_time).filled(:date)
  required(:end_time).filled(:date)  
end
