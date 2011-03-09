module ParamChecker
  def self.check_integer_param(param, default, min = nil, max = nil)
    min_lambda = (min.nil? ? lambda { true } : lambda { param.strip.to_i >= min })
    max_lambda = (max.nil? ? lambda { true } : lambda { param.strip.to_i <= max })

    if (param && param.strip =~ /^-?[0-9]+$/ && min_lambda.call && max_lambda.call)
      param.strip.to_i
    else
      default
    end
  end

  def self.check_float_param(param, default, min = nil, max = nil)
    min_lambda = (min.nil? ? lambda { true } : lambda { param.strip.to_i >= min })
    max_lambda = (max.nil? ? lambda { true } : lambda { param.strip.to_i <= max })

    if (param && param.strip =~ /^-?[0-9]+(\.[0-9]+)?$/ && min_lambda.call && max_lambda.call)
      param.strip.to_f
    else
      default.to_f
    end
  end

  def self.check_string_param(param, default, allowed)
    if (param && allowed.class == Regexp && param =~ allowed)
      param
    elsif (param && allowed.class == Array && allowed.include?(param))
      param
    elsif (param && allowed.class == String && allowed == param)
      param
    else
      default
    end
  end

  def self.check_symbol_param(param, default, allowed)
    begin
      if (param && allowed.class == Regexp && param.to_s =~ allowed)
        param.to_sym
      elsif (param && allowed.class == Array && allowed.map { |i| i.to_sym }.include?(param.to_sym))
        param.to_sym
      elsif (param && (allowed.class == String || allowed.class == Symbol) && allowed.to_sym == param.to_sym)
        param.to_sym
      else
        default.to_sym
      end
    rescue
      default.to_sym
    end
  end

  def self.check_boolean_param(param, default)
    if (param && param == "1" || param == "true")
      true
    elsif (param && param == "0" || param == "false")
      false
    else
      default
    end
  end
end
