module ApplicationHelper
  
  # Fetch and link to link field
  def link_field(field)
    link_to("Link to resource", field[:document][field[:field]], :target => :blank)
  end
  
  # Fetch HTML text from field
  def html_field(field)
    field[:document][field[:field]].first.html_safe
  end
  
  # Generate link to sorting action
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    direction_icon = (direction.eql? "desc") ? :sort_desc : :sort_asc
    search = params[:search]  
    html = link_to title, params.merge(:sort => column, :direction => direction, :page => nil, :id => ""), {:class => css_class}
    html << icon_tag(direction_icon) if column == sort_column
    return html
  end

end
