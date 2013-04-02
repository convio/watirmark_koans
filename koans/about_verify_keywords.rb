#!/usr/bin/env ruby
# -*- ruby -*-

require File.expand_path(File.dirname(__FILE__) + '/edgecase')


class AboutVerifyKeywordView < ContactInfoView

  populate_keyword(:name) { browser.text_field(:id, "donorName") }
  populate_keyword(:amount) { browser.text_field(:id, "amount") }
  populate_keyword(:paytype) { browser.select_list(:id, "paymentType") }

  #contact information
  verify_keyword(:firstname) { contact_table.row(:text, /First Name/).cell(:index, 1) }
  verify_keyword(:lastname) { contact_table.row(:text, /Last Name/).cell(:index, 1) }
  verify_keyword(:street) { contact_table.row(:text, /Street Address/).cell(:index, 1) }
  verify_keyword(:city) { contact_table.row(:text, /City/).cell(:index, 1) }
  verify_keyword(:state) { contact_table.row(:text, /State/).cell(:index, 1) }
  verify_keyword(:zip) { contact_table.row(:text, /Postal Codee/).cell(:index, 1) }

  #transaction information
  private_keyword(:donorname) {}
  verify_keyword(:transactiondate) { |name| locate_row(name).cell(:index, 1).text }
  verify_keyword(:transactionamount) { |name| locate_row(name).cell(:index, 5).text }
  verify_keyword(:paymenttype) { |name| locate_row(name).cell(:index, 3).text }

  def locate_row name
    transaction_table.row(:text, /#{name}/)
  end
end

class VerifyKeywords < ContactInfoController
  @view = AboutVerifyKeywordView

  def verify_transactiondate
    assert @view.transactiondate(@model.donorname) == @model.transactiondate
  end

  def verify_transactionamount
    assert @view.transactionamount(@model.donorname) == @model.transactionamount
  end

  def verify_paymenttype
    assert @view.paymenttype == @model.paymenttype
  end
end


class AboutVerifyKeyword < EdgeCase::Koan

  def test_verify_keyword1
    verify_keywords = {:firstname => "Jonny"}
    VerifyKeywords.new(verify_keywords).run :verify
  end

  def test_verify_keyword2
    verify_keywords = {:firstname => "Bobby",
                       :lastname => "Joe",
                       :street => "1235 Oak Hill Lane",
                       :city => "Austin",
                       :state => "Texas",
                       :zip => "78754"}

    VerifyKeywords.new(verify_keywords).run :verify #HINT: Maybe something is wrong the the controllers view
  end

  def test_verify_keyword3
    verify_keywords = {:donorname => "John Smith",
                       :transactiondate => "1-1-2013",
                       :transactionamount => "$25.00"} #HINT: Check the view keywords identifier

    VerifyKeywords.new(verify_keywords).run :verify
  end

  def test_verify_keyword4
    verify_keywords = {:donorname => "Aaron Rogers",
                       :transactiondate => "2-21-2013",
                       :transactionamount => "$85.65",
                       :paymenttype => "PayPal"}

    VerifyKeywords.new(verify_keywords).run :verify #HINT: check the controller verify methods
  end

  def test_verify_keyword5
    keywords = {:name => "Tony Romo",
                :amount => "$25.00",
                :paytype => "Credit Card"}

    verify_keywords = {:donorname => "Tony Romo",
                       :transactionamount => "$25.22"}

    keywords = keywords.merge!(verify_keywords)

    VerifyKeywords.new(keywords).run :create, :verify
  end

end