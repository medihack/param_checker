module ParamChecker

  module_function

  # Check a parameter string if it is a valid integer and return its integer value.
  # * +param+: the string parameter to check
  # * +default+: the default integer to return if the check fails
  # * +options+: a hash of options:
  #   * +min+: the minimum integer value allowed
  #   * +max+: the maximum integer value allowed
  def check_integer(param, default, options = {})
    min = (options[:min] ? param.to_i >= options[:min] : true)
    max = (options[:max] ? param.to_i <= options[:max] : true)

    if (param && param.strip =~ /^-?[0-9]+$/ && min && max)
      param.to_i
    else
      default
    end
  end

  # Check a parameter string if it is a valid float and return its float value.
  # * +param+: the string parameter to check
  # * +default+: the default float to return if the check fails
  # * +options+: a hash of options:
  #   * +min+: the minimum float value allowed (optional)
  #   * +max+: the maximum float value allowed (optional)
  def check_float(param, default, options = {})
    min = (options[:min] ? param.to_f >= options[:min] : true)
    max = (options[:max] ? param.to_f <= options[:max] : true)

    if (param && param.strip =~ /^-?[0-9]+(\.[0-9]+)?$/ && min && max)
      param.to_f
    else
      default
    end
  end

  # Check a parameter string if it is a valid sting and return its string value.
  # * +param+: the string parameter to check
  # * +default+: the default string to return if the check fails
  # * +options+: a hash of options:
  #   * +allowed+: the allowed string values to check +param+ against; could be a regular expression, a string or an array of strings
  def check_string(param, default, options = {})
    allowed = options[:allowed]
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

  # Check a parameter string if it is a valid symbol and return its symbol value.
  # * +param+: the string parameter to check
  # * +default+: the default symbol to return if the check fails
  # * +options+: a hash of options:
  #   * +allowed+: the allowed symbol values to check +param+ against; could be a regular expression, a symbol or an array of symbols.
  def check_symbol(param, default, options = {})
    allowed = options[:allowed]
    if (param && !param.empty? && allowed.class == Regexp && param =~ allowed)
      param.to_sym
    elsif (param && !param.empty? && allowed.class == Array && allowed.map { |a| a.to_sym }.include?(param.to_sym))
      param.to_sym
    elsif (param && !param.empty? && (allowed.class == String || allowed.class == Symbol) && allowed.to_sym == param.to_sym)
      param.to_sym
    else
      default
    end
  end

  # Check a parameter string if it represents a valid boolean and return its boolean value.
  # * +param+: the string parameter to check
  # * +default+: the default boolean to return if the check fails
  # * +options+: a hash of options:
  #   * +true+: an array of string representations of true (by default "1" and "true")
  #   * +false+: an array of string representations of false (by default "0" and "false")
  def check_boolean(param, default, options = {})
    true_values = (options[:true] ? options[:true] : ["1", "true"])
    false_values = (options[:false] ? options[:false] : ["0", "false"])
    if (true_values.include?(param))
      true
    elsif (false_values.include?(param))
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
