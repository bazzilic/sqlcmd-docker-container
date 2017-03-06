FROM stefanscherer/chocolatey

RUN choco install -y sqlserver-cmdlineutils

HEALTHCHECK CMD [ "sqlcmd", "-Q", "select 1" ]

ENTRYPOINT [ "sqlcmd" ]
