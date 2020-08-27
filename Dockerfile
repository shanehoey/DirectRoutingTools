FROM mcr.microsoft.com/powershell:latest

LABEL   Maintainer = "Shane Hoey" \
        Date = "1/09/2020" \
        Description = "docker container with PowerShell Core and latest modules to manage Teams"

RUN pwsh -command "install-module -name MicrosoftTeams -requiredversion 1.1.3-preview -scope allusers -allowprerelease -force -verbose \
                && install-module -name az -scope allusers -force -verbose \
                && install-module -name Microsoft.Graph -scope allusers -force -verbose \
                && install-module -name mediant -scope allusers -force -verbose \
                && install-module -name ipphones -scope allusers -force -verbose"
                
COPY profile.ps1 /home/.config/powershell/profile.ps1
COPY /teamstools/license.txt /home/.config/powershell/modules/teamstools/license.txt
COPY /teamstools/teamstools.psd1 /home/.config/powershell/modules/teamstools/teamstools.psd1
COPY /teamstools/teamstools.psm1 /home/.config/powershell/modules/teamstools/teamstools.psm1

ENV HOME /home

WORKDIR $HOME

ENTRYPOINT [ "pwsh" ]
