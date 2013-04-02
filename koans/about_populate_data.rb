#!/usr/bin/env ruby
# -*- ruby -*-

require File.expand_path(File.dirname(__FILE__) + '/edgecase')


class AboutPopulateView < DonationFormView
  keyword(:amount) { browser.text_field(:id, "amount") }
  keyword(:firstname) { browser.text_field(:id, "first_name") }
  keyword(:lastname) { browser.text_field(:id, "last_name") }
  keyword(:gift_type) { browser.select_list(:id, "giftType") }
  keyword(:street)   { browser.text_field(:id, "street_name")}
  keyword(:city)   { browser.text_field(:id, "city")}
  keyword(:state)   { browser.select_list(:id, "state")}
  keyword(:card_type,
          ["Visa"] => "A",
          ["Discover"] => "B",
          ["American Express"] => "C"
  ) { browser.radio(:name, "radgroup") }
  keyword(:cardnumber) { browser.text_field(:id, "credit_card") }
  keyword(:cvv) { browser.text_field(:id, "credit_card_cvv") }
  keyword(:exp_date) { browser.text_field(:id, "exp_date") }
  keyword(:submit)   { browser.button(:value, "Submit")}
end

class AboutPopulateController < DonationFormController
  @view = AboutPopulateView

  def populate_amount
    @view.amount = @model.amount
  end

  def populate_firstname
    @view.firstname = @model.firstname
  end

  def populate_lastname
    @view.lastname = @model.lastname
  end

  def populate_cardnumber

  end

end

class AboutPopulateData < EdgeCase::Koan

  def test_populate_cardnumber
    keywords = {:amount => "10.00",
                :firstname => "FisrtName",
                :lastname => "LastName",
                :card_type => "American Express",
                :cardnumber => "4111111111111111",
                :cvv => "111",
                :exp_date => "05/09/2014"}

    AboutPopulateController.new(keywords).run :create
  end

end