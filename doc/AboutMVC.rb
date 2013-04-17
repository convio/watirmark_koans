require_relative "doc_helpers"

module AboutMVCDoc
  include DocHelpers
  extend self

  document :test_about_mvc, "MVC Design Patterns" do
    %Q{
      <p>Watirmark's architecture uses the Model/View/Controller design patterns. In our implementation,
         we use these components as follows:

      <h2>Model</h2>

      <p>A Model represents the data that is used to create a business object in your application. This could be a user, a donation
         or any other collection of data. In many cases, models can be created with default, unique data.
         This is great because most of the time you don't care about most of the details, you just want to create an object.
         For example you could just create a new contact using a model which would
         automatically give you a unique contact with a name, address, username, etc.

      <p>The Model is generally instantiated from the test case, modified based on the requirements of the test
         and passed into the Controller. If a model is not specified when a controller is created, the controller
         will create the default model for you.

      <h2>Controller</h2>

      <p>Controllers are how you directly interact with the web application.
         They are responsible for populating the fields and reading back values. When you instantiate a controller,
         you give it a Model and tell it an action (create, edit, verify, etc).

      <h2>View</h2>

      <p>The View is the interface between the test framework and the web application. It provides methods
         named after keywords that handle populating the HTML elements associcated with those keywords. It's
         based on the Page Object pattern so we refer to them interchangeably as Pages or Views.


      }
  end

end

