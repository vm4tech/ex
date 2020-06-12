# frozen_string_literal: true

require 'dry-types'

# Types to use in schema validations
module SchemaTypes
  include Dry.Types

  StrippedString = self::String.constructor(&:strip)
  Time = self::Params::Time
end
