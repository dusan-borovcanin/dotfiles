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
	if len(os.Args) < 3 || os.Args[1] == "" {
		log.Fatalln("Invalid number of args")
	}

	args := os.Args[1:] // strip the root command
	a := args[0]
	var c *exec.Cmd
	switch {
	case a == "cal":
		c = openBrowser("https://calendar.google.com/calendar/u/0/r/custom/7/d")
	case a == "wa":
		c = openBrowser("https://web.whatsapp.com")
	case a == "fb":
		c = openBrowser("www.facebook.com")
	case a == "mf":
		c = openBrowser("https://github.com/mainflux")
	case a == "mondo":
		c = openBrowser("www.mondo.rs")
	case a == "t":
		q := url.URL{Path: strings.Join(args[1:], " ")}
		p := q.EscapedPath()
		c = openBrowser(fmt.Sprintf("https://translate.google.rs/?sl=sr\\&tl=en\\&text=%s\\&op=translate", p))
	case a == "t!":
		q := url.URL{Path: strings.Join(args[1:], " ")}
		p := q.EscapedPath()
		c = openBrowser(fmt.Sprintf("https://translate.google.rs/?sl=en\\&tl=sr\\&text=%s\\&op=translate", p))
	case a == "gmail", strings.HasPrefix(a, "gmail "):
		q := url.QueryEscape(strings.TrimSpace(strings.TrimPrefix(a, "gmail")))
		if q == "" {
			c = openBrowser("https://mail.google.com/mail/u/0/#inbox")
			break
		}
		c = openBrowser(fmt.Sprintf("https://mail.google.com/mail/u/0/\\#search/%s", q))
	case strings.HasPrefix(a, "yt "):
		q := url.QueryEscape(strings.TrimSpace(strings.TrimPrefix(a, "yt ")))
		c = openBrowser(fmt.Sprintf("https://www.youtube.com/results?search_query=%s", q))
	default:
		c = openBrowser(fmt.Sprintf("https://www.google.com/search?q=%s", url.QueryEscape(a)))
	}

	if c == nil {
		log.Fatal("Command does not exist!")
	}
	if err := c.Run(); err != nil {
		log.Fatalf("An error ocurred: %s!", err)
	}
	os.Exit(0)
}

func openBrowser(url string) *exec.Cmd {
	return exec.Command(shell, shellArgs, fmt.Sprintf("%s %s", browser, url))
}
