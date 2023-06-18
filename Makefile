EMACS = /Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs

clean:
	rm -vr public/*

touch:
	find . -name "*.org" | xargs touch

pub:
	$(EMACS) $< --batch --load publish.el --eval="(org-publish-all)"

force-pub:
	$(EMACS) $< --batch --load publish.el --eval="(org-publish-all t)"

test:
	cd public/ && python3 -m http.server
