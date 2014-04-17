require_relative "doc_helpers"

module AboutControllerPopulationDoc
  include DocHelpers
  extend self

  def basic_controller_view
    ruby %Q{
class Donor < Watirmark::WebPage::Controller
  @view = DonorPage
  @model = DonorModel
end
}
  end

  def populate_data_override
    ruby %Q{
class DonorPopulateData < Watirmark::WebPage::Controller
    @view = DonorView
    @model = DonorModel

    def populate_data
      if @model.payment_type == "Check"
        @view.check_payment.set
      else
        @view.credit_payment.set
      end
      super
    end
  end
}
  end

  def populate_keyword_override
    ruby %Q{
class DonorPopulateKeyword < Watirmark::WebPage::Controller
  @view = DonorView
  @model = DonorModel

  def populate_check_number
    @view.check_payment.set
    @view.check_number = @model.check_number
  end

  def populate_credit_card
    @view.credit_payment.set
    @view.credit_card = @model.credit_card
  end
end
}
  end


  document :test_populate_data_override, "Controllers", "Populate Data" do
    %Q{
    <p>Now that we understand the relationship between the model, view, and controller lets understand the
      different ways we can use the controller to populate the form.
    </p>

    #{basic_controller_view}

    <p>We know that the above controller will allow us to populate a form without having to directly call the view
    for each web page object, but what if we had to do more work in order to get to these objects. The form to the
    left asks for a type of payment before we can actually enter our credit card or check number. One way to do
    this is by overriding the populate_data method which by default populates each view keyword object on the page.
    </p>

    <p>First we need to provide another keyword to the model and view like "payment_type". Based on this value from the
    model the controller will know how to populate the page object. A controller for our web page will look something
    like this:
    </p>

    #{populate_data_override}

    <p>To continue make the DonorPopulateData controller by overriding the populate_data method in order to populate the form.
       Be sure to place the DonorPopulateData controller below the DonorModel and DonorView so
       that ruby knows how to interperate those objects.
    }
  end

  document :test_populate_keyword, "Controllers", "Populate Keyword" do
    %Q{
    <p>Now that you have seen how to override the populate_data method lets look at solving the same problem with
    a different approach.
    </p>

    <p>Everytime a view is initialized a method is created for each of its keywords called "populate_KEYWORD". This
    method is used to populate the web page object that the keyword is associated with. Like the populate_data method
    these populate_KEYWORD methods can be overridden as well.
    </p>

    <p>For the same form as in the previous example a controller that uses this approach would look like this:</p>

    #{populate_keyword_override}

    <p>To continue create the DonorPopulateKeyword controller by overriding the populate_check_number and pouplate_credit_card methods.
       Again place this controller under DonorView and DonorModel so that ruby knows how to interperate them.
    }
  end


end