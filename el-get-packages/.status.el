((auto-save-buffers status "installed" recipe
		    (:name auto-save-buffers :type http :description "auto-save-buffers" :url "http://homepage3.nifty.com/oatu/emacs/archives/auto-save-buffers.el"))
 (cl-lib status "installed" recipe
	 (:name cl-lib :builtin "24.3" :type elpa :description "Properly prefixed CL functions and macros" :url "http://elpa.gnu.org/packages/cl-lib.html"))
 (cucumber status "installed" recipe
	   (:name cucumber :type git :website "https://github.com/michaelklishin/cucumber.el" :description "Emacs mode for editing plain text user stories" :url "https://github.com/michaelklishin/cucumber.el.git"))
 (git-modes status "installed" recipe
	    (:name git-modes :description "GNU Emacs modes for various Git-related files" :type github :pkgname "magit/git-modes"))
 (helm-ls-git status "installed" recipe
	      (:name helm-ls-git :description "Yet another helm to list git file." :type github :pkgname "emacs-helm/helm-ls-git"))
 (jaspace status "installed" recipe
	  (:name jaspace :type http :description "Make Japanese whitespaces visible" :url "http://homepage3.nifty.com/satomii/software/jaspace.el" :features jaspace :post-init
		 (progn
		   (global-font-lock-mode t)
		   (setq jaspace-alternate-jaspace-string "?")
		   (setq jaspace-alternate-eol-string "\n")
		   (setq jaspace-highlight-tabs 94))))
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
 (popwin status "installed" recipe
	 (:name popwin :description "Popup Window Manager." :website "https://github.com/m2ym/popwin-el" :type github :pkgname "m2ym/popwin-el"))
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
 (ruby-electric status "installed" recipe
		(:name ruby-electric :description "Electric commands editing for ruby files" :type github :pkgname "qoobaa/ruby-electric" :post-init
		       (add-hook 'ruby-mode-hook 'ruby-electric-mode)))
 (ruby-mode-github status "installed" recipe
		   (:name ruby-mode-github :type git :website "https://github.com/jwiegley/ruby-mode" :description "Git mirror of ruby-mode from the Ruby SVN sources" :url "https://github.com/jwiegley/ruby-mode.git"))
 (undo-tree status "installed" recipe
	    (:name undo-tree :description "Treat undo history as a tree" :website "http://www.dr-qubit.org/emacs.php" :type git :url "http://www.dr-qubit.org/git/undo-tree.git/"))
 (yard-mode status "installed" recipe
	    (:name yard-mode :type git :website "https://github.com/pd/yard-mode.el" :description "Rudimentary support for fontifying YARD tags and directives in ruby comments." :url "https://github.com/pd/yard-mode.el.git")))
