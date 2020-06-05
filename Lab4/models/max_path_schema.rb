# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'

MaxPathFormSchema = Dry::Schema.Params do
  required(:city).filled(SchemaTypes::StrippedString)
  required(:departure_date).filled(:date)
end
