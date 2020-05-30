# frozen_string_literal: true

require 'dry-schema'

LandingDeleteSchema = Dry::Schema.Params do
  required(:confirmation).filled(true)
end