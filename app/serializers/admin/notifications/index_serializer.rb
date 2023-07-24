# frozen_string_literal: true

class Admin::Notifications::IndexSerializer < p Admin::Notifications::AttributesSerializer
  def description
    object.description.gsub('</p>', "\n").remove_html_tags
  end
end
