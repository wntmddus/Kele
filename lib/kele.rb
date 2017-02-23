require_relative "kele/roadmap"
require_relative "kele/message"
require "httparty"
require "json"

class Kele
  include HTTParty
  include Roadmap
  include Message

  def initialize(email, password)
    response = self.class.post(base_api_endpoint("sessions"), body: { "email": email, "password": password })
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get(base_api_endpoint("users/me"), headers: { "authorization" => @auth_token })
    @user_data = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get(base_api_endpoint("mentors/#{mentor_id}/student_availability"), headers: { "authorization" => @auth_token })
    @user_data = JSON.parse(response.body)
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
    response = self.class.post(base_api_endpoint("checkpoint_submissions"), body: { "enrollment_id": current_enrollment["id"], "checkpoint_id": checkpoint_id, "assignment_branch": assignment_branch, "assignment_commit_link": assignment_commit_link, "comment": comment})
  end

  private

  def base_api_endpoint(end_point)
    "https://www.bloc.io/api/v1/#{end_point}"
  end
end
