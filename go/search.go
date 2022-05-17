package main

import (
	"fmt"
	"log"
	"net/url"
	"os"
	"os/exec"
	"strings"
)

const (
	browser   = "brave"
	shell     = "bash"
	shellArgs = "-c"
)

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
		c = exec.Command(shell, shellArgs, fmt.Sprintf("%s https://translate.google.rs/?sl=sr\\&tl=en\\&text=%s\\&op=translate", browser, p))
	case strings.HasPrefix(a, "t! "):
		q := url.URL{Path: strings.TrimSpace(strings.TrimPrefix(a, "!t "))}
		p := q.EscapedPath()
		c = exec.Command(shell, shellArgs, fmt.Sprintf("%s https://translate.google.rs/?sl=en\\&tl=sr\\&text=%s\\&op=translate", browser, p))
	case strings.HasPrefix(a, "yt "):
		q := url.QueryEscape(strings.TrimPrefix(a, "yt "))
		c = exec.Command(shell, shellArgs, fmt.Sprintf("%s https://www.youtube.com/results?search_query=%s", browser, q))
	case a == "mondo":
		c = exec.Command(shell, shellArgs, fmt.Sprintf("%s www.mondo.rs", browser))
	case a == "fb":
		c = exec.Command(shell, shellArgs, fmt.Sprintf("%s www.facebook.com", browser))
	case a == "wa":
		c = exec.Command(shell, shellArgs, fmt.Sprintf("%s https://web.whatsapp.com", browser))
	case a == "mf":
		c = exec.Command(shell, shellArgs, fmt.Sprintf("%s https://github.com/mainflux", browser))
	default:
		c = exec.Command(shell, shellArgs, fmt.Sprintf("%s https://www.google.com/search?q=%s", browser, url.QueryEscape(a)))
	}

	if c == nil {
		log.Fatal("Commnad does not exist!")
	}
	if err := c.Run(); err != nil {
		log.Fatalf("An error ocurred: %s!", err)
	}
	os.Exit(0)
}
