require 'sinatra'
require 'slim'

configure { set :server, :puma }

class ActionMenu < Sinatra::Base

  get '/' do
    @title = 'TAKE ACTION - Action menu generator for Launch Center Pro'
    slim :index
  end

  post '/your-menu' do
    @title = 'TAKE ACTION - Your menu'

    urls = gather_urls
    @menu_url = build_menu_url(urls)

    slim :your_menu
  end

  def gather_urls
    urls = []
    6.times do |i|
      unless params["app#{i}"].empty?
        urls << build_url_for(i)
      end
    end
    urls
  end

  def build_menu_url(urls)
    menu_url = "javascript:window.location='launch://?url='+encodeURIComponent('launch://?url=[list:URL: '+location.href+'|"
    menu_url += urls.join('|')
    menu_url += "]')"
    menu_url
  end

  def build_url_for(i)
    emoji = params["emoji#{i}"]
    app = params["app#{i}"]

    twitterhandle = params["twitterhandle#{i}"]
    clearlist = params["clearlist#{i}"]
    commandcmac = params["commandcmac#{i}"]
    commandciphone = params["commandciphone#{i}"]
    commandcipad = params["commandcipad#{i}"]
    customdraftsactionname = params["customdraftsactionname#{i}"]
    pythonistascriptname = params["pythonistascriptname#{i}"]

    return_url = "#{emoji} "
    return_url += "Clear=clearapp://task/create?listName={{#{clearlist}}}&listPosition=&taskName={{Check out '+location.href+'}}&taskPosition=Top" if app == 'clear'
    return_url += "Pinswift=pinswift://x-callback-url/add?url={{'+location.href+'}}" if app == 'pinswift'
    return_url += "Pincase=pincaseapp://x-callback-url/add?url={{'+location.href+'}}&title={{'+document.title+'}}&noui=yes&later=no" if app == 'pincase'
    return_url += "Pinner=pinner://bookmark?href={{'+location.href+'}}&title={{'+document.title+'}}" if app == 'pinner'
    return_url += "Pushpin=pushpin://x-callback-url/add?url={{'+location.href+'}}&title={{'+document.title+'}}" if app == 'pushpin'
    return_url += "Reminder=fantastical2://parse?sentence={{'+location.href+'}}&reminder=1" if app == 'fantastical'
    return_url += "Open in 1Password=op'+location.href+'" if app == 'onepassword'
    return_url += "Clean Link=clean-links://x-callback-url/clean?url={{'+location.href+'}}" if app == 'cleanlinks'
    return_url += "Instapaper=x-callback-instapaper://x-callback-url/add?url={{'+location.href+'}}" if app == "instapaper"
    return_url += "Tumblr Link Post=tumblr://x-callback-url/link?title={{'+document.title+'}}&url={{'+location.href+'}}" if app == "tumblr"
    return_url += "Drafts=drafts://x-callback-url/create?text={{'+location.href+'}}" if app == 'drafts'
    return_url += "Encode Link=texttool://x-callback-url/transform?text={{'+location.href+'}}&method=encode&x-success={{launch:}}" if app == "texttool"
    return_url += "Riposte=riposte://x-callback-url/createNewPost?text=[{{'+document.title+'}}]({{'+location.href+'}})" if app == 'riposte'
    return_url += "#{customdraftsactionname}=drafts://x-callback-url/create?text={{'+location.href+'}}&action={{#{customdraftsactionname}}}" if app == 'draftscustom'
    return_url += "#{pythonistascriptname}=pythonista://{{#{pythonistascriptname}}}?action=run&args={{'+location.href+'}}" if app == 'pythonista'
    return_url += "Tweetbot=tweetbot://{{#{twitterhandle}}}/post?text={{'+location.href+'}}" if app == 'tweetbot'
    return_url += "Command-C to Mac=command-c://x-callback-url/copyText?text={{'+window.location+'}}&x-success={{'+window.location+'}}&x-failure={{'+window.location+'}}&deviceName={{#{commandcmac}}}" if app == 'commandcmac'
    return_url += "Command-C to iPhone=command-c://x-callback-url/copyText?text={{'+window.location+'}}&x-success={{'+window.location+'}}&x-failure={{'+window.location+'}}&deviceName={{#{commandciphone}}}" if app == 'commandciphone'
    return_url += "Command-C to iPad=command-c://x-callback-url/copyText?text={{'+window.location+'}}&x-success={{'+window.location+'}}&x-failure={{'+window.location+'}}&deviceName={{#{commandcipad}}}" if app == 'commandcipad'

    return_url
  end

end
