FROM mcr.microsoft.com/powershell:latest

LABEL   Maintainer = "Shane Hoey" \
        Date = "1/09/2020" \
        Description = "docker container with PowerShell Core and latest modules to manage Teams"

RUN pwsh -command "install-module -name MicrosoftTeams -scope allusers -force -verbose \
                && install-module -name az -scope allusers -force -verbose \
                && install-module -name Microsoft.Graph.Authentication -scope allusers -force -verbose \
                && install-module -name mediant -scope allusers -force -verbose \
                && install-module -name ipphones -scope allusers -force -verbose\
                && install-module -name Universal -scope allusers -force -verbose"
                
COPY profile.ps1 /home/.config/powershell/profile.ps1
COPY /TeamsTools/LICENSE.txt /home/.config/powershell/modules/teamstools/license.txt
COPY /TeamsTools/TeamsTools.psd1 /home/.config/powershell/modules/teamstools/teamstools.psd1
COPY /TeamsTools/TeamsTools.psm1 /home/.config/powershell/modules/teamstools/teamstools.psm1
COPY dashboard.ps1 /home/dashboard.ps1

ENV HOME /home

WORKDIR $HOME

ENTRYPOINT [ "pwsh" ]
