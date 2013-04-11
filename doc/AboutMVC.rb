require_relative "doc_helpers"

module AboutMVCDoc
  include DocHelpers
  extend self

  document :test_about_mvc, "The MVC Design Pattern" do
    %Q{
      <p>Watirmark's architecture uses the Model/View/Controller design pattern. In our implementation,
         we use these components as follows:

      <h2>Model</h2>

      <p>The Model represents an abstraction of test data. This could be a user, a donation
         or any other collection of data you want to populate or verify in the application. In many cases,
         Models do not need any data to be specified and can make up unique data as you need it. This allows you
         to write tests that create new users and then use those users to login to the application, without
         having to worry about creating a name, address, username, etc.

      <p>The Model is generally instantiated from the test case, modified based on the requirements of the test
         and passed into the Controller. If a model is not specified when a controller is created, the controller
         can create a default model for you.

      <h2>Controller</h2>

      <p>Controllers are the main interface your test cases use to work with the web application.
         They are responsible for populating the fields and reading back values. When you instantiate a controller,
         you give it a Model and tell it an action (create, edit, verify, etc).

         Controllers are the only part of the test framework that know about the other actors in the MVC pattern.
         Both the Model and the View only know about their own responsibilities and it's the controllers job
         to determine how to use them.

      <h2>View</h2>

      <p>The View is the interface between the test framework and the web application. It provides methods
         named after keywords that handle populating the HTML elements associcated with those keywords. It's
         based on the Page Object pattern so are also called Pages in Watirmark


      }
  end

end

