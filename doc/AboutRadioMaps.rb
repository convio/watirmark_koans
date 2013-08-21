require_relative "doc_helpers"

module AboutRadioMapsDoc
  include DocHelpers
  extend self

  def sample_radio_map
    ruby %Q{
class RadioPage < Watirmark::Page
  keyword(:status, {
          "On" => 0,
          "Off" => 1
  })                   { browser.radio(:name, "status_radio") }
end
}
  end

  def set_radio
    ruby %Q{
RadioPage.new.status = "On"
}
  end

  def advanced_radio_map
    ruby %Q{
class RadioPage < Watirmark::Page
  keyword(:status, {
          ["On", "on"] => 0,
          "Off" => 1,
          "Unknown" => 2
  })                   { browser.radio(:name, "status_radio") }
end
}
  end

  document :test_radio_maps_basic, "Radio Maps" do
    %Q{
    <p>Watirmark handles radio maps like any other keyword, except it takes the whole radio button cluster as one keyword.

    #{sample_radio_map}

    <p> In this example, all the radio buttons have the same name parameter "status_radio," which allows this single keyword
        to populate multiple radio buttons.

    <p> After the status keyword is defined, the subsequent parameters link the radio button's label or your own string to
        the radio button's value. Here, the "On" string is linked to the 0 value and the "Off" string is linked to the 1 value.

    <p>Then to automate the clicking of the radio button, you just say:
    #{set_radio}

    <p>Add the Unknown radio button value to the keyword and set the Unknown radio button to continue.
    }
  end

  document :test_radio_maps_advanced, "Radio Maps Continued" do
    %Q{
      <p>Watirmark allows you to customize the naming of your radio buttons as you could see in the previous lesson.
         Another feature of Watirmark for radio buttons is giving multiple names for the individual values for the
         radio buttons. For example:

        #{advanced_radio_map}

      <p>Here, the status of the radio button can now be set with "On" and "on". It is no longer case sensitive.
         The string array is now set to the value.

      <p>Add "unknown" as a string for the Unknown radio button value and set the Unknown radio button to continue.

    }
  end
end