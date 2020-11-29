class GeneratePdfJob < ApplicationJob
  queue_as :default

  def perform(secret_santa_id, user_from, user_to)
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
              Hi <strong>#{user_from}</strong>,<br>
              someone has added you to <strong>Secret Santa Group Name</strong> and the person you will buy a gift this year is <strong>#{user_to}</strong>.<br> 
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
    SendMailJob.perform_later(secret_santa_id, user_from, response.body)
  end
end
