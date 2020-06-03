# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'

DateIntervalFormSchema = Dry::Schema.Params do
  required(:first_date).filled(SchemaTypes::StrippedString)
  required(:second_date).filled(SchemaTypes::StrippedString)
end
