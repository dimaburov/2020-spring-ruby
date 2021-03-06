# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'

TrainNewFormSchema = Dry::Schema.Params do
  required(:number).filled(:integer, gt?: 0)
  required(:point_of_departure).filled(SchemaTypes::StrippedString)
  required(:destination).filled(SchemaTypes::StrippedString)
  required(:departure_date).filled(:date)
  required(:departure_time).filled(:time)
  required(:arrival_date).filled(:date)
  required(:arrival_time).filled(:time)
  required(:price).filled(:integer, gt?: 0)
end
