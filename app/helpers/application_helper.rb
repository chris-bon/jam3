module ApplicationHelper
  def title value
    @title = "#{value} | Jamrb" unless value.nil?
  end
end
