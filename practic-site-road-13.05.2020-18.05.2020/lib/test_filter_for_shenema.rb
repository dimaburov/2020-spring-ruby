
require 'dry-schema'

TestFormSchema = Dry::Schema.Params do
  required(:min).filled(:string, format?: /\d/)
  # required(:min).filled(:string, format?:)
  required(:max).filled(:string, format?: /\d/)
end