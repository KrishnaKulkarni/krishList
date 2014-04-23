module UsersHelper
  def user_posts_list_item(appended_classes, options)
    if appended_classes.include?("table_head")
      options[:manage] = "manage"
    else
      options[:manage] = <<-LINKS
          <a href="#{ad_url(options[:ad_id])}/repost">repost</a>
          <form class="delete-ad"
          action="#{ad_url(options[:ad_id])}" method="post">
            #{auth_token}
            <input type="hidden" name="_method" value="DELETE">
            <input class="delete-ad" type="submit" value="delete">
          </form>
          LINKS
    end

    <<-HTML.html_safe
      <tr class="user-posts-list #{appended_classes.join(" ")}">
        <td class="status">#{options[:status]}</td>
        <td class="manage">#{options[:manage]}</td>
        <td class="title">#{options[:title]}</td>
        <td class="region">#{options[:region]}</td>
        <td class="category">#{options[:category]}</td>
        <td class="posted-date">#{options[:posted_date]}</td>
        <td class="responses">#{options[:responses]}</td>
      </tr>
    HTML
  end
end
