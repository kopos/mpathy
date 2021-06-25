# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def breadcrumbs
    separator = '&nbsp;&nbsp;>>&nbsp;&nbsp;'
    html = ''
    html << link_to('Bluetooth Campaign Manager', '/')
    html << separator
    html << link_to("#{@controller.controller_name.capitalize}", :controller => @controller.controller_name)
    
    if !['show', 'index'].include?@controller.action_name      
      html << separator
      html << @controller.action_name.capitalize
    end
    
    content_tag('h2',html)
  end
  
  def campaign_menu(links)
    link_html = ''
    
    links.each do |link|
			if link[:url].nil?
				link_html << content_tag('li', 
					link_to(link[:text], 
						{:controller => 'campaigns', :action => link[:action], :id => @campaign.id}, 
						:class => @controller.action_name == link[:action]? "active" :''),
						:class => 'level2')
			else
				link_html << content_tag( 'li', 
					link_to(link[:text], 
						link[:url], 
						:class => @controller.controller_name == link[:action]? "active":''), 
					:class=>'level2')
			end
		end
    content_tag('div', content_tag('ul', link_html))
  end  				  
	
	def td_link_get_icon(obj)
		"<td width=32 align=center>"+link_to(image_tag('asset_get.png',   :title => 'Download'), obj)+"</td>"
	end

	def td_link_show_icon(obj)
		"<td width=32 align=center>"+link_to(image_tag('asset_go.png',   :title => 'Show'), obj)+"</td>"
	end
	
	def td_link_edit_icon(url)
		'<td width=32 align=center>'+ link_to( image_tag('asset_edit.png', :title => 'Edit'), url)+'</td>'
	end
	
	def td_link_delete_icon(obj)
		'<td width=32 align=center>'+ link_to( image_tag('asset_delete.png', :title => 'Delete'), obj, :confirm => 'Are you sure?', :method => :delete) + '</td>'
	end
		
	def new_obj_link(obj, label = "")
		humanized = label.nil? ?  obj.capitalized : label
	  new_text  = "Create New #{humanized}"
	
		content_tag('table',
			content_tag('tr',
				content_tag('th',
					"#{new_text} &nbsp;&nbsp;" + link_to(image_tag('package_add.png', :title => new_text), eval("new_#{obj.downcase}_path"))
				)
			),
			:class => "basic-table")
	end

	def add_obj_link(url, obj, to)
		humanized = obj.capitalize
	  new_text  = "Add #{humanized} to #{to.capitalize}"
	
		content_tag('table',
			content_tag('tr',
				content_tag('th',
					"#{new_text} &nbsp;&nbsp;" + link_to(image_tag('package_add.png', :title => new_text), eval("new_#{url.downcase}_path"))
				)
			),
			:class => "basic-table")
	end
	
end
