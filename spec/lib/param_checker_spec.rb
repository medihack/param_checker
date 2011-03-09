require 'spec_helper'

describe "ParamChecker" do
  before(:all) do
    @model = ParamCheckerModel.new
  end

  it "should check integer" do
    @model.check_integer_param("5", 99).should == 5
    @model.check_integer_param("5", 99, 4).should == 5
    @model.check_integer_param("5", 99, nil, 6).should == 5
    @model.check_integer_param("5", 99, 4, 6).should == 5
    @model.check_integer_param("-5", 99).should == -5
    @model.check_integer_param(" 5 ", 99).should == 5

    @model.check_integer_param("", 99).should == 99
    @model.check_integer_param("5abc", 99).should == 99
    @model.check_integer_param("5", 99, 6).should == 99
    @model.check_integer_param("5", 99, nil, 4).should == 99
    @model.check_integer_param("5", 99, 1, 4).should == 99
    @model.check_integer_param("5", 99, 10, 1).should == 99
  end

  it "should check float" do
    @model.check_float_param("5.1", 99.2).should == 5.1
    @model.check_float_param("5.1", 99.2, 4.3).should == 5.1
    @model.check_float_param("5.1", 99.2, nil, 6.4).should == 5.1
    @model.check_float_param("5.1", 99.2, 4.3, 6.4).should == 5.1
    @model.check_float_param("-5.1", 99.2).should == -5.1
    @model.check_float_param(" 5.1 ", 99.2).should == 5.1

    @model.check_float_param("", 99.2).should == 99.2
    @model.check_float_param("5abc", 99.2).should == 99.2
    @model.check_float_param("5", 99.2, 6.4).should == 99.2
    @model.check_float_param("5", 99.2, nil, 4.3).should == 99.2
    @model.check_float_param("5", 99.2, 1, 4.3).should == 99.2
    @model.check_float_param("5", 99.2, 10.5, 1.6).should == 99.2
  end

  it "should check string" do
    @model.check_string_param("lorem", "dolor", /.*ore.*/).should == "lorem"
    @model.check_string_param("lorem", "dolor", ["lorem", "ipsum"]).should == "lorem"
    @model.check_string_param("lorem", "dolor", "lorem").should == "lorem"
    @model.check_string_param("", "dolor", /.*/).should == ""
    @model.check_string_param("", "dolor", "").should == ""

    @model.check_string_param("lorem", "dolor", /.*ips.*/).should == "dolor"
    @model.check_string_param("lorem", "dolor", ["patre", "ipsum"]).should == "dolor"
    @model.check_string_param("lorem", "dolor", "ipsum").should == "dolor"
  end

  it "should check symbol" do
    @model.check_symbol_param("lorem", :dolor, /.*ore.*/).should == :lorem
    @model.check_symbol_param("lorem", :dolor, ["lorem", :ipsum]).should == :lorem
    @model.check_symbol_param("lorem", :dolor, :lorem).should == :lorem

    @model.check_symbol_param("lorem", :dolor, /.*ips.*/).should == :dolor
    @model.check_symbol_param("lorem", :dolor, ["patre", "ipsum"]).should == :dolor
    @model.check_symbol_param("lorem", :dolor, "ipsum").should == :dolor
    @model.check_symbol_param("lorem", "dolor", "ipsum").should == :dolor
    @model.check_symbol_param("", :dolor, /.*/).should == :dolor
    @model.check_symbol_param("", :dolor, "").should == :dolor
  end

  it "should check boolean" do
    @model.check_boolean_param("1", false).should == true
    @model.check_boolean_param("true", false).should == true
    @model.check_boolean_param("0", true).should == false
    @model.check_boolean_param("false", true).should == false

    @model.check_boolean_param("3", true).should == true
    @model.check_boolean_param("", true).should == true
    @model.check_boolean_param("abc", true).should == true
  end

  it "can be called as module functions" do
    ParamChecker.check_integer_param("5", 99).should == 5
    ParamChecker.check_float_param("5.1", 99.2).should == 5.1
    ParamChecker.check_string_param("lorem", "dolor", /.*ore.*/).should == "lorem"
    ParamChecker.check_symbol_param("lorem", :dolor, /.*ore.*/).should == :lorem
    ParamChecker.check_boolean_param("1", false).should == true
  end
end
