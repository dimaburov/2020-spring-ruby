# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'

FullFilterFormSchema = Dry::Schema.Params do
  required(:point_of_departure).filled(SchemaTypes::StrippedString)
  required(:destination).filled(SchemaTypes::StrippedString)
  required(:departure_date).filled(:date)
  required(:price_min).filled(:integer, gt?: 0)
  required(:price_max).filled(:integer, gt?: 0)
end
