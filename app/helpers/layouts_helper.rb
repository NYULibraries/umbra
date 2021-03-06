module LayoutsHelper
  # Meta tags to include in layout
  def meta
    meta = super
    meta << tag("link", :rel => "search", :type => "application/opensearchdescription+xml", :title =>  application_name, :href => opensearch_catalog_url(:format => 'xml', :only_path => false))
  end

  # Generate link to application root
  def application
    application = link_to application_name, root_path
    application << (params[:controller] == "catalog" and !params[:id]) ? content_tag(:span, t('blacklight.search.search_results'), :id => 'results_text') : ""
  end

  def application_title
    if collection_name.blank?
      t('blacklight.application_name')
    else
      collection_name
    end
  end

  # Print breadcrumb navigation
  def breadcrumbs
    breadcrumbs = super
    breadcrumbs << link_to('Catalog', {:controller =>'catalog', :collection => session[:collection]})
    breadcrumbs << link_to('Admin', :controller => 'records') if is_in_admin_view?
    breadcrumbs << link_to_unless_current(collection_name) unless params[:collection].nil?
    return breadcrumbs
  end

  # Prepend modal dialog elements to the body
  def prepend_body
    render partial: 'shared/ajax_modal'
  end

  def prepend_yield
    return unless show_search_box?

    prepend_yield = ""
    prepend_yield = render :partial => 'shared/header_navbar' unless is_in_admin_view?
    return prepend_yield.html_safe
  end

  # Boolean for whether or not to show tabs
  def show_tabs
    return false
  end

  # Only show search box on admin view or for search catalog, excluding bookmarks, search history, etc.
  def show_search_box?
    (is_in_admin_view? or controller.controller_name.eql? "catalog")
  end

  def gauges_tracking_code
    ENV['GAUGES_TOKEN']
  end

  # Add blacklight body classes to laytou
  def body_class
    class_names = render_body_class.html_safe
    class_names << " admin" if is_in_admin_view?
  end
end
