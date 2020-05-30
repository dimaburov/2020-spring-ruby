# frozen_string_literal: true

# The information about the good landing
Landing = Struct.new(:id, :type, :name, :scope, :unit, :description, :landing_date, keyword_init: true)