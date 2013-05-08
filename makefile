# makefile for restoring settings

vim: vundle vimrc

vimrc:
	-mv -n ~/.vimrc ~/.vimrc.old
	ln -s dotfiles/.vimrc ~/.vimrc

vundle: vimrc ~/.vim/bundle/vundle/README.md
	vim +BundleInstall +qall

~/.vim/bundle/vundle/README.md:
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

bashrc:
	-mv -n ~/.bashrc ~/.bashrc.old
	ln -s dotfiles/.bashrc ~/

kde:
	-mv -n ~/.kde ~/.kde.old
	ln -s dotfiles/.kde ~/


BACKUP=mv -f $@ $@.old || cp $< $@

backup: fstab xorg.conf.archforum xorg.conf.home xorg.conf.homer xorg.conf.triple 

fstab: /etc/fstab
	$(BACKUP)

xorg.conf.home: /etc/X11/xorg.conf.home
	$(BACKUP)
	
xorg.conf.archforum: /etc/X11/xorg.conf.archforum
	$(BACKUP)
		
xorg.conf.homer: /etc/X11/xorg.conf.homer
	$(BACKUP)

xorg.conf.triple: /etc/X11/xorg.conf.triple
	$(BACKUP)
