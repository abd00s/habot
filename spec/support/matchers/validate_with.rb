RSpec::Matchers.define :validate_with do |expected_validator|
  match do |actual|
    @validator = actual.class.validators.find do |validator|
      validator.class == expected_validator
    end

    @validator.present? && attribute_condition_satisfied?
  end

  def attribute_condition_satisfied?
    return true if @attribute.blank?

    @validator.attributes.include?(@attribute)
  end

  chain :for_attribute do |attribute|
    @attribute = attribute
  end

  failure_message do |actual|
    "expected #{actual.class} to validate with #{expected_validator}" \
    + attribute_message
  end

  def attribute_message
    return "" if @attribute.blank?

    "for attribute `#{@attribute}`."
  end
end
