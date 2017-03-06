FROM microsoft/windowsservercore

ENV SQLCMDURL https://download.microsoft.com/download/C/8/8/C88C2E51-8D23-4301-9F4B-64C8E2F163C5/Command%20Line%20Utilities%20MSI%20files/amd64/MsSqlCmdLnUtils.msi
ENV ODBCURL https://download.microsoft.com/download/D/5/E/D5EEF288-A277-45C8-855B-8E2CB7E25B96/x64/msodbcsql.msi

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN iwr -uri $env:ODBCURL -outfile C:\odbcinstall.msi ; \
    msiexec /i C:\odbcinstall.msi /l*vx C:\odbcinstallation.log /quiet /qn /norestart IACCEPTMSODBCSQLLICENSETERMS=YES ; \
    iwr -uri $env:SQLCMDURL -outfile C:\sqlcmdinstall.msi ; \
    msiexec /i C:\sqlcmdinstall.msi /l*vx C:\sqlcmdinstallation.log /quiet /qn /norestart IACCEPTMSSQLCMDLNUTILSLICENSETERMS=YES

HEALTHCHECK CMD [ "sqlcmd", "-Q", "select 1" ]

ENTRYPOINT [ "sqlcmd" ]
