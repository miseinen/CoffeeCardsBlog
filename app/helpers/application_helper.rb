module ApplicationHelper
  def get_maxlength(model, attribute)
    model.validators_on(attribute)
      .select { |v| v.class == ActiveRecord::Validations::LengthValidator }
      .select { |v| v.options[:maximum].present? }.first.options[:maximum]
  end
end
