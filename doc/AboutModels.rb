require_relative "doc_helpers"

module AboutModelsDocHelper
  include DocHelpers
  extend self

  def donor_model
    ruby %Q{
class SingleDonorModel < Watirmark::Model.factory
  keywords SingleDonorModelView.keywords
  traits :donor_address
  model_type Donor
  defaults do
      first_name {"John"}
      last_name  {"Smith"}
  end

  def full_name
    "\#{last_name}, \#{first_name}"
  end
end}
  end

  document "test_model_defaults", "Models", "Default Values" do
    %Q{
    #{donor_model}
    <p>Models can be defined with default values that you can access</p>
    <pre class="ruby">

    model = SingleDonorModel.new
    model.first_name.should == "John"
    </pre>}
  end

  document "test_model_value", "Models", "Getting Values"  do
    %Q{
    #{donor_model}
    <p>Models can be defined with default values that you can access</p>
    <pre class="ruby">

      model = SingleDonorModel.new
      model.first_name.should == "John"
    </pre>}
  end

  document "test_model_update_value", "Models", "Updating Default Values"  do
    %Q{
    #{donor_model}
    <p>Models allow you to update there default values</p>
    <pre class="ruby">

      model = SingleDonorModel.new
      model.first_name "Alex"
      model.first_name.should == "Alex"
    </pre>}
  end

  document "test_model_update", "Models", "Updating Default Values"   do
    %Q{
    #{donor_model}
    <p>Models allow you to update there default values</p>
    <pre class="ruby">

      model = SingleDonorModel.new
      model.first_name "Alex"
      model.first_name.should == "Alex"
    </pre>}
  end

  document "test_model_methods", "Models" , "Using Model Methods"  do
    %Q{
    #{donor_model}
    <p>You can define methods within a model that can be called</p>
    <pre class="ruby">
      model = SingleDonorModel.new
      model.full_name.should == "Smith, Jon"
    </pre>}
  end

  document "test_model_keywords", "Models", "Keywords"   do
    %Q{
    #{donor_model}
    <p>Each models defines the keywords that can be used when populating page objects</p>
    <pre class="ruby">

      model = SingleDonorModel.new
      model.keywords.should == SingleDonorModelView.keywords
    </pre>}
  end

  document "test_controller_without_model_doc", "Models", "Using with a controller"  do
    %Q{
    #{donor_model}
    <p>Use models with your controllers to keep you tests clean and easy to read</p>
    <pre class="ruby">

      model = SingleDonorModel.new
      DonationController.new(model).run :create
    </pre>}
  end

  document "test_controller_with_model", "Models", "Using with a controller"  do
    %Q{
    #{donor_model}
    <p>Use models with your controllers to keep you tests clean and easy to read</p>
    <pre class="ruby">

      model = SingleDonorModel.new
      DonationController.new(model).run :create
    </pre>}
  end

end

