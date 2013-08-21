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

  def sample_radio_map_2
    ruby %Q{
class RadioPage < Watirmark::Page
  keyword(:status, {
          "On" => 0,
          "Off" => 1,
          "Unknown" => 2
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

    <p>Set the radio button to on
    }
  end

  document :test_radio_maps_next, "Radio Maps Continued" do
    %Q{
      <p>The second parameter for the keyword is a hash, so to add an extra link is very simple.

      #{sample_radio_map_2}

      <p>Now the Unknown radio button is able to be set through the values.

      <p> To continue, add Unknown radio button to the keyword and set the radio button to the Unknown radio button.
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

      <p>Add "on" as a string for the On radio button value and set the On radio button to continue.

    }
  end
end