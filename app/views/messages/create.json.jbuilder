json.id      @message.id
json.content @message.content 
json.date    @message.created_at.strftime("%Y/%m/%d %H:%M")
json.user_name @message.user.name
json.user_avatar url_for(@message.user.avatar)
json.is_current_user @message.user == current_user ? true : false