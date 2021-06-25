class ReportsController < ApplicationController
  before_filter :check_and_load_campaign

  class Styling
    def self.corporate_blue
    end

    def self.load file_name
      # load a css file from the public/stylesheets folder
      # or 
      # as a monkey hack to the Styling class in the lib folder
      #
      # contains sections required for that chart type:
      #   graph - title, axis, color

      # sample css
      # title     { color: '#aabbcc', size: 20, text-align: center }
      # axis.x    { base : '#818d9d', step: '#f0f0f0' }
      # axis.y    { base : '#818d9d', step: '#f0f0f0' }
      # axis.y2   { base : '#818d9d' }
      # legend.x  { size : 12, color: '#819c9c' }
      # legend.y  { size : 12, color: '#819c9c' }
      # legend.y2 { size : 12, color: '#819c9c' }
      #
      # dot.d1    { line-width: 2, dot-size: 3, color : red }
      # hollow.h1 { line-width: 2, circle-size: 3, color : red }
    end
  end

  class OpenFlashChart
    def create(w, h, data_url, cross_domain, swf_url)
    end
  end
  
  def prototype
    Graph.new do |g|
      g.title   'Downloads vs Scoping'
      g.styling 'corporate_blue'
      g.x       'My IRC Server time', :labels => 'Campaign.get_days()'
      g.y       'Max Users', :extents => 'auto' || '3..600', :steps => 5
      g.y2      'Free RAM',  :extents => '0..400'

      g.data    :styling => 'dot.d1', :label => 'Users', :values => 'Campaign.get_users()'
      g.data    :styling => 'hollow.h1', :label => 'Users', :values => 'Campaign.get_users()'
      g.data    :styling => 'dot.d1', :label => 'Users', :values => 'Campaign.get_users()'
    end   
  end

  def view
    data_url = @campaign.nil? ? "/reports/data": "/campaigns/#{params[:campaign_id]}/reports/data"
    swf_url  = '/'
    @graph   = open_flash_chart_object(600,300, data_url, true, swf_url)
  end

  def data
    colors  = { :legend => '#164166', 
                :axis   => '#818D9D', 
                :bg     => '#FFFFFF',
                :title  => '#7E97A6',
                :step_x => '#f0f0f0'}

    g = Graph.new
    g.title( 'Downloads vs Scoping', "{color: #{colors[:title]}; font-size: 20; text-align: center}" )
    g.set_bg_color(colors[:bg])

    # x axis
    g.set_x_axis_color(colors[:axis], colors[:step_x] )
    g.set_x_legend( 'My IRC Server', 12, colors[:legend] )
    tmp = []
    (0..25).to_a.each do |x|
            tmp << "#{x}:00"
    end
    g.set_x_labels(tmp)
    g.set_x_label_style(10, colors[:legend], 0, 3, colors[:axis] )

    # left y data
    g.set_data([289,198,143,126,98,96,124,164,213,238,256,263,265,294,291,289,306,341,353,353,402,419,404,366,309])
    g.line_dot( 2, 4, colors[:axis], 'Max Users', 10 )
    g.set_y_max(600)
    g.set_y_axis_color( colors[:axis], '#ADB5C7' )
    g.set_y_legend( 'Max Users', 12, colors[:legend] )

    # right y data
    g.set_data([698,1101,1324,1396,1568,1571,1496,1349,1140,1045,966,926,906,754,766,757,672,510,431,436,227,533,566,744,1004])
    g.line_hollow( 2, 4, colors[:legend], 'Free Ram', 10 )
    g.attach_to_y_right_axis(2)
    g.set_y_right_max(1700)
    g.y_right_axis_color(colors[:legend])
    g.set_y_legend_right( 'Free Ram (MB)' ,12 , colors[:legend] )

    g.set_data([98,101,134,196,58,57,96,13,140,145,96,26,6,74,66,77,72,50,43,36,27,33,56,74,100])
    g.line_dot( 2, 3, '#006600', 'Free Rambo', 10 )
    g.attach_to_y_right_axis(3)

    g.set_y_label_steps(5)
   
    
    render :text => g.render
  end

end
