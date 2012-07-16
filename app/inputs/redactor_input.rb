class RedactorInput < FormtasticBootstrap::Inputs::TextInput
  def input_html_options
    super.merge(:class => "#{super[:class]} redactor".strip)
  end
end