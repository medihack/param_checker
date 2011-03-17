module ParamChecker

  module_function

  # Check a parameter string if it is a valid integer and return its integer value.
  # +param+: the string parameter to check
  # +default+: the default integer to return if the check fails
  # +min+: the minimum value allowed (optional)
  # +max+: the maximum value allowed (optional)
  def check_integer(param, default, min = nil, max = nil)
    min_lambda = (min.nil? ? lambda { true } : lambda { param.strip.to_i >= min })
    max_lambda = (max.nil? ? lambda { true } : lambda { param.strip.to_i <= max })

    if (param && param.strip =~ /^-?[0-9]+$/ && min_lambda.call && max_lambda.call)
      param.strip.to_i
    else
      default
    end
  end

  # Check a parameter string if it is a valid float and return its float value.
  # +param+: the string parameter to check
  # +default+: the default float to return if the check fails
  # +min+: the minimum value allowed (optional)
  # +max+: the maximum value allowed (optional)
  def check_float(param, default, min = nil, max = nil)
    min_lambda = (min.nil? ? lambda { true } : lambda { param.strip.to_i >= min })
    max_lambda = (max.nil? ? lambda { true } : lambda { param.strip.to_i <= max })

    if (param && param.strip =~ /^-?[0-9]+(\.[0-9]+)?$/ && min_lambda.call && max_lambda.call)
      param.strip.to_f
    else
      default.to_f
    end
  end

  # Check a parameter string if it is a valid sting and return its string value.
  # +param+: the string parameter to check
  # +default+: the default string to return if the check fails
  # +allowed+: the allowed string value to check +param+ against; could be
  #   a regular expression, a string or an array of strings
  def check_string(param, default, allowed)
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

  # Check a parameter string if it is a valid :symbol and return its symbol value.
  # +param+: the string parameter to check
  # +default+: the default symbol to return if the check fails
  # +allowed+: the allowed symbol value to check +param+ against; could be
  #   a regular expression, a string, a symbol, an array of strings or an array of symbols.
  def check_symbol(param, default, allowed)
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

  # Check a parameter string if it represents a valid boolean and return its boolean value.
  # Allowed string parameters are "1" or "true" for +true+, and "0" or "false" for +false+.
  # +param+: the string parameter to check
  # +default+: the default boolean to return if the check fails
  def check_boolean(param, default)
    if (param && param == "1" || param == "true")
      true
    elsif (param && param == "0" || param == "false")
      false
    else
      default
    end
  end

  public :check_integer,
         :check_float,
         :check_string,
         :check_symbol,
         :check_boolean
end
