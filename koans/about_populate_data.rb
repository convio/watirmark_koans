#!/usr/bin/env ruby
# -*- ruby -*-

require File.expand_path(File.dirname(__FILE__) + '/edgecase')


class AboutPopulateView < DonationFormView
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

class PopulateDataOne < DonationFormController
  @view = AboutPopulateView

  def populate_data
    @view.amount = "10.00"
    @view.firstname = "FirstName"
    @view.lastname = "LastName"
    @view.cardnumber = "4111111111111111"
    @view.cvv = "111"
    @view.exp_date = #Enter value to populate field
    submit
  end
end

class PopulateDataTwo < DonationFormController
  @view = AboutPopulateView

  def populate_data
    @view.amount = @model.amount
    @view.firstname = @model.firstname
    @view.lastname = @model.lastname
    @view.cardnumber = @model.cardnumber
    @view.cvv = @model.cvv
    @view.exp_date = #enter model value to populate field
    submit
  end

end

class PopulateDataThree < DonationFormController
  @view = AboutPopulateView

  def populate_data
    super
  end
end

class PopulateDataFour < DonationFormController
  @view = AboutPopulateView

  def populate_data
    super           #calls populate_amount, and populate_exp_date
  end

  def populate_amount
    @view.amount = @model.amount
  end

  def populate_exp_date

  end
end

class PopulateDataFive < DonationFormController
  @view = AboutPopulateView

  def populate_data
    populate_required_info
  end

  def populate_required_info
    @view.amount = @model.amount
    @view.firstname = @model.firstname
    @view.lastname = @model.lastname
    @view.cardnumber = @model.cardnumber
    @view.cvv = @model.cvv
    @view.exp_date = #enter model value to populate field
    submit
  end
end




class AboutPopulateData < EdgeCase::Koan

  def test_populate_data1
    PopulateDataOne.new().run :create
  end

  def test_populate_data2
    model = {:amount => "10.00",
             :firstname => "FisrtName",
             :lastname => "LastName",
             :card_type => "American Express",
             :cardnumber => "4111111111111111",
             :cvv => "111",
             :exp_date => "05/09/2014"}

    PopulateDataTwo.new(model).run :create
  end

  def test_populate_data3
    model = {:amount => "10.00",
             :firstname => "FisrtName",
             :lastname => "LastName",
             :card_type => "American Express",
             :cardnumber => "4111111111111111",
             :cvv => "111",
             :exp_date => nil} #missing exp_date value in model

    PopulateDataThree.new(model).run :create
  end

  def test_populate_data4
    model = {:amount => "10.00",
             :firstname => "FisrtName",
             :lastname => "LastName",
             :card_type => "American Express",
             :cardnumber => "4111111111111111",
             :cvv => "111",
             :exp_date => "05/09/2014"}

    PopulateDataFour.new(model).run :create
  end

  def test_populate_data5
    model = {:amount => "10.00",
             :firstname => "FisrtName",
             :lastname => "LastName",
             :card_type => "American Express",
             :cardnumber => "4111111111111111",
             :cvv => "111",
             :exp_date => "05/09/2014"}

    PopulateDataFive.new(model).run :create
  end
end