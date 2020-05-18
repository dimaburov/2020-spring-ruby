
require 'dry-schema'

TestFormSchema = Dry::Schema.Params do
  required(:min).filled(:string, format?: /\d/)
  required(:max).filled(:string, format?: /\d/)
end