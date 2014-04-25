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
end
