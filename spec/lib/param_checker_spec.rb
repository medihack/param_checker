require 'spec_helper'

describe "ParamChecker" do
  it "should check integer" do
    ParamChecker.check_integer_param("5", 99).should == 5
    ParamChecker.check_integer_param("5", 99, 4).should == 5
    ParamChecker.check_integer_param("5", 99, nil, 6).should == 5
    ParamChecker.check_integer_param("5", 99, 4, 6).should == 5
    ParamChecker.check_integer_param("-5", 99).should == -5
    ParamChecker.check_integer_param(" 5 ", 99).should == 5

    ParamChecker.check_integer_param("", 99).should == 99
    ParamChecker.check_integer_param("5abc", 99).should == 99
    ParamChecker.check_integer_param("5", 99, 6).should == 99
    ParamChecker.check_integer_param("5", 99, nil, 4).should == 99
    ParamChecker.check_integer_param("5", 99, 1, 4).should == 99
    ParamChecker.check_integer_param("5", 99, 10, 1).should == 99
  end

  it "should check float" do
    ParamChecker.check_float_param("5.1", 99.2).should == 5.1
    ParamChecker.check_float_param("5.1", 99.2, 4.3).should == 5.1
    ParamChecker.check_float_param("5.1", 99.2, nil, 6.4).should == 5.1
    ParamChecker.check_float_param("5.1", 99.2, 4.3, 6.4).should == 5.1
    ParamChecker.check_float_param("-5.1", 99.2).should == -5.1
    ParamChecker.check_float_param(" 5.1 ", 99.2).should == 5.1

    ParamChecker.check_float_param("", 99.2).should == 99.2
    ParamChecker.check_float_param("5abc", 99.2).should == 99.2
    ParamChecker.check_float_param("5", 99.2, 6.4).should == 99.2
    ParamChecker.check_float_param("5", 99.2, nil, 4.3).should == 99.2
    ParamChecker.check_float_param("5", 99.2, 1, 4.3).should == 99.2
    ParamChecker.check_float_param("5", 99.2, 10.5, 1.6).should == 99.2
  end

  it "should check string" do
    ParamChecker.check_string_param("lorem", "dolor", /.*ore.*/).should == "lorem"
    ParamChecker.check_string_param("lorem", "dolor", ["lorem", "ipsum"]).should == "lorem"
    ParamChecker.check_string_param("lorem", "dolor", "lorem").should == "lorem"
    ParamChecker.check_string_param("", "dolor", /.*/).should == ""
    ParamChecker.check_string_param("", "dolor", "").should == ""

    ParamChecker.check_string_param("lorem", "dolor", /.*ips.*/).should == "dolor"
    ParamChecker.check_string_param("lorem", "dolor", ["patre", "ipsum"]).should == "dolor"
    ParamChecker.check_string_param("lorem", "dolor", "ipsum").should == "dolor"
  end

  it "should check symbol" do
    ParamChecker.check_symbol_param("lorem", :dolor, /.*ore.*/).should == :lorem
    ParamChecker.check_symbol_param("lorem", :dolor, ["lorem", :ipsum]).should == :lorem
    ParamChecker.check_symbol_param("lorem", :dolor, :lorem).should == :lorem

    ParamChecker.check_symbol_param("lorem", :dolor, /.*ips.*/).should == :dolor
    ParamChecker.check_symbol_param("lorem", :dolor, ["patre", "ipsum"]).should == :dolor
    ParamChecker.check_symbol_param("lorem", :dolor, "ipsum").should == :dolor
    ParamChecker.check_symbol_param("lorem", "dolor", "ipsum").should == :dolor
    ParamChecker.check_symbol_param("", :dolor, /.*/).should == :dolor
    ParamChecker.check_symbol_param("", :dolor, "").should == :dolor
  end

  it "should check boolean" do
    ParamChecker.check_boolean_param("1", false).should == true
    ParamChecker.check_boolean_param("true", false).should == true
    ParamChecker.check_boolean_param("0", true).should == false
    ParamChecker.check_boolean_param("false", true).should == false

    ParamChecker.check_boolean_param("3", true).should == true
    ParamChecker.check_boolean_param("", true).should == true
    ParamChecker.check_boolean_param("abc", true).should == true
  end
end
