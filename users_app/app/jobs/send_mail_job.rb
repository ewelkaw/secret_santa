class SendMailJob < ApplicationJob
  queue_as :default

  def perform(secret_santa_id, user_from, generated_pdf)
    email_to = User.find_by(secret_santa_id: secret_santa_id, name: user_from).email
    SecretSantaMailer.with(email: email_to, attachment: generated_pdf).match_email.deliver_later
  end
end
