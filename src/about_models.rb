require_relative 'edgecase'

class AboutModels < EdgeCase::Koan

  def setup
    show_page "model_factory.html"
  end

  class Model < Watirmark::Model::Factory
    keywords [:amount, :firstname, :lastname, :cardnumber, :cvv]

    defaults do
      amount {"10.00"}
      firstname {"First"}
      lastname {"Last"}
      cardnumber {"4111111111111111"}
      cvv {"111"}
      exp_date {"05/09/2014"}
    end

    def full_name
      "#{firstname} #{lastname}"
    end
  end

  def test_model_defaults
    assert_equal __(true), Model.new.respond_to?(:amount)
  end

  def test_model_value
    assert_equal __("10.00"), Model.new.amount
  end

  def test_model_update_value
    model = Model.new
    model.amount = "55.00"
    assert_equal __("55.00"), model.amount
  end

  def test_model_update
    model = Model.new.update(:middlename => "Middle")
    assert_equal __(true), model.respond_to?(:middlename)
  end

  def test_model_methods
    assert_equal __("First Last"), Model.new.full_name
  end

  def test_model_keywords
    assert_equal __([:amount, :firstname, :lastname, :cardnumber, :cvv]), Model.new.keywords
  end
end