## golang tools
FROM golang:1.13 as tools_vim-go
RUN apt-get update -q && apt-get install -y -qq vim-nox
RUN git clone -b v1.21 https://github.com/fatih/vim-go.git /root/.vim/pack/lang/start/vim-go
RUN vim +":set nomore" +GoInstallBinaries +qall

FROM golang:1.13 as tools_jump
RUN go get github.com/gsamokovarov/jump

FROM golang:1.13 as tools_dive
RUN go get github.com/wagoodman/dive

FROM golang:1.13 as tools_gitversion
RUN GO111MODULE=on go get github.com/screwdriver-cd/gitversion@v1.1.3

FROM golang:1.13 as tools_reg
RUN go get github.com/genuinetools/reg

FROM golang:1.13 as tools_dep
RUN go get github.com/golang/dep/cmd/dep

FROM scratch
COPY --from=tools_jump /go/bin/jump /usr/local/bin/
COPY --from=tools_dive /go/bin/dive /usr/local/bin/
COPY --from=tools_gitversion /go/bin/gitversion /usr/local/bin/
COPY --from=tools_reg /go/bin/reg /usr/local/bin/
COPY --from=tools_dep /go/bin/dep /usr/local/bin/
