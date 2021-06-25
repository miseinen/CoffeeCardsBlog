module ApplicationHelper
  def get_maxlength(model, attribute)
    model.validators_on(attribute)
         .select { |v| v.instance_of?(ActiveRecord::Validations::LengthValidator) }
         .select { |v| v.options[:maximum].present? }.first.options[:maximum]
  end
end
