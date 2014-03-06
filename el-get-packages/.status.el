((ag status "installed" recipe
     (:name ag :description "A simple ag frontend, loosely based on ack-and-half.el." :type github :pkgname "Wilfred/ag.el"))
 (anzu status "installed" recipe
       (:name anzu :website "https://github.com/syohex/emacs-anzu" :description "A minor mode which displays current match and total matches." :type "github" :branch "master" :pkgname "syohex/emacs-anzu"))
 (auto-complete status "installed" recipe
		(:name auto-complete :website "https://github.com/auto-complete/auto-complete" :description "The most intelligent auto-completion extension." :type github :pkgname "auto-complete/auto-complete" :depends
		       (popup fuzzy)))
 (auto-complete-etags status "installed" recipe
		      (:name auto-complete-etags :type emacswiki :description "Auto-complete sources for etags" :depends auto-complete))
 (auto-highlight-symbol status "installed" recipe
			(:name auto-highlight-symbol :type github :pkgname "emacsmirror/auto-highlight-symbol" :description "Automatic highlighting current symbol minor mode" :website "https://github.com/emacsmirror/auto-highlight-symbol/"))
 (auto-save-buffers status "installed" recipe
		    (:name auto-save-buffers :type http :description "auto-save-buffers" :url "http://homepage3.nifty.com/oatu/emacs/archives/auto-save-buffers.el"))
 (cl-lib status "installed" recipe
	 (:name cl-lib :builtin "24.3" :type elpa :description "Properly prefixed CL functions and macros" :url "http://elpa.gnu.org/packages/cl-lib.html"))
 (coffee-mode status "installed" recipe
	      (:name coffee-mode :website "http://ozmm.org/posts/coffee_mode.html" :description "Emacs Major Mode for CoffeeScript" :type github :pkgname "defunkt/coffee-mode" :features coffee-mode :post-init
		     (progn
		       (add-to-list 'auto-mode-alist
				    '("\\.coffee$" . coffee-mode))
		       (add-to-list 'auto-mode-alist
				    '("Cakefile" . coffee-mode))
		       (setq coffee-js-mode 'javascript-mode))))
 (cucumber status "installed" recipe
	   (:name cucumber :type git :website "https://github.com/michaelklishin/cucumber.el" :description "Emacs mode for editing plain text user stories" :url "https://github.com/michaelklishin/cucumber.el.git"))
 (dash-at-point status "installed" recipe
		(:name dash-at-point :description "Search the word at point with Dash. Dash is an API Documentation Browser and Code Snippet Manager. dash-at-point make it easy to search the word at point with Dash." :type github :pkgname "stanaka/dash-at-point"))
 (direx status "installed" recipe
	(:name direx :description "Directory Explorer" :website "https://github.com/m2ym/direx-el" :type github :pkgname "m2ym/direx-el" :features "direx"))
 (expand-region status "installed" recipe
		(:name expand-region :type github :pkgname "magnars/expand-region.el" :description "Expand region increases the selected region by semantic units. Just keep pressing the key until it selects what you want." :website "https://github.com/magnars/expand-region.el#readme" :features expand-region))
 (fuzzy status "installed" recipe
	(:name fuzzy :website "https://github.com/auto-complete/fuzzy-el" :description "Fuzzy matching utilities for GNU Emacs" :type github :pkgname "auto-complete/fuzzy-el"))
 (geben status "installed" recipe
	(:name geben :type git :website "https://github.com/mcorde/geben-on-emacs" :description "GEBEN is a software package that interfaces Emacs to DBGp protocol with which you can debug running scripts interactive." :url "https://github.com/mcorde/geben-on-emacs.git"))
 (git-gutter status "installed" recipe
	     (:name git-gutter :description "Emacs port of GitGutter Sublime Text 2 Plugin" :website "https://github.com/syohex/emacs-git-gutter" :type github :pkgname "syohex/emacs-git-gutter"))
 (git-modes status "installed" recipe
	    (:name git-modes :description "GNU Emacs modes for various Git-related files" :type github :pkgname "magit/git-modes"))
 (helm-ls-git status "installed" recipe
	      (:name helm-ls-git :description "Yet another helm to list git file." :type github :pkgname "emacs-helm/helm-ls-git"))
 (highlight-symbol status "installed" recipe
		   (:name highlight-symbol :description "Quickly highlight a symbol throughout the buffer and cycle through its locations." :type http :url "http://nschum.de/src/emacs/highlight-symbol/highlight-symbol.el" :features "highlight-symbol"))
 (jaspace status "installed" recipe
	  (:name jaspace :type http :description "Make Japanese whitespaces visible" :url "http://homepage3.nifty.com/satomii/software/jaspace.el" :features jaspace :post-init
		 (progn
		   (global-font-lock-mode t)
		   (setq jaspace-alternate-jaspace-string "?")
		   (setq jaspace-alternate-eol-string "\n")
		   (setq jaspace-highlight-tabs 94))))
 (jshint-mode status "installed" recipe
	      (:name jshint-mode :website "https://github.com/daleharvey/jshint-mode" :description "Integrate JSHint into Emacs via a node.js server. JSHint (http://www.jshint.com/) is a static code analysis tool for JavaScript." :type github :pkgname "daleharvey/jshint-mode"))
 (less-css-mode status "installed" recipe
		(:name less-css-mode :type http :description "less-css-mode" :url "https://raw.github.com/purcell/less-css-mode/master/less-css-mode.el"))
 (magit status "installed" recipe
	(:name magit :website "https://github.com/magit/magit#readme" :description "It's Magit! An Emacs mode for Git." :type github :pkgname "magit/magit" :depends
	       (cl-lib git-modes)
	       :info "." :build
	       (if
		   (version<= "24.3" emacs-version)
		   `(("make" ,(format "EMACS=%s" el-get-emacs)
		      "all"))
		 `(("make" ,(format "EMACS=%s" el-get-emacs)
		    "docs")))
	       :build/berkeley-unix
	       (("touch" "`find . -name Makefile`")
		("gmake"))))
 (multiple-cursors status "installed" recipe
		   (:name multiple-cursors :description "An experiment in adding multiple cursors to emacs" :type github :pkgname "magnars/multiple-cursors.el" :features multiple-cursors))
 (package status "installed" recipe
	  (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin "24" :type http :url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el" :shallow nil :features package :post-init
		 (progn
		   (setq package-user-dir
			 (expand-file-name
			  (convert-standard-filename
			   (concat
			    (file-name-as-directory default-directory)
			    "elpa")))
			 package-directory-list
			 (list
			  (file-name-as-directory package-user-dir)
			  "/usr/share/emacs/site-lisp/elpa/"))
		   (make-directory package-user-dir t)
		   (unless
		       (boundp 'package-subdirectory-regexp)
		     (defconst package-subdirectory-regexp "^\\([^.].*\\)-\\([0-9]+\\(?:[.][0-9]+\\)*\\)$" "Regular expression matching the name of\n a package subdirectory. The first subexpression is the package\n name. The second subexpression is the version string."))
		   (setq package-archives
			 (bound-and-true-p package-archives))
		   (mapc
		    (lambda
		      (pa)
		      (add-to-list 'package-archives pa 'append))
		    '(("ELPA" . "http://tromey.com/elpa/")
		      ("gnu" . "http://elpa.gnu.org/packages/")
		      ("marmalade" . "http://marmalade-repo.org/packages/")
		      ("SC" . "http://joseito.republika.pl/sunrise-commander/"))))))
 (php-mode status "installed" recipe
	   (:name php-mode :description "A PHP mode for GNU Emacs " :type github :pkgname "ejmr/php-mode" :website "https://github.com/ejmr/php-mode"))
 (popup status "installed" recipe
	(:name popup :website "https://github.com/auto-complete/popup-el" :description "Visual Popup Interface Library for Emacs" :type github :submodule nil :pkgname "auto-complete/popup-el"))
 (popwin status "installed" recipe
	 (:name popwin :description "Popup Window Manager." :website "https://github.com/m2ym/popwin-el" :type github :pkgname "m2ym/popwin-el"))
 (quickrun status "installed" recipe
	   (:name quickrun :description "Run commands quickly" :website "https://github.com/syohex/emacs-quickrun" :type github :pkgname "syohex/emacs-quickrun" :features "quickrun"))
 (rcodetools status "installed" recipe
	     (:name rcodetools :description "rcodetools is a collection of Ruby code manipulation tools." :type github :pkgname "tnoda/rcodetools"))
 (rhtml-mode status "installed" recipe
	     (:name rhtml-mode :description "Major mode for editing RHTML files" :type github :pkgname "eschulte/rhtml" :prepare
		    (progn
		      (autoload 'rhtml-mode "rhtml-mode" nil t)
		      (add-to-list 'auto-mode-alist
				   '("\\.html.erb$" . rhtml-mode)))))
 (rinari status "installed" recipe
	 (:name rinari :description "Rinari Is Not A Rails IDE" :type github :pkgname "eschulte/rinari" :load-path
		("." "util" "util/jump")
		:compile
		("\\.el$" "util")
		:build
		(("bundle")
		 ("rake" "doc:install_info"))
		:info "doc" :features rinari))
 (ruby-end status "installed" recipe
	   (:name ruby-end :description "Emacs minor mode for automatic insertion of end blocks for Ruby" :type http :url "https://github.com/rejeep/ruby-end/raw/master/ruby-end.el" :features ruby-end))
 (ruby-mode-github status "installed" recipe
		   (:name ruby-mode-github :type git :website "https://github.com/jwiegley/ruby-mode" :description "Git mirror of ruby-mode from the Ruby SVN sources" :url "https://github.com/jwiegley/ruby-mode.git"))
 (smartrep status "installed" recipe
	   (:name smartrep :description "Support sequential operation which omitted prefix keys." :website "http://sheephead.homelinux.org/2011/12/19/6930/" :type github :pkgname "myuhe/smartrep.el" :features "smartrep"))
 (undo-tree status "installed" recipe
	    (:name undo-tree :description "Treat undo history as a tree" :website "http://www.dr-qubit.org/emacs.php" :type git :url "http://www.dr-qubit.org/git/undo-tree.git/"))
 (web-mode status "installed" recipe
	   (:name web-mode :description "emacs major mode for editing PHP/JSP/ASP HTML templates (with embedded CSS and JS blocks)" :type github :pkgname "fxbois/web-mode"))
 (yaml-mode status "installed" recipe
	    (:name yaml-mode :description "Simple major mode to edit YAML file for emacs" :type github :pkgname "yoshiki/yaml-mode"))
 (yard-mode status "installed" recipe
	    (:name yard-mode :type git :website "https://github.com/pd/yard-mode.el" :description "Rudimentary support for fontifying YARD tags and directives in ruby comments." :url "https://github.com/pd/yard-mode.el.git")))
