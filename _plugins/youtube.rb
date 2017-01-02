class YouTube < Liquid::Tag
  Liquid::Template.register_tag "youtube", self

  DefaultWidth = 560
  DefaultHeight = 420
  Pattern = /^\s*([^\s]+)(\s+(\d+)\s+(\d+)\s*)?/

  def initialize(tagName, markup, tokens)
    super

    if markup =~ Pattern then
      @id = $1
      @width = $3 || DefaultWidth
      @height = $4 || DefaultHeight
    else
      raise "No YouTube ID provided in the \"youtube\" tag"
    end
  end

  def render(context)
    "<iframe width=\"#{@width}\" height=\"#{@height}\" src=\"http://www.youtube.com/embed/#{@id}?color=white&theme=light\" frameborder=\"0\" allowfullscreen></iframe>"
  end
end
