#!/usr/bin/env ruby
# -*- ruby -*-

require File.expand_path(File.dirname(__FILE__) + '/edgecase')


class AboutTraitsView < DonationFormView
  keyword(:amount) { browser.text_field(:id, "amount") }
  keyword(:firstname) { browser.text_field(:id, "first_name") }
  keyword(:lastname) { browser.text_field(:id, "last_name") }
  keyword(:gift_type) { browser.select_list(:id, "giftType") }
  keyword(:street) { browser.text_field(:id, "street_name") }
  keyword(:city) { browser.text_field(:id, "city") }
  keyword(:state) { browser.select_list(:id, "state") }
  keyword(:card_type,
          ["Visa"] => "A",
          ["Discover"] => "B",
          ["American Express"] => "C"
  ) { browser.radio(:name, "radgroup") }
  keyword(:cardnumber) { browser.text_field(:id, "credit_card") }
  keyword(:cvv) { browser.text_field(:id, "credit_card_cvv") }
  keyword(:exp_date) { browser.text_field(:id, "exp_date") }
  keyword(:submit) { browser.button(:value, "Submit") }
end

class AboutTraitsController < DonationFormController
  @view = AboutTraitsView
end

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
    card_type {"Visa"}
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

class TraitsModel < Watirmark::Model::Factory
  keywords AboutTraitsView.keywords
  traits :donor
end


class AboutTraits < EdgeCase::Koan

  def test_model_trait_value
    model = TraitsModel.new
    assert model.city == "___"
  end

  def test_invalid_trait_value
    model = TraitsModel.new
    AboutTraitsController.new(model).run :create
  end
end