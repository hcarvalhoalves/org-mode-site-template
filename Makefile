EMACS = /Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs

clean:
	rm -vr docs/*

pub:
	$(EMACS) $< --batch --load publish.el --eval="(org-publish-all)"

force-pub:
	$(EMACS) $< --batch --load publish.el --eval="(org-publish-all t)"

test:
	cd docs/ && python3 -m http.server
