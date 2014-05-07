module AdsHelper

  def ads_list(ads)
    output = ""
    ads.each do |ad|
      output += <<-HTML.html_safe
      <tr class="user-posts-list">
        <td class="status">Active</td>
        <td class="manage"><a href="#{ad_url(ad)}/repost">repost</a></td>
        <td class="title">
          <a href="#{subcat_ad_url(ad.subcat, ad)}">
            #{h(ad.title)}
          </a>
        </td>
        <td class="region"><strong>#{h(ad.region)}</strong></td>
        <td class="category">#{h(ad.subcat.title)}</td>
        <td class="posted-date">#{h(ad.created_at)}</td>
        <td class="responses">
          <a href="#{user_ad_responses_url(current_user, ad)}">
            #{ad.responses_count}
          </a>
        </td>
      </tr>
    HTML
    end
    output.html_safe
  end
  
  def find_featured_option(subcat, ad, ord)
    if(ord == 1)
      feature_class = subcat.featured_option_class1
    elsif(ord == 2)
      feature_class = subcat.featured_option_class2
    end
    return nil unless feature_class
    case feature_class.value_type
    when "IntegerOption"
      ad.integer_options.where("option_class_id = ?", feature_class.id).first
    when "StringOption"
      ad.string_options.where("option_class_id = ?", feature_class.id).first
    when "BooleanOption"
      ad.boolean_options.where("option_class_id = ?", feature_class.id).first
    when "DateOption"
      ad.date_options.where("option_class_id = ?", feature_class.id).first
    end
  end
end
