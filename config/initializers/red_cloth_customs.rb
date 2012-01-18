module RedCloth::Formatters::HTML
  def code(opts)
    "<pre class=\"prettyprint\">#{opts[:text]}</pre>\n"
  end
end
