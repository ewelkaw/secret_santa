# secret_santa

Secret santa generator for christmas fun XD 

Project consist of three services:
1. Secret santa generator (GO)

```bash
~/secret_santa/secret_santa_generator$ go run generator.go
~/secret_santa/secret_santa_generator$ rerun -p "*.go" go run generator.go
```

**Working with servis (test_secret_santa_gen_request.sh)**
```bash
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
```

2. Users app (RUBY)
```bash
~/secret_santa/user_app$ rails s
```

3. PDF generator (PYTHON)

We need to install two libraries:
- http://macappstore.org/wkhtmltopdf/
- pdfkit

docs: `http://127.0.0.1:8000/docs`

```bash
~/secret_santa/pdf_generator$ uvicorn main:app --reload
```