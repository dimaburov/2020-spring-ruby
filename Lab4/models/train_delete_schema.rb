# frozen_string_literal: true

require 'dry-schema'

TrainDeleteSchema = Dry::Schema.Params do
  required(:confirmation).filled(true)
end