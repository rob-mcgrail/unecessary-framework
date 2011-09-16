# Haml templating engine options
HAML_OPTS = {
  :format => :html5,
  :ugly => true, # Set to true for production
}

# Coderay options
Haml::Filters::CodeRay.encoder_options = {
  :tab_width => 4,
  :css => :class,
  :wrap => :div,
  :line_numbers => :inline,
  :bold_every => 10,
}

