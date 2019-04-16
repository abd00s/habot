class BeginningOfWeekValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # binding.pry
    return if value&.monday?

    record.errors.add(attribute, :week_start)
  end
end
