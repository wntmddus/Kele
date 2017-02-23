module Message
  def get_message(messagenumber)
    response = self.class.get(base_api_endpoint("message_threads/#{messagenumber}"), headers: { "authorization" => @auth_token })
    @get_message = JSON.parse(response.body)
  end

  def create_message(recipient_id, subject, message)
    response = self.class.post(base_api_endpoint("messages"), body: { "recipient_id": recipient_id, "subject": subject, "stripped-text": message}, headers: { "authorization" => @auth_token })
  end
end
