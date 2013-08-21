require_relative 'edgecase'

class AboutRadioMaps < EdgeCase::Koan

  def setup
    show_page "radio_map.html"
  end

  class RadioPage < Watirmark::Page
    keyword(:status, {
            "On" => 0,
            "Off" => 1 #Add new value to keyword
    })                   { browser.radio(:name, "status_radio") }
  end

  def test_radio_maps_basic
    assert_equal __, browser.radio(:id, 'status_radio_on').set?
    RadioPage.new.status = "On"
    assert_equal __, browser.radio(:id, 'status_radio_on').set?
  end

  def test_radio_maps_next
    assert_equal __, browser.radio(:id, 'status_radio_unknown').set?
    assert_nothing_raised { RadioPage.new.status = "Unknown" }
    assert_equal __, browser.radio(:id, 'status_radio_unknown').set?
  end

  def test_radio_maps_advanced
    assert_equal __, browser.radio(:id, 'status_radio_on').set?
    assert_nothing_raised{ RadioPage.new.status = "on" }
    assert_equal __, browser.radio(:id, 'status_radio_on').set?
  end

end