require_relative "doc_helpers"

module AboutWatirmarkKoansDoc
  include DocHelpers
  extend self

  document :test_about_watirmark_koans, "Watirmark Koans" do
    %Q{
    <p>The Watirmark Koans are designed to be an interactive introduction to the
       Watirmark framework.

    <p>We assume in this tutorial that you have some familiarity with the ruby koans by EdgeCase. This
       software is based on the work from that project: <a href="http://rubykoans.com/">http://rubykoans.com/</a>

    <h2>Koan Interface</h2>
    <p> There are three parts to these koans:
      <ul>
      <li>The left pane is the UI that we're interacting with and testing</li>
      <li>The right pane is for instruction and sample code about the current topic</li>
      <li>The bottom pane will show the koan output</li>
      </ul>

    <h2>Koan Structure</h2>
    <p>The koans are broken out into subject areas by file: page objects are covered in about_page_objects.rb,
       models are introduced in about_models.rb, etc. They are presented in order in the
       path_to_enlightenment.rb file.

    <p>Each koan builds up your knowledge of Watirmark. It will stop at the first place you need to correct.

    <p>Some koans simply need to have the correct answer substituted for an incorrect one.
       Some, however, require you to supply your own answer. If you see the method __ (a double underscore)
       listed, it is a hint to you to supply your own code in order to make it work correctly.

    <h2>Your First Koan</h2>
    <p>Look at the output of this test and go to the line of code indicated. Change the test so the test case
       passes and re-run to continue on to the next koan.
    }
  end

end
