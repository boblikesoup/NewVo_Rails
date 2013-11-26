Paperclip::interpolates[:post_id] = proc do |attachment, style|
  attachment.instance.post_id
end
