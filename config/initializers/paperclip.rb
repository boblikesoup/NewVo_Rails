Paperclip::interpolates :post_id do |attachment, style|
  attachment.instance.post_id
end

# Paperclip::interpolates :uid do |attachment, style|
#   attachment.instance.uid
# end