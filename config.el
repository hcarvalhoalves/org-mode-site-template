;; --- Main configurations for your project

(setq author "Author")
(setq email "foo@example.org")

(setq custom-timestamp-format "%Y-%m-%d")

;; Default HTML to include at the top if #+options: html-preamble:t
(setq custom-html-preamble-format
      '(("en" "Published %d")))

;; Default HTML to include at the footer if #+options: html-postamble:t
(setq custom-html-postamble-format
      '(("en" "&copy; %a. Contact me at &lt;%e&gt;")))

;; Custom HTML to include inside <head>
(setq custom-html-head "\
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
<link rel=\"stylesheet\" href=\"/static/t.css\"/>")

;; Custom HTML to build a navigation bar (only applies when :html-link-home is non-nil)
(setq custom-html-nav "\
<nav><a href=\"/\" tabindex=\"0\">&larrhk; Back to Index</a></nav>")

;; List of extensions considered static files
(setq static-extensions "css\\|svg\\|csv\\|png\\|jpg\\|jpeg\\|gif")

;; Other static files to include explicitly
(setq static-include '(".htaccess"))
