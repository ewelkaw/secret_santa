class GenerateMatchingsJob < ApplicationJob
  queue_as :default

  def perform(secret_santa_id)
    users_names = User.where(secret_santa_id: secret_santa_id).pluck(:name)
    options = {
      body: {"names" => users_names}.to_json
    }

    pp options
      
    response = HTTParty.post('http://localhost:8090/generate', options)
    pp JSON.parse(response.body)
    data_matches = JSON.parse(response.body)

    # byebug

    data_matches["names"].each do |match|
      matched_user = User.find_by(secret_santa_id: secret_santa_id, name: match["to"])
      User.find_by(secret_santa_id: secret_santa_id, name: match["from"]).update_attribute(:matched_user_id, matched_user.id)
    end
  end
end
