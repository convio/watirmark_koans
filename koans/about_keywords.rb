#!/usr/bin/env ruby
# -*- ruby -*-

require File.expand_path(File.dirname(__FILE__) + '/edgecase')


class AboutKeywordsView < DonationFormView
  keyword(:amount) { browser.text_field(:id, "amount") }
  keyword(:firstname) { browser.text_field(:id, "first_name") }
  keyword(:lastname) { browser.text_field(:id, "last_name") }
  keyword(:street)   { browser.text_field(:id, "street")}
  keyword(:city)   { browser.text_field(:id, "city")}
  keyword(:state)   { browser.select_list(:id, "state")}
  keyword(:card_type,
          ["Visa"] => "A",
          ["Discover"] => "B"
  ) { browser.radio(:name, "radgroup") }
  keyword(:cardnumber) { browser.text_field(:id, "credit_card") }
  keyword(:cvv) { browser.text_field(:id, "credit_card_cvv") }
  keyword(:exp_date) { browser.text_field(:id, "exp_date") }
  keyword(:submit)   { browser.button(:value, "Submit")}
end

class AboutKeywordsController < DonationFormController
  @view = AboutKeywordsView
end

class AboutKeywords < EdgeCase::Koan

  def test_missing_keyword
    keywords = {:amount => "10.00",
                :firstname => "FisrtName",
                :lastname => "LastName",
                :card_type => "Visa",
                :cardnumber => "4111111111111111",
                :cvv => "111"}

    AboutKeywordsController.new(keywords).run :create
  end

  def test_invalid_identifier
    keywords = {:amount => "10.00",
                :firstname => "FisrtName",
                :lastname => "LastName",
                :street => "123 oak hill lane",
                :city => "Austin",
                :state => "Texas",
                :card_type => "Visa",
                :cardnumber => "4111111111111111",
                :cvv => "111"}

    AboutKeywordsController.new(keywords).run :create
  end
end