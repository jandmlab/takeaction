class AppData
  FIELDS = [
    :app, :emoji, :twitterhandle, :clearlist, :commandcmac, 
    :commandciphone, :commandcipad, :customdraftsactionname, 
    :pythonistascriptname, :twodayspage, :taskagentlist, 
    :twodaysprefix, :clearprefix, :dueprefix, :fantasticalprefix, 
    :omnifocusprefix, :taskagentprefix, :thingsprefix
  ]
  
  FIELDS.each do |field|
    attr_accessor field
  end
  
  def initialize(i, params)
    FIELDS.each do |field|
      self.send("#{field}=", params["#{field}#{i}"])
    end
  end
  
  def url
    "#{emoji} #{url_schemes[app.to_sym]}"
  end
  
  private
  
  def url_schemes
    {
      twodays: "2 Days=twodays://x-callback-url/add?page={{#{twodayspage}}}&text={{#{twodaysprefix}'+t+': '+location.href+'}}",
      buffer: "Buffer=bufferapp://?u={{'+location.href+'}}",
      cleanlinks: "Clean Link=clean-links://x-callback-url/clean?url={{'+location.href+'}}",
      clear: "Clear=clearapp://task/create?listName={{#{clearlist}}}&listPosition=&taskName={{#{clearprefix}'+t+': '+location.href+'}}&taskPosition=Top",
      commandcipad: "Command-C to iPad=command-c://x-callback-url/copyText?text={{'+window.location+'}}&x-success={{'+window.location+'}}&x-failure={{'+window.location+'}}&deviceName={{#{commandcipad}}}",
      commandciphone: "Command-C to iPhone=command-c://x-callback-url/copyText?text={{'+window.location+'}}&x-success={{'+window.location+'}}&x-failure={{'+window.location+'}}&deviceName={{#{commandciphone}}}",
      commandcmac: "Command-C to Mac=command-c://x-callback-url/copyText?text={{'+window.location+'}}&x-success={{'+window.location+'}}&x-failure={{'+window.location+'}}&deviceName={{#{commandcmac}}}",
      drafts: "Drafts=drafts://x-callback-url/create?text={{'+location.href+'}}",
      draftscustom: "#{customdraftsactionname}=drafts://x-callback-url/create?text={{'+location.href+'}}&action={{#{customdraftsactionname}}}",
      due: "Due=due://x-callback-url/add?title={{#{dueprefix}'+t+': '+location.href+'}}",
      fantastical: "Fantastical=fantastical2://parse?sentence={{#{fantasticalprefix}'+t+': '+location.href+'}}&reminder=1",
      instapaper: "Instapaper=x-callback-instapaper://x-callback-url/add?url={{'+location.href+'}}",
      omnifocus: "OmniFocus=omnifocus:///add?name={{#{omnifocusprefix}'+t+'}}&note={{'+location.href+'}}",
      onepassword: "Open in 1Password=op'+location.href+'",
      pincase: "Pincase=pincaseapp://x-callback-url/add?url={{'+location.href+'}}&title={{'+t+'}}&noui=yes&later=no",
      pinner: "Pinner=pinner://bookmark?href={{'+location.href+'}}&title={{'+t+'}}",
      pinswift: "Pinswift=pinswift://x-callback-url/add?url={{'+location.href+'}}",
      pushpin: "Pushpin=pushpin://x-callback-url/add?url={{'+location.href+'}}&title={{'+t+'}}",
      pythonista: "#{pythonistascriptname}=pythonista://{{#{pythonistascriptname}}}?action=run&args={{'+location.href+'}}",
      riposte: "Riposte=riposte://x-callback-url/createNewPost?text=[{{'+t+'}}]({{'+location.href+'}})",
      taskagent: "Task Agent=taskagent://x-callback-url/action?list={{#{taskagentlist}}}&task={{#{taskagentprefix}'+t+': '+location.href+'}}",
      texttool: "Encode Link=texttool://x-callback-url/transform?text={{'+location.href+'}}&method=encode&x-success={{launch:}}",
      things: "Things=things:add?title={{#{thingsprefix}'+t+'}}&notes={{'+location.href+'}}",
      tumblr: "Tumblr Link Post=tumblr://x-callback-url/link?title={{'+t+'}}&url={{'+location.href+'}}",
      tweetbot: "Tweetbot=tweetbot://{{#{twitterhandle}}}/post?text={{'+location.href+'}}"
    }
  end
end