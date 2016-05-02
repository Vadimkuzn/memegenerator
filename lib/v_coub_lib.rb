class VCoubLib
#-----------------------------------------------------------------------
# $current_user (authenticated)

#  current_user.name
#  current_user.id
#  current_user.provider
#  current_user.uid
#  current_user.auth_token
#  current_user.created_at
#  current_user.updated_at

#-----------------------------------------------------------------------
 def get_current_user_api()
  if $current_user
   api = CoubApi::Client.new($current_user.auth_token)
  else
   nil
  end
 end
#-----------------------------------------------------------------------
 def get_shortcode(url)
  arr = url.scan(/\w+/)
  arr[-1]
 end
#-----------------------------------------------------------------------
 def get_coub(url)
  get_current_user_api().get("coubs/#{get_shortcode(url)}")
 end
#-----------------------------------------------------------------------
 def get_coub_id(url)
  get_current_user_api().get("coubs/#{get_shortcode(url)}")['id']
 end
#-----------------------------------------------------------------------
 def does_like?(url)
  if $current_user
   api = get_current_user_api()
   begin
    ar  = api.get('action_subjects_data/coub_likes_list', id: get_coub_id(url), page: 1)
   rescue
    false
    return
   end
   chids = []
   ar['channels'].each do |ch|
    chids << ch['id']
   end
   chids.include? api.get('users/me')['current_channel']['id']
  else
   false
  end
 end

# ar:
# — page (integer) — the number of the required page;
# — total_pages (integer) — the number of all pages;

# — channels (array) — the array of channel small JSONs:

# — id (integer) — the identifier of the channel;
# — permalink (string) — the permalink of the channel;
# — description (string) — the description of the channel;
# — title (string) — the title of the channel;
# — i_follow_him (boolean) — whether this channel is followed by you;
# — followers_count (integer) — the number of channel's followers;
# — following_count (integer) — the number of channels that the channel follows;
# — avatar_versions (JSON) — the JSON object that contains data about channel's thumbnail images:
# — template (string) — the template of the URLs to the files specified in this JSON;
# — versions (array) — the array of strings that refer to available image versions: — medium — 48x48 pixels;
# — medium_2x — 96x96 pixels;
# — profile_pic — 160x160 pixels;
# — profile_pic_2x — 320x320 pixels;
# — profile_pic_new — 110x110 pixels;
# — profile_pic_new_2x — 220x220 pixels;
# — tiny — 32x32 pixels;
# — tiny_2x — 64x64 pixels;
# — small — 38x38 pixels;
# — small_2x — 76x76 pixels;
# — ios_large — 140x140 pixels;
# — ios_small — 70x70 pixels.

#-----------------------------------------------------------------------
 def get_likers_list(url)
  if $current_user
   api = get_current_user_api()
   begin
    ar  = api.get('action_subjects_data/coub_likes_list', id: get_coub_id(url), page: 1)
   rescue
    nil
    return
   end
   arch = ar['channels']
   churls = []
   arch.each do |ch|
    churl = []
    churl  << ch["title"]
    churl  << "http://coub.com/#{ch['permalink']}"
    churl  << ch["id"]
    churls << churl
   end
   churls
  else
   nil
  end
 end

# ar:
# — page (integer) — the number of the required page;
# — total_pages (integer) — the number of all pages;

# — channels (array) — the array of channel small JSONs:

# — id (integer) — the identifier of the channel;
# — permalink (string) — the permalink of the channel;
# — description (string) — the description of the channel;
# — title (string) — the title of the channel;
# — i_follow_him (boolean) — whether this channel is followed by you;
# — followers_count (integer) — the number of channel's followers;
# — following_count (integer) — the number of channels that the channel follows;
# — avatar_versions (JSON) — the JSON object that contains data about channel's thumbnail images:
# — template (string) — the template of the URLs to the files specified in this JSON;
# — versions (array) — the array of strings that refer to available image versions: — medium — 48x48 pixels;
# — medium_2x — 96x96 pixels;
# — profile_pic — 160x160 pixels;
# — profile_pic_2x — 320x320 pixels;
# — profile_pic_new — 110x110 pixels;
# — profile_pic_new_2x — 220x220 pixels;
# — tiny — 32x32 pixels;
# — tiny_2x — 64x64 pixels;
# — small — 38x38 pixels;
# — small_2x — 76x76 pixels;
# — ios_large — 140x140 pixels;
# — ios_small — 70x70 pixels.

#-----------------------------------------------------------------------
 def get_followers_list(url)
  if $current_user
   api = get_current_user_api()
   begin
    ar  = api.get('action_subjects_data/followings_list', id: get_coub_id(url), page: 1)
   rescue
    nil
    return
   end
   arch = ar['channels']
   churls = []
   arch.each do |ch|
    churl = []
    churl  << ch["title"]
    churl  << "http://coub.com/#{ch['permalink']}"
    churl  << ch["id"]
    churls << churl
   end
   churls
  else
   nil
  end
 end
#-----------------------------------------------------------------------
 def get_current_user_info()
  if $current_user
   get_current_user_api().get('users/me')
  else
   nil
  end
 end
# — id (integer) — the identifier of the user;
# — permalink (string) — the permalink of the user;
# — name (string) — the name of the user;
# — sex (string) — the gender of the user, can be set to one of the following values: male, female, unspecified.
# — city (string) — the city that the user specified in the profile;
# — current_channel (JSON) — the channel small JSON relates to the channel that currently chosen by the user;
# — created_at (UNIX-time) — the time when the user profile was created;
# — updated_at (UNIX-time) — the time of the user profile's last update;
# — api_token (string) — the current access token.
#-----------------------------------------------------------------------
 def get_current_user_channel()
  inf = get_current_user_info()
  inf["current_channel"]
 end
#-----------------------------------------------------------------------
 def get_current_user_channel_id()
  ch = get_current_user_channel()
  ch["id"]
 end
#-----------------------------------------------------------------------
 def does_follow?(url)
  if $current_user
   api = get_current_user_api()
   begin
    ar  = api.get('action_subjects_data/followings_list', id: get_coub_id(url), page: 1)
   rescue
    false
    return
   end
   chids = []
   ar['channels'].each do |ch|
    chids << ch['id']
   end
   chids.include? api.get('users/me')['current_channel']['id']
  else
   false
  end
 end
#-----------------------------------------------------------------------
end
