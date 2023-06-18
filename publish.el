(require 'ox-publish)

(setq author "Author")
(setq email "foo@example.org")
(setq publish-timestamp? nil)

(setq custom-html-preamble-format
      '(("en" "Published %d")))

(setq custom-html-postamble-format
      '(("en" "&copy; %a. Contact me at &lt;%e&gt;")))

(setq custom-html-head "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n<link rel=\"stylesheet\" href=\"/static/t.css\"/>")
(setq custom-html-nav "<nav><a href=\"/\" tabindex=\"0\">&larrhk; Back to Index</a><hr/></nav>")

(setq static-extensions "css\\|svg\\|csv\\|png\\|jpg\\|jpeg\\|gif")

(setq make-backup-files nil)

(setq org-export-global-macros
      '(("timestamp" . "@@html:<time class=\"dt-published\">$1</time>@@")))

(defun sitemap-function (title list)
  (org-list-to-org list))

(defun sitemap-format-entry (entry style project)
  (cond ((string= "index.org" entry)
	 "")
	((not (directory-name-p entry))
	 (if publish-timestamp?
	     (format "{{{timestamp(%s)}}} [[file:%s][%s]]"
		     (format-time-string "%Y-%m-%d" (org-publish-find-date entry project))
                     entry
                     (org-publish-find-title entry project))
             (format "[[file:%s][%s]]"
                     entry
                     (org-publish-find-title entry project))))
        ((eq style 'tree)
         ;; Return only last subdir.
         (file-name-nondirectory (directory-file-name entry)))
        (t
	 entry)))

(setq org-publish-project-alist
      `(("static"
	 :recursive t
         :base-directory "src/"
         :base-extension ,static-extensions
         :publishing-directory "public/"
         :publishing-function org-publish-attachment)
	("pages"
	 :recursive t
         :base-directory "src/"
         :base-extension "org"
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
	 :html-preamble nil,
	 :html-postamble t,
	 :html-preamble-format ,custom-html-preamble-format
	 :html-postamble-format ,custom-html-postamble-format)
	("index"
	 :recursive t
         :base-directory "src/"
         :base-extension "orgi" ;; Trick to avoid including the index on the sitemap itself
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
