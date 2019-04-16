class BeginningOfWeekValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value&.monday?

    record.errors.add(attribute, :week_start)
  end
end
