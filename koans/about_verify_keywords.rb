#!/usr/bin/env ruby
# -*- ruby -*-

require File.expand_path(File.dirname(__FILE__) + '/edgecase')


class AboutVerifyKeywordView < ContactInfoView
  #contact information
  verify_keyword(:firstname) { contact_table.row(:text, /First Name/).cell(:index, 1) }
  verify_keyword(:lastname) { contact_table.row(:text, /Last Name/).cell(:index, 1) }
  verify_keyword(:street) { contact_table.row(:text, /Street Address/).cell(:index, 1) }
  verify_keyword(:city) { contact_table.row(:text, /City/).cell(:index, 1) }
  verify_keyword(:state) { contact_table.row(:text, /State/).cell(:index, 1) }
  verify_keyword(:zip) { contact_table.row(:text, /Postal Codee/).cell(:index, 1) }

  #transaction information
  verify_keyword(:transactiondate) { |name| locate_row(name).cell(:index, 1) }
  verify_keyword(:transactionamount) { |name| locate_row(name).cell(:index, 2) }
  verify_keyword(:paymenttype) { |name| locate_row(name).cell(:index, 3) }
  verify_keyword(:source) { |name| locate_row(name).cell(:index, 4) }

  def locate_row name
    transaction_table.row(:text, /name/)
  end
end

class VerifyKeywords < ContactInfoController
  @view = AboutVerifyKeywordView
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

    VerifyKeywords.new(verify_keywords).run :verify  #Cannot locate element on page. Maybe something is wrong the the controllers view
  end

end