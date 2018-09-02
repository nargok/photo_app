module ApplicationHelper
  def display_error(msg)
    msg.gsub(/\s/, "")
  end
end
