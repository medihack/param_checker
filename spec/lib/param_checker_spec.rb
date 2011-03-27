require 'spec_helper'

describe "ParamChecker" do
  before(:all) do
    @model = ParamCheckerModel.new
  end

  describe "check integer" do
    it "should pass" do
      @model.check_integer("5", 99).should == 5
      @model.check_integer("5", 99, :min => 4).should == 5
      @model.check_integer("5", 99, :max => 6).should == 5
      @model.check_integer("5", 99, :min => 4, :max => 6).should == 5
      @model.check_integer("-5", 99).should == -5
      @model.check_integer(" 5 ", 99).should == 5
    end

    it "should fail" do
      @model.check_integer(nil, 99).should == 99
      @model.check_integer("", 99).should == 99
      @model.check_integer("5abc", 99).should == 99
      @model.check_integer("5", 99, :min => 6).should == 99
      @model.check_integer("5", 99, :max => 4).should == 99
      @model.check_integer("5", 99, :min => 1, :max => 4).should == 99
      @model.check_integer("5", 99, :min => 10, :max => 1).should == 99
      @model.check_integer("", nil).should == nil
    end
  end

  describe "check float" do
    it "should pass" do
      @model.check_float("5.1", 99.2).should == 5.1
      @model.check_float("5.1", 99.2, :min => 4.3).should == 5.1
      @model.check_float("5.1", 99.2, :max => 6.4).should == 5.1
      @model.check_float("5.1", 99.2, :min => 4.3, :max => 6.4).should == 5.1
      @model.check_float("-5.1", 99.2).should == -5.1
      @model.check_float(" 5.1 ", 99.2).should == 5.1
      @model.check_float("5.1", 99.2, :min => 5.1, :max => 5.1).should == 5.1
    end

    it "should fail" do
      @model.check_float(nil, 99.2).should == 99.2
      @model.check_float("", 99.2).should == 99.2
      @model.check_float("5abc", 99.2).should == 99.2
      @model.check_float("5", 99.2, :min => 6.4).should == 99.2
      @model.check_float("5", 99.2, :max => 4.3).should == 99.2
      @model.check_float("5", 99.2, :min => 1, :max => 4.3).should == 99.2
      @model.check_float("5", 99.2, :min => 10.5, :max => 1.6).should == 99.2
      @model.check_float("", nil).should == nil
    end
  end

  describe "check string" do
    it "should pass" do
      @model.check_string("lorem", "dolor", :allowed => /.*ore.*/).should == "lorem"
      @model.check_string("lorem", "dolor", :allowed => ["lorem", "ipsum"]).should == "lorem"
      @model.check_string("lorem", "dolor", :allowed => "lorem").should == "lorem"
      @model.check_string("", "dolor", :allowed => /.*/).should == ""
      @model.check_string("", "dolor", :allowed => "").should == ""
    end

    it "should fail" do
      @model.check_string("lorem", "dolor").should == "dolor"
      @model.check_string(nil, "dolor", :allowed => /.*ore.*/).should == "dolor"
      @model.check_string("lorem", "dolor", :allowed => /.*ips.*/).should == "dolor"
      @model.check_string("lorem", "dolor", :allowed => ["patre", "ipsum"]).should == "dolor"
      @model.check_string("lorem", "dolor", :allowed => "ipsum").should == "dolor"
      @model.check_string("lorem", nil, :allowed => /.*ips.*/).should == nil
    end
  end

  describe "check symbol" do
    it "should pass" do
      @model.check_symbol("lorem", :dolor,:allowed =>  /.*ore.*/).should == :lorem
      @model.check_symbol("lorem", :dolor, :allowed => ["lorem", :ipsum]).should == :lorem
      @model.check_symbol("lorem", :dolor, :allowed => :lorem).should == :lorem
    end

    it "should fail" do
      @model.check_string("lorem", :dolor).should == :dolor
      @model.check_symbol(nil, :dolor, :allowed => /.*ore.*/).should == :dolor
      @model.check_symbol("lorem", :dolor, :allowed => /.*ips.*/).should == :dolor
      @model.check_symbol("lorem", :dolor, :allowed => ["patre", "ipsum"]).should == :dolor
      @model.check_symbol("lorem", :dolor, :allowed => "ipsum").should == :dolor
      @model.check_symbol("lorem", :dolor, :allowed => "ipsum").should == :dolor
      @model.check_symbol("", :dolor, :allowed => /.*/).should == :dolor
      @model.check_symbol("", :dolor, :allowed => "").should == :dolor
      @model.check_symbol("lorem", nil, :allowed => /.*ips.*/).should == nil
      @model.check_symbol("", :dolor, :allowed => "").should == :dolor
    end
  end

  describe "check boolean" do
    it "should pass" do
      @model.check_boolean("1", false).should == true
      @model.check_boolean("true", false).should == true
      @model.check_boolean("0", true).should == false
      @model.check_boolean("false", true).should == false
    end

    it "should fail" do
      @model.check_boolean(nil, true).should == true
      @model.check_boolean("3", true).should == true
      @model.check_boolean("", true).should == true
      @model.check_boolean("abc", true).should == true
      @model.check_boolean("abc", nil).should == nil
    end

    it "should pass with custom true and false values" do
      @model.check_boolean("yes", false, :true => "yes").should == true
      @model.check_boolean("no", true, :false => "no").should == false
      @model.check_boolean("ja", false, :true => ["yes", "ja"]).should == true
      @model.check_boolean("nein", true, :false => ["no", "nein"]).should == false
    end

    it "should fail with custom true and false values" do
      @model.check_boolean("yep", false, :true => "yes").should == false
      @model.check_boolean("nope", true, :false => "no").should == true
      @model.check_boolean("yep", false, :true => ["yes", "ja"]).should == false
      @model.check_boolean("nope", true, :false => ["no", "nein"]).should == true
    end
  end

  describe "hash extension" do


    before do
      class Hash
        include ParamChecker::HashExt
      end

      @params = Hash[
        :lorem => "ipsum",
        :foo => { :bar => "dato" }
      ]
     # @params.extend(ParamChecker::HashExt)
    end

    it "should call param checker module functions" do
      ParamChecker.should_receive(:check_integer)
      @params.check(:i, :lorem, nil)

      ParamChecker.should_receive(:check_integer)
      @params.check(:integer, :lorem, nil)

      ParamChecker.should_receive(:check_float)
      @params.check(:f, :lorem, nil)

      ParamChecker.should_receive(:check_float)
      @params.check(:float, :lorem, nil)

      ParamChecker.should_receive(:check_string)
      @params.check(:s, :lorem, nil)

      ParamChecker.should_receive(:check_string)
      @params.check(:string, :lorem, nil)

      ParamChecker.should_receive(:check_symbol)
      @params.check(:sym, :lorem, nil)

      ParamChecker.should_receive(:check_symbol)
      @params.check(:symbol, :lorem, nil)

      ParamChecker.should_receive(:check_boolean)
      @params.check(:b, :lorem, nil)

      ParamChecker.should_receive(:check_boolean)
      @params.check(:boolean, :lorem, nil)
    end

    it "should use multiple keys" do
      ParamChecker.should_receive(:check_string).with("dato", nil, {})
      @params.check(:s, [:foo, :bar], nil)
    end
  end

  it "can be called as module functions" do
    ParamChecker.check_integer("5", 99).should == 5
    ParamChecker.check_float("5.1", 99.2).should == 5.1
    ParamChecker.check_string("lorem", "dolor", :allowed => /.*ore.*/).should == "lorem"
    ParamChecker.check_symbol("lorem", :dolor, :allowed => /.*ore.*/).should == :lorem
    ParamChecker.check_boolean("1", false).should == true
  end
end
