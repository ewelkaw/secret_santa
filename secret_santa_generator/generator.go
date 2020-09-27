package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"math/rand"
	"net/http"
	"time"
)

type Input struct {
	Names []string `json:"names"`
}

type Mapping struct {
	From string `json:"from"`
	To   string `json:"to"`
}

type Output struct {
	Names []Mapping `json:"names"`
}

func generate(input Input) {
	rand.Shuffle(len(input.Names), func(i, j int) { input.Names[i], input.Names[j] = input.Names[j], input.Names[i] })
}

func parseInput(namesJson []byte) Input {
	var input Input
	json.Unmarshal(namesJson, &input)
	return input
}

func generateOutput(input Input) []byte {
	outputtedNames := []Mapping{}
	for idx, name := range input.Names {
		if (idx + 1) < len(input.Names) {
			outputtedNames = append(outputtedNames, Mapping{From: name, To: input.Names[idx+1]})
		} else {
			outputtedNames = append(outputtedNames, Mapping{From: name, To: input.Names[0]})
		}
	}

	output := Output{Names: outputtedNames}

	generatedJson, err := json.Marshal(output)
	if err != nil {
		log.Fatal(err)
	}
	return generatedJson
}

func handleGenerate(w http.ResponseWriter, req *http.Request) {
	switch req.Method {
	case "POST":
		reqBody, err := ioutil.ReadAll(req.Body)
		if err != nil {
			log.Fatal(err)
		}
		namesJson := reqBody
		input := parseInput(namesJson)
		generate(input)
		data := generateOutput(input)
		fmt.Fprintf(w, "%v", string(data))
	default:
		fmt.Fprintf(w, "Sorry, only POST method is supported.")
	}
}

func main() {
	rand.Seed(time.Now().UnixNano())
	http.HandleFunc("/generate", handleGenerate)
	http.ListenAndServe(":8090", nil)
}
