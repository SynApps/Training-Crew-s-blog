# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  @@link_rgx = /([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,3}[A-Za-z0-9\-\.\+\_\/\%\?\#\&\=]*/
  @@http_rgx = /http:\/\//
  @@https_rgx = /https:\/\//
  
  def format_comment comment
    if comment
      comment = format_carriage_return comment
      comment = format_links comment
    end  
    comment
  end
  def format_carriage_return comment
      comment = comment.gsub(/(\r\n|\n)/, '<br />')
      comment.gsub(/(<br \/>){3,20}/, '<br />')
  end
  def format_links comment
    if comment =~ @@http_rgx
      comment = comment.gsub(@@http_rgx, '')
      comment.gsub(@@link_rgx, '<a target="blank" href="http://\0">\0</a>')
    elsif  comment =~ @@https_rgx
      comment = comment.gsub(@@https_rgx, '')
      comment.gsub(@@link_rgx, '<a target="blank" href="https://\0">\0</a>')
    else
      comment
    end
  end
  
  def friendly_display date
    hours,minutes,seconds = Date.day_fraction_to_time(DateTime.now - date.to_datetime)
    
    if hours > 7 * 24
      return date.strftime("%Y-%m-%d")
    elsif (24..(24 * 7)).include?(hours)
        return "Depuis #{pluralize(hours / 24, 'jour')}"
    elsif (1..23).include?(hours)
      return "Depuis #{pluralize(hours, 'heure')}"
    elsif (1..59).include?(minutes)
      return "Depuis #{pluralize(minutes, 'minute')}"
    end 
    return "Depuis #{pluralize(seconds, 'seconde')}"
  end
end
