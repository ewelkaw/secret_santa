package main

import (
	"encoding/json"
	"fmt"
	"math/rand"
	"net/http"
	"time"
)

type Input struct {
	Names []string
}

type Mapping struct {
	From string
	To   string
}

type Output struct {
	Names []Mapping
}

func generate(namesJson []byte) {
	var input Input
	json.Unmarshal([]byte(namesJson), &input)

	rand.Seed(time.Now().UnixNano())
	rand.Shuffle(len(input.Names), func(i, j int) { input.Names[i], input.Names[j] = input.Names[j], input.Names[i] })

	fmt.Println("Hello, playground", input)
	namesX := []Mapping{}
	for idx, name := range input.Names {
		if (idx + 1) < len(input.Names) {
			namesX = append(namesX, Mapping{From: name, To: input.Names[idx+1]})
		} else {
			namesX = append(namesX, Mapping{From: name, To: input.Names[0]})
		}

	}

	output := Output{Names: namesX}
	fmt.Println(output)
	data, err := json.Marshal(output)
	if err != nil {
		fmt.Println("ERROR")
	}
	fmt.Println(data)
}

func handleGenerate(w http.ResponseWriter, req *http.Request) {
	// generate(req.Data)
	fmt.Fprintf(w, "%v", req)
}

func headers(w http.ResponseWriter, req *http.Request) {
	for name, headers := range req.Header {
		for _, h := range headers {
			fmt.Fprintf(w, "%v: %v\n", name, h)
		}
	}
}

func main() {
	http.HandleFunc("/generate", handleGenerate)
	http.ListenAndServe(":8090", nil)
}
