module ParamChecker
  module HashExt

    def check(type, key, default, options = {})
      value = nil
      if key.class == Array
        value = self
        key.each do |k|
          value = value[k]
          break if value.nil?
        end
      else # String || Symbol
        value = self[key]
      end

      if value.nil?
        default
      else
        case type
        when :integer, :i
          ParamChecker.check_integer(value, default, options)
        when :float, :f
          ParamChecker.check_float(value, default, options)
        when :string, :s
          ParamChecker.check_string(value, default, options)
        when :symbol, :sym
          ParamChecker.check_symbol(value, default, options)
        when :boolean, :b
          ParamChecker.check_boolean(value, default, options)
        else
          raise
        end
      end
    end
  end
end
