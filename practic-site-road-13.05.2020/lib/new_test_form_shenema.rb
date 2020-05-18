
require 'dry-schema'

NewTestFormSchema = Dry::Schema.Params do
  required(:line_one).filled(:string, format?: /\d/)
  required(:line_two).filled(:string, format?: /\d/)
  required(:line_three).filled(:string, format?: /\d/)
end