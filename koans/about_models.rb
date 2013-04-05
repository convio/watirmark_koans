#!/usr/bin/env ruby
# -*- ruby -*-

require File.expand_path(File.dirname(__FILE__) + '/edgecase')


class AboutModelsView < DonationFormView
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

class AboutModelsController < DonationFormController
  @view = AboutModelsView
end

class Model < Watirmark::Model::Factory
  keywords AboutModelsView.keywords

  defaults do
    amount {"10.00"}
    firstname {"First"}
    lastname {"Last"}
    cardnumber {"4111111111111111"}
    cvv {"111"}
    exp_date {"05/09/2014"}
  end
end

class ModelDefaults < Watirmark::Model::Factory
  keywords AboutModelsView.keywords

  defaults do
    firstname {"First"}
    lastname {"Last"}
    cardnumber {"4111111111111111"}
    cvv {"111"}
    exp_date {"05/09/2014"}
  end
end

class ModelKeywords < Watirmark::Model::Factory
  keywords [:amount, :firstname, :lastname, :cardnumber, :cvv]

  defaults do
    amount {"10.00"}
    firstname {"First"}
    lastname {"Last"}
    cardnumber {"4111111111111111"}
    cvv {"111"}
    exp_date {"05/09/2014"}
  end
end

class AboutModels < EdgeCase::Koan

  def test_model_values
    model = Model.new
    assert model.amount == "10.00"
    assert model.firstname == "___"
  end

  def test_model_hash
    model = Model.new.to_h
    assert model == {}
  end

  def test_model_defaults
    model = ModelDefaults.new
    AboutModelsController.new(model).run :create
  end

  def test_model_keywords
    model = ModelKeywords.new
    AboutModelsController.new(model).run :create    #HINT: Each model must define the keywords that can be used
  end
end