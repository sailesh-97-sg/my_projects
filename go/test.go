package main

import (
    "fmt"
    "log"
    "net/http"
    "net/url"

    "github.com/PuerkitoBio/goquery"
)

func main() {
    // Create HTTP client with default settings
    client := &http.Client{}

    // Create URL object
    urlObj, err := url.Parse("https://example.com")
    if err != nil {
        log.Fatal(err)
    }

    // Create HTTP request object
    req, err := http.NewRequest("GET", urlObj.String(), nil)
    if err != nil {
        log.Fatal(err)
    }

    // Set HTTP request headers
    req.Header.Set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36")

    // Send HTTP request and get response
    resp, err := client.Do(req)
    if err != nil {
        log.Fatal(err)
    }
    defer resp.Body.Close()

    // Load HTML document from response body
    doc, err := goquery.NewDocumentFromReader(resp.Body)
    if err != nil {
        log.Fatal(err)
    }

    // Find the first h1 element
    fmt.Println(doc.Find("h1").First().Text())
}
