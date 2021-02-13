module ApplicationHelper

  # friendly_urlの生成メソッド
  def generate_friendly_url
    char_list = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
    (0...8).map { char_list[rand(char_list.length)] }.join
  end

end
