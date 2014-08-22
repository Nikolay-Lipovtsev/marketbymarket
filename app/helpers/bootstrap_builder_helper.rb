module BootstrapBuilderHelper
  class BootstrapBuilderHelper < ActionView::Helpers::FormBuilder # NestedForm::Builder
    include BootstrapControlHelper
    include BootstrapFormHelper
  end
end