module ApplicationHelper
  def auth_token
    <<-HTML.html_safe
    <input type="hidden"
    name="authenticity_token"
    value="#{form_authenticity_token}">
    HTML
  end

  def set_form_method(method)
    <<-HTML.html_safe
    <input type="hidden"
    name="_method"
    value="#{method}">
    HTML
  end

  def delete_session_link
    <<-HTML.html_safe
			<form class="sign-out"
      action="#{session_url}" method="post">
        #{set_form_method('DELETE')}
        #{auth_token}
			  <input class="" type="submit" value="sign out">
			</form>
    HTML
  end

  def bracket_link(text, url, action, appended_classes = [])
    #should switch it so that it doesn't submit a form when going a 'GET'
    classes = appended_classes.join(" ").html_safe #is html_safe necessary here?

    action = action.upcase
    if (action == 'GET')

       <<-HTML.html_safe
      <div class="bracket-link-wrap #{classes}">
        <a class="bracket-link" href="#{url}">#{text}</a>
      </div>
       HTML

    else

      <<-HTML.html_safe
  			<form class="bracket-link-wrap #{classes}"
        action="#{url}" method="post">
          #{set_form_method(action)}
          #{auth_token}
  			  <input class="bracket-link" type="submit" value="#{text}">
  			</form>
      HTML
    end
  end

  def form_input(label_text, type, id, name, value, div_class =  "", input_appends = "")
    value = true if type == "checkbox"
    if(input_appends) 
      input_appends += "min=0".html_safe if type == "number"
      input_appends += "class=date".html_safe if type == "date"
    end
    <<-HTML.html_safe
      <div class="input #{div_class}">
        <label for="#{id}">#{label_text}</label>
        <input type="#{type}" id="#{id}"
          name="#{name}" value="#{value}" #{input_appends}>
        </input>
      </div>
    HTML
  end

  def form_submit(text, size = "medium")
    <<-HTML.html_safe
     	<div class="submit slick-button #{size}">
     		  <input type="submit" value="#{text}">
     	</div>
    HTML
  end
  
  def header(header_options)
    header_options ||= {}
    header_append_html = ""
    if header_options[:head_link_text].present?
      header_options[:head_link_text].each_index do |i|
        header_append_html += <<-HTML.html_safe
          <li>
            <a href="#{ header_options[:head_link_url][i] }">
              #{ header_options[:head_link_text][i] }
            </a>
          </li>
        HTML
      end
    end 
    
    <<-HTML.html_safe
    <header class="page-header">
      
      <nav class="header clearfix">
        <ul class="header-path-links left clearfix arrow">
          <li class="first">
            <a href="#{root_url}">the krishlist</a>
          </li>
          <li>
            <a href="#{root_url}">new york city</a>
          </li>
          
          #{header_append_html}
        </ul>  
        
        <ul class="header-path-links right">

          #{header_user_options}
        </ul>
      </nav>
    </header>
    HTML
  end

  def header_user_options
    if(signed_in?)
      <<-HTML.html_safe
      <li>
				<a href=#{user_ads_url(current_user)}>
					account
				</a>
			</li>
      <li>
				<a href=#{new_ad_url}>
					post
				</a>
			</li>
      <li>
				#{delete_session_link}
			</li>
      HTML
    else
      <<-HTML.html_safe
      <li>
				<a href=#{new_session_url}>
					sign in
				</a>
			</li>
      HTML
    end
  end

  def position_classes(category_title)
    position_class = {
      "community" => "high short",
      "personals" => "high long",
      "housing" => "high long",
      "for sale"  => "high short",
      "services" => "high short",
      "jobs"  => "high long",
      "gigs"  => "low short" 
    }
    
    position_class[category_title]
  end

end


