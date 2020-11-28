class SecretSantaMailer < ApplicationMailer
  default from: 'secretsanta@merry_christmas.com'
 
  def match_email
    @email = params[:email]
    @attachment  = params[:attachment]
    attachments['secret_santa_mail.pdf'] = {
      mime_type: 'application/pdf',
      encoding: 'base64',
      content: @attachment
    }
    mail(to: @email, subject: 'Ho Ho Ho, it is Secret Santa!')
  end
end
