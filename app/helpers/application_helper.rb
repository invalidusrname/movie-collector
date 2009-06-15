# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def sortable_link(link_name, options = {},  html_options = {})
    column  = options[:column]
    prefix  = options[:prefix].to_s

    sort_key = prefix.length > 0 ? prefix + '_sort' : 'sort'
    dir_key  = prefix.length > 0 ? prefix + '_dir' : 'dir'

    if params[sort_key] == column
      dir = (params[dir_key] && params[dir_key].downcase == 'asc') ? 'desc' : 'asc'
    else
      dir = 'asc'
    end

    options.delete(:column)
    options.delete(:prefix)

    options[sort_key.to_sym] = column
    options[dir_key.to_sym]  = dir

    link_to link_name, request.parameters.merge(options), html_options
  end
end
