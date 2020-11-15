## Request Duplicate
curl -X "POST" "http://127.0.0.1:8000/generate_pdf/" \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "file": "<html>\\n  <head>\\n    <title>Secret Santa</title>\\n    <meta charset=\\"utf-8\\">\\n  </head>\\n  <body style=\\"margin: 50px auto; width: 500px; padding: 30px; background-color: #fafafa;\\">\\n    <header>\\n      <h1 style=\\"text-align: center; margin: 50px auto;\\">Ho Ho Ho</h1>\\n      <h3 style=\\"text-align: center; margin: 50px auto;\\">You have been added to Secret Santa Group Name</h3>\\n    </header>\\n\\n    <div>\\n      <p style=\\"width: 500px; margin: 20px auto; padding: 30px;\\n    background-color: #F1F0F0;\\">\\n        Hi <strong>Annie</strong>,<br>\\n        someone has added you to <strong>Secret Santa Group Name</strong> and the person you will buy a gift this year is <strong>Tom</strong>.<br> \\n        <br>\\n        Have fun looking for something fo him and Merry Christmas,<br>\\n        <strong>Secret Santa</strong> \\n      </p>\\n    </div>\\n\\n  </body>\\n</html>"
}'
