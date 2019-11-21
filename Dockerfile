## golang tools
FROM golang:1.13.4 as golang_builder
RUN go get github.com/genuinetools/reg
RUN go get github.com/golang/dep/cmd/dep
RUN GO111MODULE=on go get github.com/sachaos/todoist@v0.14.0
RUN GO111MODULE=on go get github.com/screwdriver-cd/gitversion@v1.1.3

# vim-go dependencies
RUN apt-get update -q && apt-get install -y -qq vim-nox
RUN git clone https://github.com/fatih/vim-go.git /root/.vim/pack/lang/start/vim-go
RUN vim +":set nomore" +GoInstallBinaries +qall

