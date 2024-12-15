module ApplicationHelper
  def show_svg(name, options = {})
    icon = render inline: Rails.root.join("app", "assets", "images", "#{name}.svg").read
    content_tag(:i, icon, options)
  end
end
