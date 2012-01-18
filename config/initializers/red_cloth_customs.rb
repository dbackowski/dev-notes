=begin
module RedCloth::Formatters::HTML
  def code(opts)
    "<pre class=\"prettyprint\"><notextile>#{opts[:text]}</notextile></pre>\n"
  end
end
=end
