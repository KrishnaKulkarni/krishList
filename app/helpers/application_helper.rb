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

  def form_input(label_text, type, id, name, value)
    <<-HTML.html_safe
      <div class="input">
        <label for="#{id}">#{label_text}</label>
        <input type="#{type}" id="#{id}"
          name="#{name}" value="#{value}">
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

end
