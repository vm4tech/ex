# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'
require_relative 'book_cover_type'

BookFormSchema = Dry::Schema.Params do
  required(:name).filled(SchemaTypes::StrippedString)
  required(:description).filled(SchemaTypes::StrippedString)
  required(:priority).filled(:integer, gteq?: 1, lteq?: 4)
  required(:last_update).filled(:date)  
end
