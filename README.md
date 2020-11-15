# secret_santa

Secret santa generator for christmas fun XD 

Project consist of three services:
1. Secret santa generator (GO)

```bash
~/secret_santa/secret_santa_generator$ go run generator.go
~/secret_santa/secret_santa_generator$ rerun -p "*.go" go run generator.go
```

**Example request to servis `test_secret_santa_gen_request.sh`**


2. Users app (RUBY)
```bash
~/secret_santa/user_app$ rails s
```

**Example request to servis `test_secret_santa_main_request.sh`**

3. PDF generator (PYTHON)

Servis will return PDF encoded as base64

We need to install:
- https://weasyprint.readthedocs.io/en/stable/index.html
- pip install WeasyPrint
- brew install cairo
- brew install pango

docs: `http://127.0.0.1:8000/docs`

```bash
~/secret_santa/pdf_generator$ uvicorn main:app --reload
```

**Example request to servis `test_generate_pdf.sh`**