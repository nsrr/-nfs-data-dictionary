# frozen_string_literal: true

require "test_helper"

# Launches default Spout tests and custom tests for specific to this dictionary.
class DictionaryTest < Minitest::Test
  # This line includes all default Spout Dictionary tests.
  include Spout::Tests::JsonValidation
  include Spout::Tests::DomainExistenceValidation
  include Spout::Tests::DomainFormat
  include Spout::Tests::DomainNameFormat
  include Spout::Tests::DomainNameUniqueness
  include Spout::Tests::DomainSpecified
  include Spout::Tests::FormExistenceValidation
  include Spout::Tests::FormNameFormat
  include Spout::Tests::FormNameMatch
  include Spout::Tests::FormNameUniqueness
  # include Spout::Tests::VariableDisplayNameLength
  include Spout::Tests::VariableNameFormat
  include Spout::Tests::VariableNameMatch
  include Spout::Tests::VariableNameUniqueness
  include Spout::Tests::VariableTypeValidation

  # This line provides access to @variables, @forms, and @domains iterators
  # that can be used to write custom tests.
  include Spout::Helpers::Iterators


  # Example 1: Create custom tests to show that `integer` and `numeric`
  #            variables have a valid unit type.
  # Add your own valid units to this array.
  VALID_UNITS = ["days", "", "kilograms per meter squared (kg/m2)",
   "centimeters (cm)", "kilograms (kg)", "picograms per milliliter (pg/mL)",
    "micrograms per milliliter (ug/mL)", "milligrams per liter (mg/L)",
     "milligrams per deciliter (mg/dL)", "percent (%)", "nanograms per milliliter (ng/mL)", 
     "milli-international units per milliliter (uIU/mL)", "years", "kilograms per meters squared (kg/m2)",
      "number of events per hour", "minutes (min)", "beats per minute (bpm)", "hours (hr)", 
      "millimeters of mercury (mmHg)", nil]
  @variables.select { |v| %w(numeric integer).include?(v.type) }.each do |variable|
    define_method("test_units: #{variable.path}") do
      message = "\"#{variable.units}\"".red + " invalid units.\n" +
                "             Valid types: " +
                VALID_UNITS.sort_by(&:to_s).collect { |u| u.inspect.white }.join(", ")
      assert VALID_UNITS.include?(variable.units), message
    end
  end

  # Example 2: Create custom tests to show that variables have 2 or more labels.
  # @variables.select { |v| %w(numeric integer).include?(v.type) }.each do |variable|
  #   define_method("test_at_least_two_labels: #{variable.path}") do
  #     assert_operator 2, :<=, variable.labels.size
  #   end
  # end

  # Example 3: Create regular Ruby tests
  # You may add additional tests here
  # def test_truth
  #   assert true
  # end
end
