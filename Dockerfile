FROM schickling/rust
MAINTAINER Michele Bertasi

ADD fs/ /

# install pagkages
RUN apt-get update                                                      && \
    apt-get install -y ncurses-dev libtolua-dev exuberant-ctags            \
        mercurial git make                                              && \
    ln -s /usr/include/lua5.2/ /usr/include/lua                         && \
    ln -s /usr/lib/x86_64-linux-gnu/liblua5.2.so /usr/lib/liblua.so     && \
    cd /tmp                                                             && \
# build and install vim
    hg clone https://code.google.com/p/vim/                             && \
    cd vim                                                              && \
    ./configure --with-features=huge --enable-luainterp                    \
        --enable-gui=no --without-x --prefix=/usr                       && \
    make VIMRUNTIMEDIR=/usr/share/vim/vim74                             && \
    make install                                                        && \
# build and install racer
    cd /tmp                                                             && \
    git clone git@github.com:phildawes/racer.git                        && \
    cd racer && cargo build --release                                   && \
# add dev user
    adduser dev --disabled-password --gecos ""                          && \
    echo "ALL            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers     && \
    chown -R dev:dev /home/dev /go                                      && \
# cleanup
    apt-get remove -y ncurses-dev mercurial                             && \
    apt-get autoremove -y                                               && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER dev
ENV HOME /home/dev

# install vim plugins
RUN mkdir -p ~/.vim/bundle                                              && \
    cd  ~/.vim/bundle                                                   && \
    git clone --depth 1 https://github.com/gmarik/Vundle.vim.git        && \
    git clone --depth 1 https://github.com/majutsushi/tagbar.git        && \
    git clone --depth 1 https://github.com/Shougo/neocomplete.vim.git   && \
    git clone --depth 1 https://github.com/scrooloose/nerdtree.git      && \
    git clone --depth 1 https://github.com/bling/vim-airline.git        && \
    git clone --depth 1 https://github.com/tpope/vim-fugitive.git       && \
    git clone --depth 1 https://github.com/jistr/vim-nerdtree-tabs.git  && \
    git clone --depth 1 https://github.com/mbbill/undotree.git          && \
    git clone --depth 1 https://github.com/Lokaltog/vim-easymotion.git  && \
    git clone --depth 1 https://github.com/scrooloose/nerdcommenter.git && \
    git clone --depth 1 https://github.com/phildawes/racer.git          && \
    git clone --depth 1 git@github.com:rust-lang/rust.vim.git           && \
    vim +PluginInstall +qall                                            && \
# cleanup
    rm -rf Vundle.vim/.git tagbar/.git neocomplete.vim/.git nerdtree/.git  \
        vim-airline/.git vim-fugitive/.git vim-nerdtree-tabs/.git          \
        undotree/.git vim-easymotion/.git nerdcommenter/.git racer/.git    \
        rust.vim/.git