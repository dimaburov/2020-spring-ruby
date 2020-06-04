# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'

DateIntervalFormSchema = Dry::Schema.Params do
  required(:first_date).filled(:date)
  required(:second_date).filled(:date)
end
