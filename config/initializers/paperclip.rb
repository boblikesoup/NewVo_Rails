Paperclip::interpolates :post_id do |attachment, style|
  attachment.instance.post_id
end

Paperclip::interpolates :user_id do |attachment, style|
  attachment.instance.user_id
end