## Request
curl -X "POST" "http://localhost:8090/generate" \
     -H 'Content-Type: text/plain; charset=utf-8' \
     -d $'{
  "names": [
    "Ann",
    "Ed",
    "Monica",
    "Zoe",
    "Frank"
  ]
}'

