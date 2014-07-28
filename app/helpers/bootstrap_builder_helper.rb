require 'bootstrap_control_helper'
require 'bootstrap_form_helper'

module BootstrapBuilderHelper


  #class BootstrapBuilder < ActionView::Helpers::FormBuilder
    include BootstrapFormHelper
    include BootstrapControlHelper
  #end
end