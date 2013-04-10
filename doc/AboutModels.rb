require_relative "../koans/page_helpers"

module AboutModelsDocHelper
  include PageHelpers
  extend self

  def header
    %Q{<h1>Watirmark Factory Model</h1>
<pre class="ruby">

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
  end
</pre>}
  end

  def test_model_defaults_doc
    document do
      html = header
      html += %Q{
<p>Models can be defined with default values that you can access</p>
<pre class="ruby">

  model = SingleDonorModel.new
  model.first_name.should == "John"
</pre>}
    end
  end

  def test_model_value_doc
    document do
      html = header
      html += %Q{
<p>Models can be defined with default values that you can access</p>
<pre class="ruby">

  model = SingleDonorModel.new
  model.first_name.should == "John"
</pre>}
    end
  end

  def test_model_update_value_doc
    document do
      html = header
      html += %Q{
<p>Models allow you to update there default values</p>
<pre class="ruby">

  model = SingleDonorModel.new
  model.first_name "Alex"
  model.first_name.should == "Alex"
</pre>}
    end
  end

  def test_model_update_doc
    document do
      html = header
      html += %Q{
<p>Models allow you to update there default values</p>
<pre class="ruby">

  model = SingleDonorModel.new
  model.first_name "Alex"
  model.first_name.should == "Alex"
</pre>}
    end
  end

  def test_model_methods_doc
    document do
      html = header
      html += %Q{
<p>You can define methods within a model that can be called</p>
<pre class="ruby">

  model = SingleDonorModel.new
  model.full_name.should == "Smith, Jon"
</pre>}
    end
  end

  def test_model_keywords_doc
    document do
      html = header
      html += %Q{
<p>Each models defines the keywords that can be used when populating page objects</p>
<pre class="ruby">

  model = SingleDonorModel.new
  model.keywords.should == SingleDonorModelView.keywords
</pre>}
    end
  end

  def test_controller_without_model_doc
    document do
      html = header
      html += %Q{
<p>Use models with your controllers to keep you tests clean and easy to read</p>
<pre class="ruby">

  model = SingleDonorModel.new
  DonationController.new(model).run :create
</pre>}
    end
  end

  def test_controller_with_model_doc
    document do
      html = header
      html += %Q{
<p>Use models with your controllers to keep you tests clean and easy to read</p>
<pre class="ruby">

  model = SingleDonorModel.new
  DonationController.new(model).run :create
</pre>}
    end
  end
end

