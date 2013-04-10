require_relative "doc_helpers"

module AboutWatirmarkKoansDocHelper
  include DocHelpers
  extend self

  document :test_about_watirmark_koans, "Watirmark Koans" do
    %Q{
    <p>This pane will provide some instruction
    }
  end
end
