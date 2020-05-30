# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'
require_relative 'landing_cover_type'
require_relative 'landing_cover_unit'

LandingFormSchema = Dry::Schema.Params do
  required(:landing_date).filled(:date)
  required(:type).filled(SchemaTypes::StrippedString, included_in?: LandingCoverType.all_types)
  required(:name).filled(SchemaTypes::StrippedString)
  required(:scope).filled(:float, gt?: 0)
  required(:unit).filled(SchemaTypes::StrippedString, included_in?: LandingCoverUnit.all_types)
  optional(:description).maybe(:string)
end