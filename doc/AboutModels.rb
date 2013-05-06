require_relative "doc_helpers"

module AboutModelsDoc
  include DocHelpers
  extend self

  def model
    ruby %Q{
class ContactPage < Watirmark::Page
  keyword(:first_name) { browser.text_field(:id => "first.name") }
  keyword(:middle_name) { browser.text_field(:id => "first.name") }
  keyword(:last_name)  { browser.text_field(:id => "last.name")  }
end

class ContactModel < Watirmark::Model.factory
  keywords ContactPage.keywords
end
}
  end

  def using_simple_model
    ruby %Q{
model = ContactModel.new
model.first_name = "John"
assert_equal "John", model.first_name
assert_equal nil, model.last_name
}
  end

  def model_with_defaults
    ruby %Q{
class ContactModel < Watirmark::Model.factory
  keywords ContactPage.keywords
  defaults do
    first_name {"first_\#{uuid}"}
    last_name  {"last_\#{uuid}"}
  end
end
}
  end

  def using_model_with_defaults
    ruby %Q{
model = ContactModel.new
assert_match /first_/, model.first_name
assert_match /last_/, model.last_name
}
  end


  def define_trait
    ruby %Q{
module Watirmark::Model
  trait :person do
    first_name  {"first_\#{uuid}" }
    last_name   {"last_\#{uuid}" }
  end
end
}
  end

  def include_trait
    ruby %Q{
class ContactModel < Watirmark::Model.factory
  keywords ContactPage.keywords
  traits :person
end

class AdministratorModel < Watirmark::Model.factory
  keywords ContactPage.keywords

  traits :person

  defaults do
    security_group "Administrators"
  end
end

class DonorModel < Watirmark::Model.factory
  keywords ContactPage.keywords + DonationPage.keywords

  traits :person, :donation
end
}
  end


  def define_trait_composition
    ruby %Q{
module Watirmark::Model
  trait :credit_card do
    credit_card_number      {4111111111111111}
    credit_card_cvv         {111}
    credit_card_expiry_date {Time.now.strftime "%m/%d/%Y"}
  end

  trait :donation do
    amount    {10}
    frequency {'monthly'}
    traits :credit_card
  end

  trait :store_purchase do
    item   {'neato item'}
    traits :credit_card
  end

end
}
  end

  document :test_model_basics, "Models" do
    %Q{
    <p>Models provide us a way to organize and pass our test data to controllers.

    #{model}

    <p>A model requires a list of keywords and then uses them to create getter and setter methods. By convention
       we pass in the keywords from the view because we then only need to define our keywords in one place.

    #{using_simple_model}

    <p>This model can now be passed to a controller.new and the controller would populate the form using
       these values. Where the real power of this starts becoming clear is when we take advantage
       of the model features. Let's redefine our model, but this time define a set of default values.

    #{model_with_defaults}

    <p>Now we're getting somewhere. Every time I create a new instance of this model, I get new data*. This
       means I can always create unique objects and not run into data collisions.

    #{using_model_with_defaults}

    <p valign="bottom">* The #uuid method generates a short, unique string
    }
  end

  document :test_model_traits, "Models", "Traits" do
     %Q{
       <p>For a full-scale app you can imagine that there would be a large number of models and probably more
       models than views. For example, our ContactPage has a ContactModel but you could imagine some
       permutations like DonorModel, AdministratorModel, etc where these other models are still constituents
       but might have a different set of defaults to fulfill their intended roles.

       <p>To handle this cleanly, we stole an idea from FactoryGirl and implemented the #traits feature.
          Traits are essentially a collection of model default values that can be reused and combined.

       #{define_trait}

       <p>The above trait defines a :person which can then be included in models as follows:

       #{include_trait}

     }
  end

  document :test_model_traits_containing_traits, "Models", "Composing Traits" do
    %Q{
       <p>Traits can also be composed, making them easier to reuse.
       #{define_trait_composition}

       <p>In this example we've defined a :credit_card trait and are able to reuse it to
          generate other traits that have some form of payment.
    }
  end

end

