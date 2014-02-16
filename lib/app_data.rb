class AppData
  FIELDS = [:app, :emoji, :twitterhandle, :clearlist, :commandcmac, :commandciphone, :commandcipad, :customdraftsactionname, :pythonistascriptname]
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
      cleanlinks: "Clean Link=clean-links://x-callback-url/clean?url={{'+location.href+'}}",
      clear: "Clear=clearapp://task/create?listName={{#{clearlist}}}&listPosition=&taskName={{Check out '+location.href+'}}&taskPosition=Top",
      commandcipad: "Command-C to iPad=command-c://x-callback-url/copyText?text={{'+window.location+'}}&x-success={{'+window.location+'}}&x-failure={{'+window.location+'}}&deviceName={{#{commandcipad}}}",
      commandciphone: "Command-C to iPhone=command-c://x-callback-url/copyText?text={{'+window.location+'}}&x-success={{'+window.location+'}}&x-failure={{'+window.location+'}}&deviceName={{#{commandciphone}}}",
      commandcmac: "Command-C to Mac=command-c://x-callback-url/copyText?text={{'+window.location+'}}&x-success={{'+window.location+'}}&x-failure={{'+window.location+'}}&deviceName={{#{commandcmac}}}",
      drafts: "Drafts=drafts://x-callback-url/create?text={{'+location.href+'}}",
      draftscustom: "#{customdraftsactionname}=drafts://x-callback-url/create?text={{'+location.href+'}}&action={{#{customdraftsactionname}}}",
      fantastical: "Reminder=fantastical2://parse?sentence={{'+location.href+'}}&reminder=1",
      instapaper: "Instapaper=x-callback-instapaper://x-callback-url/add?url={{'+location.href+'}}",
      onepassword: "Open in 1Password=op'+location.href+'",
      pincase: "Pincase=pincaseapp://x-callback-url/add?url={{'+location.href+'}}&title={{'+document.title+'}}&noui=yes&later=no",
      pinner: "Pinner=pinner://bookmark?href={{'+location.href+'}}&title={{'+document.title+'}}",
      pinswift: "Pinswift=pinswift://x-callback-url/add?url={{'+location.href+'}}",
      pushpin: "Pushpin=pushpin://x-callback-url/add?url={{'+location.href+'}}&title={{'+document.title+'}}",
      pythonista: "#{pythonistascriptname}=pythonista://{{#{pythonistascriptname}}}?action=run&args={{'+location.href+'}}",
      riposte: "Riposte=riposte://x-callback-url/createNewPost?text=[{{'+document.title+'}}]({{'+location.href+'}})",
      texttool: "Encode Link=texttool://x-callback-url/transform?text={{'+location.href+'}}&method=encode&x-success={{launch:}}",
      tumblr: "Tumblr Link Post=tumblr://x-callback-url/link?title={{'+document.title+'}}&url={{'+location.href+'}}",
      tweetbot: "Tweetbot=tweetbot://{{#{twitterhandle}}}/post?text={{'+location.href+'}}"
    }
  end
end