# frozen_string_literal: true

require 'dry-schema'

TopicDeleteSchema = Dry::Schema.Params do
  required(:confirmation).filled(true)
end
