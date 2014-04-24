module UsersHelper
  def user_posts_list_item(appended_classes, options)
    # if appended_classes.include?("table_head")
    if true
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
        <td class="responses">
          <a href="#{user_ad_responses_url(current_user.id, options[:ad_id])}">
            #{options[:responses]}
          </a>
        </td>
      </tr>
    HTML
  end

  def account_header(user)
    <<-HTML.html_safe
    <header class="user-dashboard-header">
      <h1>#{user.username}'s Dashboard : Postings </h1>
      <nav class="user-dashboard">
        <a class="user-dashboard-nav" href="#{user_ads_url(user)}">Postings</a>
        <a class="user-dashboard-nav" href="#{user_url(user)}">Settings</a>
        <a class="user-dashboard-nav" href="#{user_notifications_url(user)}">
          Notifications
        </a>
      </nav>
    </header>
    HTML
  end
end
