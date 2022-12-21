# frozen_string_literal: true

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def sortable_link(link_name, options = {}, html_options = {})
    column  = options[:column]
    prefix  = options[:prefix].to_s

    sort_key = prefix.length.positive? ? "#{prefix}_sort" : "sort"
    dir_key  = prefix.length.positive? ? "#{prefix}_dir" : "dir"

    dir = if params[sort_key] == column
            params[dir_key] && params[dir_key].downcase == "asc" ? "desc" : "asc"
          else
            "asc"
          end

    options.delete(:column)
    options.delete(:prefix)

    options[sort_key.to_sym] = column
    options[dir_key.to_sym]  = dir

    link_to link_name, request.parameters.merge(options), html_options
  end

  # snagged from http://snippets.dzone.com/posts/show/487
  def rel_date(date)
    date = Date.parse(date, true) unless /Date.*/ =~ date.class.to_s
    days = (date - Date.today).to_i

    return "today"     if (days >= 0) && (days < 1)
    return "tomorrow"  if (days >= 1) && (days < 2)
    return "yesterday" if (days >= -1) && days.negative?

    return "in #{days} days"      if (days.abs < 60) && days.positive?
    return "#{days.abs} days ago" if (days.abs < 60) && days.negative?

    return date.strftime("%A, %B %e") if days.abs < 182

    date.strftime("%A, %B %e, %Y")
  end

  LETTERS = ("A".."Z").entries + ["All"]

  def navigation_links(current_letter, controller)
    html = ""
    LETTERS.each do |letter|
      html << if letter == current_letter
                " #{content_tag(:span, letter, class: "current")}"
              else
                " #{link_to(letter, controller:, letter:)}"
              end
    end
    html
  end
end
