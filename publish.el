(require 'ox-publish)

;; --- Main configurations for your project

(setq author "Author")
(setq email "foo@example.org")

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

;; --- Customize the following as necessary

;; Function to style the sitemap
(defun sitemap-function (title list)
  (org-list-to-org list))

;; Function to format each sitemap entry
(defun sitemap-format-entry (entry style project)
  (cond ((not (directory-name-p entry))
	 (format "[[file:%s][%s]]" entry (org-publish-find-title entry project)))
        ((eq style 'tree)
         (file-name-nondirectory (directory-file-name entry)))
        (t
	 entry)))

(setq org-publish-project-alist
      `(("static"
	 :recursive t
         :base-directory "src/"
         :base-extension ,static-extensions
	 :include ,static-include
         :publishing-directory "public/"
         :publishing-function org-publish-attachment)
	("pages"
	 :recursive t
         :base-directory "src/"
         :base-extension "org"
	 :exclude "index.org"
         :publishing-directory "public/"
         :publishing-function org-html-publish-to-html
	 :with-toc nil
	 :section-numbers nil
	 :author ,author
	 :email ,email
	 :auto-sitemap t
	 :sitemap-title "Index"
	 :sitemap-function sitemap-function
	 :sitemap-format-entry sitemap-format-entry
	 :sitemap-sort-files chronologically
	 :html-doctype "html5"
	 :html-html5-fancy t
	 :html-head-include-scripts nil
	 :html-head-include-default-style nil
	 :html-metadata-timestamp-format "%Y-%m-%d"
	 :html-head ,custom-html-head
	 :html-home/up-format ,custom-html-nav
	 :html-link-home "/"
	 :html-preamble t,
	 :html-postamble t,
	 :html-preamble-format ,custom-html-preamble-format
	 :html-postamble-format ,custom-html-postamble-format)
	("index"
	 :recursive nil
         :base-directory "src/"
         :base-extension ""
	 :include ("index.org")
         :publishing-directory "public/"
         :publishing-function org-html-publish-to-html
	 :with-toc nil
	 :section-numbers nil
	 :author ,author
	 :email ,email
	 :html-doctype "html5"
	 :html-html5-fancy t
	 :html-head-include-scripts nil
	 :html-head-include-default-style nil
	 :html-metadata-timestamp-format "%Y-%m-%d"
	 :html-head ,custom-html-head
	 :html-postamble t
	 :html-postamble-format ,custom-html-postamble-format)
        ("all"
	 :components ("static" "pages" "index"))))
