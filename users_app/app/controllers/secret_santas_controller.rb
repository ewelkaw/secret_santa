class SecretSantasController < ApplicationController
  def create
    secret_santa_team = params[:secret_santa]
    users = params[:users]
    secret_santa = SecretSanta.create(group_name: secret_santa_team)
    users.each do |user|
      secret_santa.users.create(email: user[:email], name: user[:name])
    end

    GenerateMatchingsJob.perform_later(secret_santa.id)
    head 201
    end
end
