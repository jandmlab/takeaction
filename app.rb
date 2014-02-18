require 'sinatra'
require 'slim'
require './lib/app_data'

configure { set :server, :puma }

class ActionMenu < Sinatra::Base
  
  set :app_name, 'TAKE ACTION'
  set :app_description, 'Action menu generator for Launch Center Pro'

  get '/' do
    @title = title
    slim :index
  end

  post '/your-menu' do
    @title = title 'Your menu'
    urls = gather_urls
    @menu_url = build_menu_url(urls)
    slim :your_menu
  end

  def gather_urls
    urls = []
    8.times do |i|
      urls << build_url_for_app_at_index(i) unless params["app#{i}"].empty?
    end
    urls
  end

  def build_menu_url(urls)
    menu_url = "javascript:t=document.title.replace(/\\|/g, '-');window.location='launch://?url='+encodeURIComponent('launch://?url=[list:URL: '+location.href+'|"
    menu_url += urls.join('|')
    menu_url += "]')"
  end

  def build_url_for_app_at_index(i)
    app_data = AppData.new(i, params)
    app_data.url
  end

  helpers do
    def title(page_description = nil)
      page_description ||= settings.app_description
      "#{page_description} | #{settings.app_name}"
    end
  end

end