class GenerateMatchingsJob < ApplicationJob
  queue_as :default

  def perform(secret_santa_id)
    users_names = User.where(secret_santa_id: secret_santa_id).pluck(:name)
    options = {
      body: {"names" => users_names}.to_json
    }

    response = HTTParty.post('http://localhost:8090/generate', options)
    pp JSON.parse(response.body)
    data_matches = JSON.parse(response.body)

    data_matches["names"].each do |match|
      matched_user = User.find_by(secret_santa_id: secret_santa_id, name: match["to"])
      User.find_by(secret_santa_id: secret_santa_id, name: match["from"]).update_attribute(:matched_user_id, matched_user.id)

      html =<<EOF 
          <html>
        <head>
          <title>Secret Santa</title>
          <meta charset="utf-8">
        </head>
        <body style="margin: 50px auto; width: 500px; padding: 30px; background-color: #fafafa;">
          <header>
            <h1 style="text-align: center; margin: 50px auto;">Ho Ho Ho</h1>
            <h3 style="text-align: center; margin: 50px auto;">You have been added to Secret Santa Group Name</h3>
          </header>

          <div>
            <p style="width: 500px; margin: 20px auto; padding: 30px;
          background-color: #F1F0F0;">
              Hi <strong>#{match["from"]}</strong>,<br>
              someone has added you to <strong>Secret Santa Group Name</strong> and the person you will buy a gift this year is <strong>#{match["to"]}</strong>.<br> 
              <br>
              Have fun looking for something fo him and Merry Christmas,<br>
              <strong>Secret Santa</strong> 
            </p>
          </div>

        </body>
      </html>
EOF

      options = {
        body: {"file" => html}.to_json
      }

      response = HTTParty.post('http://localhost:8000/generate_pdf', options)
      email_to = User.find_by(secret_santa_id: secret_santa_id, name: match["from"]).email
      pp email_to
      SecretSantaMailer.with(email: "a@a.com", attachment: response.body).match_email.deliver_later
    end
  end
end
