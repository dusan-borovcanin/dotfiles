package main

import (
	"fmt"
	"log"
	"net/url"
	"os"
	"os/exec"
	"strings"
)

const browser = "brave"

func main() {
	if len(os.Args) != 2 {
		log.Fatalln("Invalid number of args")
	}
	args := os.Args[1:]
	a := args[0]
	var c *exec.Cmd
	switch {
	case strings.HasPrefix(a, "t "):
		q := url.URL{Path: strings.TrimSpace(strings.TrimPrefix(a, "t "))}
		p := q.EscapedPath()
		c = exec.Command("bash", "-c", fmt.Sprintf("%s https://translate.google.rs/?sl=sr\\&tl=en\\&text=%s\\&op=translate", browser, p))
	case strings.HasPrefix(a, "!t "):
		q := url.URL{Path: strings.TrimSpace(strings.TrimPrefix(a, "!t "))}
		p := q.EscapedPath()
		c = exec.Command("bash", "-c", fmt.Sprintf("%s https://translate.google.rs/?sl=en\\&tl=sr\\&text=%s\\&op=translate", browser, p))
	case a == "mondo":
		c = exec.Command("bash", "-c", fmt.Sprintf("%s www.mondo.rs", browser))
	case a == "fb":
		c = exec.Command("bash", "-c", fmt.Sprintf("%s www.facebook.com", browser))
	case a == "wa":
		c = exec.Command("bash", "-c", fmt.Sprintf("%s https://web.whatsapp.com", browser))
	case a == "mf":
		c = exec.Command("bash", "-c", fmt.Sprintf("%s https://github.com/mainflux", browser))
	default:
		c = exec.Command("bash", "-c", fmt.Sprintf("%s https://www.google.com/search?q=%s", browser, url.QueryEscape(a)))
	}

	if err := c.Run(); err != nil {
		log.Fatalf("An error ocurred: %s", err)
	}
	os.Exit(0)
}
