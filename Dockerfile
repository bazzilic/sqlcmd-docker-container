FROM stefanscherer/chocolatey

RUN choco install -y sqlserver-cmdlineutils

ENTRYPOINT [ "sqlcmd" ]
