module ApplicationHelper
  def render_fact_titles(field_titles)
    if field_titles
      tag.ul do
        field_titles.split("|").map { |n| tag.li(n) }.join("").html_safe
      end
    end
  end
end
