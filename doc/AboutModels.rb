require_relative "../koans/page_helpers"

module AboutModelsDocHelper
  include PageHelpers
  extend self

  def header
    %Q{<h1>Watirmark Factory Model</h1>
<pre>
  class SingleDonorModel < Watirmark::Model.factory
    keywords SingleDonorModelView.keywords
    traits :donor_address
    model_type Donor
    defaults do
        first_name {"John"}
        last_name  {"Smith"}
    end
  end
</pre>}
  end

  def test_model_defaults_doc
    document do
      header
    end
  end

  def test_model_value_doc
    document do
      header
    end
  end

  def test_model_update_value_doc
    document do
      header
    end
  end

  def test_model_update_doc
    document do
      header
    end
  end

  def test_model_methods_doc
    document do
      header
    end
  end

  def test_model_keywords_doc
    document do
      header
    end
  end

  def test_controller_without_model_doc
    document do
      header
    end
  end

  def test_controller_with_model_doc
    document do
      header
    end
  end
end

