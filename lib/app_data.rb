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
      twodays: "2 Days=twodays://x-callback-url/add?page={{#{twodayspage}}}&text={{#{twodaysprefix}'+t+': '+l+'}}",
      buffer: "Buffer=bufferapp://?u={{'+l+'}}",
      cleanlinks: "Clean Link=clean-links://x-callback-url/clean?url={{'+l+'}}",
      clear: "Clear=clearapp://task/create?listName={{#{clearlist}}}&listPosition=&taskName={{#{clearprefix}'+t+': '+l+'}}&taskPosition=Top",
      commandcipad: "Command-C to iPad=command-c://x-callback-url/copyText?text={{'+window.location+'}}&x-success={{'+window.location+'}}&x-failure={{'+window.location+'}}&deviceName={{#{commandcipad}}}",
      commandciphone: "Command-C to iPhone=command-c://x-callback-url/copyText?text={{'+window.location+'}}&x-success={{'+window.location+'}}&x-failure={{'+window.location+'}}&deviceName={{#{commandciphone}}}",
      commandcmac: "Command-C to Mac=command-c://x-callback-url/copyText?text={{'+window.location+'}}&x-success={{'+window.location+'}}&x-failure={{'+window.location+'}}&deviceName={{#{commandcmac}}}",
      drafts: "Drafts=drafts://x-callback-url/create?text={{'+l+'}}",
      draftscustom: "#{customdraftsactionname}=drafts://x-callback-url/create?text={{'+l+'}}&action={{#{customdraftsactionname}}}",
      due: "Due=due://x-callback-url/add?title={{#{dueprefix}'+t+': '+l+'}}",
      editorial: "Editorial=editorial://?command=SimpleURL&input={{'+l+'}}",
      fantastical: "Fantastical=fantastical2://parse?sentence={{#{fantasticalprefix}'+t+': '+l+'}}&reminder=1",
      instapaper: "Instapaper=x-callback-instapaper://x-callback-url/add?url={{'+l+'}}",
      omnifocus: "OmniFocus=omnifocus:///add?name={{#{omnifocusprefix}'+t+'}}&note={{'+l+'}}",
      onepassword: "Open in 1Password=op{{'+l+'}}",
      pincase: "Pincase=pincaseapp://x-callback-url/add?url={{'+l+'}}&title={{'+t+'}}&noui=yes&later=no",
      pinner: "Pinner=pinner://bookmark?href={{'+l+'}}&title={{'+t+'}}",
      pinswift: "Pinswift=pinswift://x-callback-url/add?url={{'+l+'}}",
      pushpin: "Pushpin=pushpin://x-callback-url/add?url={{'+l+'}}&title={{'+t+'}}",
      pythonista: "#{pythonistascriptname}=pythonista://{{#{pythonistascriptname}}}?action=run&args={{'+l+'}}",
      riposte: "Riposte=riposte://x-callback-url/createNewPost?text={{'+t+'}} {{'+l+'}}",
      taskagent: "Task Agent=taskagent://x-callback-url/action?list={{#{taskagentlist}}}&task={{#{taskagentprefix}'+t+': '+l+'}}",
      texttool: "Encode Link=texttool://x-callback-url/transform?text={{'+l+'}}&method=encode&x-success={{launch:}}",
      things: "Things=things:add?title={{#{thingsprefix}'+t+'}}&notes={{'+l+'}}",
      tumblr: "Tumblr Link Post=tumblr://x-callback-url/link?title={{'+t+'}}&url={{'+l+'}}",
      tweetbot: "Tweetbot=tweetbot://{{#{twitterhandle}}}/post?text={{'+l+'}}"
    }
  end
end