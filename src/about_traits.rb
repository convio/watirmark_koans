require_relative 'edgecase'

module Watirmark::Model

  trait :person do
    firstname {"First"}
    lastname  {"Last"}
  end

  trait :address do
    street {"123 Oak Hill Lane"}
    city {"Austin"}
    state {"Texas"}
  end

  trait :credit_card do
    cardnumber {"4111111111111111"}
    cvv {"111"}
    exp_date {"05/09/2014"}
  end

  trait :donor do
    traits :person, :address, :credit_card
    amount {"10.00"}
    gift_type {"Offline Donation"}
  end

end

class AboutTraits < EdgeCase::Koan

  class RegistrationModel < Watirmark::Model::Factory
    keywords [:amount, :firstname, :lastname, :cardnumber, :cvv]
    traits :donor
  end

  def test_traits_in_trait
    assert_equal __([:person, :address, :credit_card]), Watirmark::Model::Traits.instance[:donor].traits
  end

  def test_model_traits
    assert_equal __([:donor]), RegistrationModel.new.traits
  end

  def test_model_has_trait_values
    assert_equal __(true), RegistrationModel.new.respond_to?(:amount)
  end

  def test_model_trait_values
    assert_equal __("10.00"), RegistrationModel.new.amount
  end
end