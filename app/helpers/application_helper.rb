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
    <<-HTML.html_safe
      <div class="input #{div_class}">
        <label for="#{id}">#{label_text}</label>
        <input type="#{type}" id="#{id}"
          name="#{name}" value="#{value}" #{input_appends}>
        </input>
      </div>
    HTML
  end

  def form_submit(text)
    <<-HTML.html_safe
     	<div class="submit">
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
        > <a href="#{ header_options[:head_link_url][i] }">
            #{ header_options[:head_link_text][i] }
          </a>
        HTML
      end
    end 
    
    <<-HTML.html_safe
    <header class="all-pages">
      
      <nav class="header clearfix">
        <ul class="header-path-links">
          <a href="#{root_url}">krishList</a>
          >
          <a href="#{root_url}">new york city</a>
          
          #{header_append_html}
        </ul>  
        
        <div class="bracket-link-container">

          #{
          if(signed_in?)
              bracket_link('account', user_ads_url(current_user), 'GET') + 
              bracket_link('post', new_ad_url, 'GET') + 
              bracket_link('sign out', session_url, 'DELETE', ["sign-out"])
          else
    	  	    bracket_link('sign in', new_session_url, 'GET')
          end
           }
        </div>
      </nav>
    </header>
    HTML
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


