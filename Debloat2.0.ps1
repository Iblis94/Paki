#This will self elevate the script so with a UAC prompt since this script needs to be run as an Administrator in order to function properly.

$ErrorActionPreference = 'SilentlyContinue'

$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error
$Ask = 'Do you want to run this as an Administrator?

        Select "Yes" to Run as an Administrator

        Select "No" to not run this as an Administrator
        
        Select "Cancel" to stop the script.'

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    $Prompt = [System.Windows.MessageBox]::Show($Ask, "Run as an Administrator or not?", $Button, $ErrorIco) 
    Switch ($Prompt) {
        #This will debloat Windows 10
        Yes {
            Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
            Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
            Exit
        }
        No {
            Break
        }
    }
}

$global:Bloatware = @(
    "Microsoft.WindowsCalculator"
    "Microsoft.Windows.Photos"
    "CanonicalGroupLimited.UbuntuonWindows"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.MSPaint"
    "Microsoft.WindowsCamera"
    "Microsoft.HEIFImageExtension"
    "Microsoft.ScreenSketch"
    "Microsoft.VP9VideoExtensions"
    "Microsoft.WebMediaExtensions"
    "Microsoft.WebpImageExtension"
    "Microsoft.DesktopAppInstaller"
    "WindSynthBerry"
    "MIDIBerry"
    "Slack"
    "Microsoft.MixedReality.Portal"
    "Microsoft.PPIProjection"
    "Microsoft.BingNews"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.News"
    "Microsoft.Office.Lens"
    "Microsoft.Office.OneNote"
    "Microsoft.Office.Sway"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.Print3D"
    "Microsoft.RemoteDesktop"
    "Microsoft.SkypeApp"
    "Microsoft.Office.Todo.List"
    "Microsoft.Whiteboard"
    "Microsoft.WindowsAlarms"
    "microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"

    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "EclipseManager"
    "ActiproSoftwareLLC"
    "AdobeSystemsIncorporated.AdobePhotoshopExpress"
    "Duolingo-LearnLanguagesforFree"
    "PandoraMediaInc"
    "CandyCrush"
    "BubbleWitch3Saga"
    "Wunderlist"
    "Flipboard"
    "Twitter"
    "Facebook"
    "Spotify"
    "Minecraft"
    "Royal Revolt"
    "Sway"
    "Dolby"
    "Microsoft.Advertising.Xaml"
    "Microsoft.Wallet"
    "Microsoft.YourPhone"
    "Microsoft.LanguageExperiencePackit-IT"
    "Microsoft.MicrosoftEdge.Stable"
)

$global:WhiteListedApps = @(
    "Microsoft.Services.Store.Engagement"
    "Microsoft.Services.Store.Engagement"
    "Microsoft.StorePurchaseApp"
    "Microsoft.WindowsStore"
    "NVIDIACorp.NVIDIAControlPanel"
    "\.NET"
    "Microsoft.UI.Xaml.2.0"
    "Microsoft.VCLibs.140.00.UWPDesktop"
    "Microsoft.VCLibs.140.00"
    "Microsoft.XboxIdentityProvider"
    )

#NonRemovable Apps that where getting attempted and the system would reject the uninstall, speeds up debloat and prevents 'initalizing' overlay when removing apps
$NonRemovables = Get-AppxPackage -AllUsers | Where-Object { $_.NonRemovable -eq $true } | ForEach { $_.Name }
$NonRemovables += Get-AppxPackage | Where-Object { $_.NonRemovable -eq $true } | ForEach { $_.Name }
$NonRemovables += Get-AppxProvisionedPackage -Online | Where-Object { $_.NonRemovable -eq $true } | ForEach { $_.DisplayName }
$NonRemovables = $NonRemovables | Sort-Object -Unique

if ($NonRemovables -eq $null ) {
    # the .NonRemovable property doesn't exist until version 18xx. Use a hard-coded list instead.
    #WARNING: only use exact names here - no short names or wildcards
    $NonRemovables = @(
        "1527c705-839a-4832-9118-54d4Bd6a0c89"
        "c5e2524a-ea46-4f67-841f-6a9465d9d515"
        "E2A4F912-2574-4A75-9BB0-0D023378592B"
        "F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE"
        "InputApp"
        "Microsoft.AAD.BrokerPlugin"
        "Microsoft.AccountsControl"
        "Microsoft.BioEnrollment"
        "Microsoft.CredDialogHost"
        "Microsoft.ECApp"
        "Microsoft.LockApp"
        "Microsoft.MicrosoftEdgeDevToolsClient"
        "Microsoft.MicrosoftEdge"
        "Microsoft.PPIProjection"
        "Microsoft.Win32WebViewHost"
        "Microsoft.Windows.Apprep.ChxApp"
        "Microsoft.Windows.AssignedAccessLockApp"
        "Microsoft.Windows.CapturePicker"
        "Microsoft.Windows.CloudExperienceHost"
        "Microsoft.Windows.ContentDeliveryManager"
        "Microsoft.Windows.Cortana"
        "Microsoft.Windows.HolographicFirstRun"
        "Microsoft.Windows.NarratorQuickStart"
        "Microsoft.Windows.OOBENetworkCaptivePortal"
        "Microsoft.Windows.OOBENetworkConnectionFlow"
        "Microsoft.Windows.ParentalControls"
        "Microsoft.Windows.PeopleExperienceHost"
        "Microsoft.Windows.PinningConfirmationDialog"
        "Microsoft.Windows.SecHealthUI"
        "Microsoft.Windows.SecondaryTileExperience"
        "Microsoft.Windows.SecureAssessmentBrowser"
        "Microsoft.Windows.ShellExperienceHost"
        "Microsoft.Windows.XGpuEjectDialog"
        "Microsoft.XboxGameCallableUI"
        "Windows.CBSPreview"
        "windows.immersivecontrolpanel"
        "Windows.PrintDialog"
        "Microsoft.VCLibs.140.00"
        "Microsoft.Services.Store.Engagement"
        "Microsoft.UI.Xaml.2.0"
        "Nvidia"
        "Microsoft.WindowsStore"
        "Microsoft.StorePurchaseApp"
        "NVIDIACorp.NVIDIAControlPanel"
        "40459File-New-Project.EarTrumpet"
	    "/.NET"
	    "Microsoft.Services.Store.Engagement"

    )
}

# import library code - located relative to this script
Function dotInclude() {
    Param(
        [Parameter(Mandatory)]
        [string]$includeFile
    )
    # Look for the file in the same directory as this script
    $scriptPath = $PSScriptRoot
    if ( $PSScriptRoot -eq $null -and $psISE) {
        $scriptPath = (Split-Path -Path $psISE.CurrentFile.FullPath)
    }
    if ( test-path $scriptPath\$includeFile ) {
        # import and immediately execute the requested file
        . $scriptPath\$includeFile
    }
}

# Override built-in blacklist/whitelist with user defined lists
dotInclude 'custom-lists.ps1'

#convert to regular expression to allow for the super-useful -match operator
$global:BloatwareRegex = $global:Bloatware -join '|'
$global:WhiteListedAppsRegex = $global:WhiteListedApps -join '|'

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                  = New-Object System.Windows.Forms.Form
$Form.ClientSize       = New-Object System.Drawing.Point(360,330)
$Form.StartPosition    = 'CenterScreen'
$Form.FormBorderStyle  = 'FixedSingle'
$Form.MinimizeBox      = $false
$Form.MaximizeBox      = $false
$Form.ShowIcon         = $false
$Form.Text             = "Debloat"
$Form.TopMost          = $false
$Form.AutoScroll       = $true
$Form.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1a2733")


$Button1                       = New-Object System.Windows.Forms.Button
$Button1.FlatStyle             = 'Flat'
$Button1.Text                  = "Rimuovi Bloatware"
$Button1.width                 = 300
$Button1.height                = 30
$Button1.Location              = New-Object System.Drawing.Point(10, 10)
$Button1.Font                  = New-Object System.Drawing.Font('Consolas',10)
$Button1.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Button2                       = New-Object System.Windows.Forms.Button
$Button2.FlatStyle             = 'Flat'
$Button2.Text                  = "Installa Software"
$Button2.width                 = 300
$Button2.height                = 30
$Button2.Location              = New-Object System.Drawing.Point(10, 50)
$Button2.Font                  = New-Object System.Drawing.Font('Consolas',10)
$Button2.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Button3                       = New-Object System.Windows.Forms.Button
$Button3.FlatStyle             = 'Flat'
$Button3.Text                  = "Tweaks Privacy"
$Button3.width                 = 300
$Button3.height                = 30
$Button3.Location              = New-Object System.Drawing.Point(10, 90)
$Button3.Font                  = New-Object System.Drawing.Font('Consolas',10)
$Button3.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Button4                       = New-Object System.Windows.Forms.Button
$Button4.FlatStyle             = 'Flat'
$Button4.Text                  = "Tweaks Update"
$Button4.width                 = 300
$Button4.height                = 30
$Button4.Location              = New-Object System.Drawing.Point(10, 130)
$Button4.Font                  = New-Object System.Drawing.Font('Consolas',10)
$Button4.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Button5                       = New-Object System.Windows.Forms.Button
$Button5.FlatStyle             = 'Flat'
$Button5.Text                  = "Tweaks Security"
$Button5.width                 = 300
$Button5.height                = 30
$Button5.Location              = New-Object System.Drawing.Point(10, 170)
$Button5.Font                  = New-Object System.Drawing.Font('Consolas',10)
$Button5.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Button6                       = New-Object System.Windows.Forms.Button
$Button6.FlatStyle             = 'Flat'
$Button6.Text                  = "Tweaks Applicazioni"
$Button6.width                 = 300
$Button6.height                = 30
$Button6.Location              = New-Object System.Drawing.Point(10, 210)
$Button6.Font                  = New-Object System.Drawing.Font('Consolas',10)
$Button6.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Button7                       = New-Object System.Windows.Forms.Button
$Button7.FlatStyle             = 'Flat'
$Button7.Text                  = "Tweaks Explorer"
$Button7.width                 = 300
$Button7.height                = 30
$Button7.Location              = New-Object System.Drawing.Point(10, 250)
$Button7.Font                  = New-Object System.Drawing.Font('Consolas',10)
$Button7.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Button8                       = New-Object System.Windows.Forms.Button
$Button8.FlatStyle             = 'Flat'
$Button8.Text                  = "Repair PC"
$Button8.width                 = 300
$Button8.height                = 30
$Button8.Location              = New-Object System.Drawing.Point(10, 290)
$Button8.Font                  = New-Object System.Drawing.Font('Consolas',10)
$Button8.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Button9                       = New-Object System.Windows.Forms.Button
$Button9.FlatStyle             = 'Flat'
$Button9.Text                  = "?"
$Button9.width                 = 30
$Button9.height                = 30
$Button9.Location              = New-Object System.Drawing.Point(320, 10)
$Button9.Font                  = New-Object System.Drawing.Font('Consolas',14)
$Button9.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Button10                       = New-Object System.Windows.Forms.Button
$Button10.FlatStyle             = 'Flat'
$Button10.Text                  = "?"
$Button10.width                 = 30
$Button10.height                = 30
$Button10.Location              = New-Object System.Drawing.Point(320, 50)
$Button10.Font                  = New-Object System.Drawing.Font('Consolas',14)
$Button10.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Button11                       = New-Object System.Windows.Forms.Button
$Button11.FlatStyle             = 'Flat'
$Button11.Text                  = "?"
$Button11.width                 = 30
$Button11.height                = 30
$Button11.Location              = New-Object System.Drawing.Point(320, 90)
$Button11.Font                  = New-Object System.Drawing.Font('Consolas',14)
$Button11.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Button12                       = New-Object System.Windows.Forms.Button
$Button12.FlatStyle             = 'Flat'
$Button12.Text                  = "?"
$Button12.width                 = 30
$Button12.height                = 30
$Button12.Location              = New-Object System.Drawing.Point(320, 130)
$Button12.Font                  = New-Object System.Drawing.Font('Consolas',14)
$Button12.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Button13                       = New-Object System.Windows.Forms.Button
$Button13.FlatStyle             = 'Flat'
$Button13.Text                  = "?"
$Button13.width                 = 30
$Button13.height                = 30
$Button13.Location              = New-Object System.Drawing.Point(320, 170)
$Button13.Font                  = New-Object System.Drawing.Font('Consolas',14)
$Button13.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Button14                       = New-Object System.Windows.Forms.Button
$Button14.FlatStyle             = 'Flat'
$Button14.Text                  = "?"
$Button14.width                 = 30
$Button14.height                = 30
$Button14.Location              = New-Object System.Drawing.Point(320, 210)
$Button14.Font                  = New-Object System.Drawing.Font('Consolas',14)
$Button14.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Button15                       = New-Object System.Windows.Forms.Button
$Button15.FlatStyle             = 'Flat'
$Button15.Text                  = "?"
$Button15.width                 = 30
$Button15.height                = 30
$Button15.Location              = New-Object System.Drawing.Point(320, 250)
$Button15.Font                  = New-Object System.Drawing.Font('Consolas',14)
$Button15.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Button16                       = New-Object System.Windows.Forms.Button
$Button16.FlatStyle             = 'Flat'
$Button16.Text                  = "?"
$Button16.width                 = 30
$Button16.height                = 30
$Button16.Location              = New-Object System.Drawing.Point(320, 290)
$Button16.Font                  = New-Object System.Drawing.Font('Consolas',14)
$Button16.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

$Form.controls.AddRange(@($Button1,$Button2,$Button3,$Button4,$Button5,$Button6,$Button7,$Button8,$Button9,$Button10,$Button11,$Button12,$Button13,$Button14,$Button15,$Button16))

#################
### BLOATWARE ###
#################

$Button1.Add_Click( {
    $1CustomizeForm                  = New-Object System.Windows.Forms.Form
    $1CustomizeForm.ClientSize       = New-Object System.Drawing.Point(600,585)
    $1CustomizeForm.StartPosition    = 'CenterScreen'
    $1CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $1CustomizeForm.MinimizeBox      = $false
    $1CustomizeForm.MaximizeBox      = $true
    $1CustomizeForm.ShowIcon         = $false
    $1CustomizeForm.Text             = "Rimozione Bloatware"
    $1CustomizeForm.TopMost          = $false
    $1CustomizeForm.AutoScroll       = $true
    $1CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

    $ListPanel                     = New-Object system.Windows.Forms.Panel
    $ListPanel.height              = 510
    $ListPanel.width               = 590
    $ListPanel.Anchor              = 'top,right,left'
    $ListPanel.location            = New-Object System.Drawing.Point(10,10)
    $ListPanel.AutoScroll          = $true
    $ListPanel.BackColor           = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

    $1Bloatware                         = New-Object system.Windows.Forms.Label
    $1Bloatware.text                    = "(Le caselle Selezionate/Spuntate saranno rimosse)"
    $1Bloatware.AutoSize                = $true
    $1Bloatware.width                   = 10
    $1Bloatware.height                  = 10
    $1Bloatware.Anchor                  = 'top,left'
    $1Bloatware.location                = New-Object System.Drawing.Point(180,525)
    $1Bloatware.Font                    = New-Object System.Drawing.Font('Consolas',8,[System.Drawing.FontStyle]([System.Drawing.FontStyle]))
    $1Bloatware.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $1Button1                       = New-Object System.Windows.Forms.Button
    $1Button1.FlatStyle             = 'Flat'
    $1Button1.Text                  = "Salva Scelte"
    $1Button1.width                 = 285
    $1Button1.height                = 30
    $1Button1.Location              = New-Object System.Drawing.Point(10, 545)
    $1Button1.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $1Button1.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $1Button2                       = New-Object System.Windows.Forms.Button
    $1Button2.FlatStyle             = 'Flat'
    $1Button2.Text                  = "Rimuovi Bloatware"
    $1Button2.width                 = 285
    $1Button2.height                = 30
    $1Button2.Location              = New-Object System.Drawing.Point(305, 545)
    $1Button2.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $1Button2.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $1CustomizeForm.controls.AddRange(@($1Button1,$1Button2,$ListPanel,$1Bloatware))

    $1Button1.Add_Click( {
           # $ErrorActionPreference = 'SilentlyContinue'

            '$global:WhiteListedApps = @(' | Out-File -FilePath $PSScriptRoot\custom-lists.ps1 -Encoding utf8
            @($ListPanel.controls) | ForEach {
                if ($_ -is [System.Windows.Forms.CheckBox] -and $_.Enabled -and !$_.Checked) {
                    "    ""$( $_.Text )""" | Out-File -FilePath $PSScriptRoot\custom-lists.ps1 -Append -Encoding utf8
                }
            }
            ')' | Out-File -FilePath $PSScriptRoot\custom-lists.ps1 -Append -Encoding utf8

            '$global:Bloatware = @(' | Out-File -FilePath $PSScriptRoot\custom-lists.ps1 -Append -Encoding utf8
            @($ListPanel.controls) | ForEach {
                if ($_ -is [System.Windows.Forms.CheckBox] -and $_.Enabled -and $_.Checked) {
                    "    ""$($_.Text)""" | Out-File -FilePath $PSScriptRoot\custom-lists.ps1 -Append -Encoding utf8
                }
            }
            ')' | Out-File -FilePath $PSScriptRoot\custom-lists.ps1 -Append -Encoding utf8

            #Over-ride the white/blacklist with the newly saved custom list
            dotInclude custom-lists.ps1

            #convert to regular expression to allow for the super-useful -match operator
            $global:BloatwareRegex = $global:Bloatware -join '|'
            $global:WhiteListedAppsRegex = $global:WhiteListedApps -join '|'
        })

        $1Button2.Add_Click({ 
            $ErrorActionPreference = 'SilentlyContinue'
            Function DebloatBlacklist {
                Write-Host "Rimozione Bloatware..."
                Get-AppxPackage | Where-Object Name -cmatch $global:BloatwareRegex | Remove-AppxPackage
                Get-AppxProvisionedPackage -Online | Where-Object DisplayName -cmatch $global:BloatwareRegex | Remove-AppxProvisionedPackage -Online
                Get-AppxPackage -AllUsers | Where-Object Name -cmatch $global:BloatwareRegex | Remove-AppxPackage
            }
            DebloatBlacklist
                Function CheckDMWService {
            
                Param([switch]$Debloat)
            
                If (Get-Service dmwappushservice | Where-Object { $_.StartType -eq "Disabled" }) {
                    Set-Service dmwappushservice -StartupType Automatic
                }
            
                If (Get-Service dmwappushservice | Where-Object { $_.Status -eq "Stopped" }) {
                    Start-Service dmwappushservice
                } 
            }
            
            Function CheckInstallService {
            
                If (Get-Service InstallService | Where-Object { $_.Status -eq "Stopped" }) {  
                    Start-Service InstallService
                    Set-Service InstallService -StartupType Automatic 
                }
            }
            Write-Host "Completato"
            })
    

    Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }


    $Installed = @( (Get-AppxPackage).Name )
    $Online = @( (Get-AppxProvisionedPackage -Online).DisplayName )
    $AllUsers = @( (Get-AppxPackage -AllUsers).Name )
    [int]$checkboxCounter = 0
    
    ForEach ( $item in $global:WhiteListedApps ) {
        $string = ""
        if ( $null -notmatch $NonRemovables -and $NonRemovables -cmatch $item ) { $string += " Conflict NonRemovables " }
        if ( $null -notmatch $global:BloatwareRegex -and $item -cmatch $global:BloatwareRegex ) { $string += " ConflictBlacklist " }
        if ( $null -notmatch $Installed -and $Installed -cmatch $item) { $string += "Installed" }
        if ( $null -notmatch $AllUsers -and $AllUsers -cmatch $item) { $string += " AllUsers" }
        if ( $null -notmatch $Online -and $Online -cmatch $item) { $string += " Online" }
        AddAppToCustomizeForm $checkboxCounter $item $true $false $true $string
        ++$checkboxCounter
    }
    ForEach ( $item in $global:Bloatware ) {
        $string = ""
        if ( $null -notmatch $NonRemovables -and $NonRemovables -cmatch $item ) { $string += " Conflict NonRemovables " }
        if ( $null -notmatch $global:WhiteListedAppsRegex -and $item -cmatch $global:WhiteListedAppsRegex ) { $string += " Conflict Whitelist " }
        if ( $null -notmatch $Installed -and $Installed -cmatch $item) { $string += "Installed" }
        if ( $null -notmatch $AllUsers -and $AllUsers -cmatch $item) { $string += " AllUsers" }
        if ( $null -notmatch $Online -and $Online -cmatch $item) { $string += " Online" }
        AddAppToCustomizeForm $checkboxCounter $item $true $true $true $string
        ++$checkboxCounter
    }
    ForEach ( $item in $AllUsers ) {
        $string = "NEW   AllUsers"
        if ( $null -notmatch $NonRemovables -and $NonRemovables -cmatch $item ) { continue }
        if ( $null -notmatch $global:WhiteListedAppsRegex -and $item -cmatch $global:WhiteListedAppsRegex ) { continue }
        if ( $null -notmatch $global:BloatwareRegex -and $item -cmatch $global:BloatwareRegex ) { continue }
        if ( $null -notmatch $Installed -and $Installed -cmatch $item) { $string += " Installed" }
        if ( $null -notmatch $Online -and $Online -cmatch $item) { $string += " Online" }
        AddAppToCustomizeForm $checkboxCounter $item $true $true $true $string
        ++$checkboxCounter
    }
    ForEach ( $item in $Installed ) {
        $string = "NEW   Installed"
        if ( $null -notmatch $NonRemovables -and $NonRemovables -cmatch $item ) { continue }
        if ( $null -notmatch $global:WhiteListedAppsRegex -and $item -cmatch $global:WhiteListedAppsRegex ) { continue }
        if ( $null -notmatch $global:BloatwareRegex -and $item -cmatch $global:BloatwareRegex ) { continue }
        if ( $null -notmatch $AllUsers -and $AllUsers -cmatch $item) { continue }
        if ( $null -notmatch $Online -and $Online -cmatch $item) { $string += " Online" }
        AddAppToCustomizeForm $checkboxCounter $item $true $true $true $string
        ++$checkboxCounter
    }
    ForEach ( $item in $Online ) {
        $string = "NEW   Online "
        if ( $null -notmatch $NonRemovables -and $NonRemovables -cmatch $item ) { continue }
        if ( $null -notmatch $global:WhiteListedAppsRegex -and $item -cmatch $global:WhiteListedAppsRegex ) { continue }
        if ( $null -notmatch $global:BloatwareRegex -and $item -cmatch $global:BloatwareRegex ) { continue }
        if ( $null -notmatch $Installed -and $Installed -cmatch $item) { continue }
        if ( $null -notmatch $AllUsers -and $AllUsers -cmatch $item) { continue }
        AddAppToCustomizeForm $checkboxCounter $item $true $true $true $string
        ++$checkboxCounter
    }
    [void]$1CustomizeForm.ShowDialog()
})

#####################
### END BLOATWARE ###
#####################

##################
### CHOCOLATEY ###
##################

$Button2.Add_Click({
    $2CustomizeForm                  = New-Object System.Windows.Forms.Form
    $2CustomizeForm.ClientSize       = New-Object System.Drawing.Point(570,875)
    $2CustomizeForm.StartPosition    = 'CenterScreen'
    $2CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $2CustomizeForm.MinimizeBox      = $false
    $2CustomizeForm.MaximizeBox      = $true
    $2CustomizeForm.ShowIcon         = $false
    $2CustomizeForm.Text             = "Installa Software"
    $2CustomizeForm.TopMost          = $false
    $2CustomizeForm.AutoScroll       = $true
    $2CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

    $21                       = New-Object System.Windows.Forms.Button
    $21.FlatStyle             = 'Flat'
    $21.Text                  = "Installa Chocolatey"
    $21.width                 = 180
    $21.height                = 30
    $21.Location              = New-Object System.Drawing.Point(10, 10)
    $21.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $21.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $21.Add_Click({ 
        Write-Host "Installando Chocolatey"
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        choco install chocolatey-core.extension -y
        Write-host "Completato"
    })
    
    $22                       = New-Object System.Windows.Forms.Button
    $22.FlatStyle             = 'Flat'
    $22.Text                  = "Daily Task Update"
    $22.width                 = 180
    $22.height                = 30
    $22.Location              = New-Object System.Drawing.Point(195, 10)
    $22.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $22.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $22.Add_Click({ 
        Write-Host "Creating daily task to automatically upgrade Chocolatey packages"
        # adapted from https://blogs.technet.microsoft.com/heyscriptingguy/2013/11/23/using-scheduled-tasks-and-scheduled-jobs-in-powershell/
        # Find it on "Microsoft\Windows\PowerShell\ScheduledJobs\Chocolatey Daily Upgrade"
        $JobName = "Chocolatey Daily Upgrade"
        $ScheduledJob = @{
            Name = $JobName
            ScriptBlock = {choco upgrade all -y}
            Trigger = New-JobTrigger -Daily -At 00:00
            ScheduledJobOption = New-ScheduledJobOption -RunElevated -MultipleInstancePolicy StopExisting -RequireNetwork
        }
        Write-host "Completato"
    })
    
    $23                       = New-Object System.Windows.Forms.Button
    $23.FlatStyle             = 'Flat'
    $23.Text                  = "Cerca Aggiornamenti"
    $23.width                 = 180
    $23.height                = 30
    $23.Location              = New-Object System.Drawing.Point(380, 10)
    $23.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $23.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $23.Add_Click({ 
        Write-Host "Ricerca Aggiornamenti"
        choco upgrade all -y
            Write-host "Completato"
    })  
        
    $2p1                         = New-Object system.Windows.Forms.Label
    $2p1.text                    = "Neccesario Chocolatey per installare i seguenti Software:"
    $2p1.AutoSize                = $true
    $2p1.width                   = 300
    $2p1.height                  = 100
    $2p1.Anchor                  = 'top,left'
    $2p1.location                = New-Object System.Drawing.Point(140,47)
    $2p1.Font                    = New-Object System.Drawing.Font('Consolas',9,[System.Drawing.FontStyle]([System.Drawing.FontStyle]))
    $2p1.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $24                       = New-Object System.Windows.Forms.Button
    $24.FlatStyle             = 'Flat'
    $24.Text                  = "7-Zip"
    $24.width                 = 100
    $24.height                = 30
    $24.Location              = New-Object System.Drawing.Point(10, 75)
    $24.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $24.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $24.Add_Click({ 
        Write-Host "Installando 7-Zip"
        choco install 7zip -y
            Write-host "Completato"
    })    

    $25                       = New-Object System.Windows.Forms.Button
    $25.FlatStyle             = 'Flat'
    $25.Text                  = "Peazip"
    $25.width                 = 100
    $25.height                = 30
    $25.Location              = New-Object System.Drawing.Point(120, 75)
    $25.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $25.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $25.Add_Click({ 
        Write-Host "Installando Peazip"
        choco install peazip.install -y
            Write-host "Completato"
    })    	
    
    $26                       = New-Object System.Windows.Forms.Button
    $26.FlatStyle             = 'Flat'
    $26.Text                  = "Winrar"
    $26.width                 = 100
    $26.height                = 30
    $26.Location              = New-Object System.Drawing.Point(230, 75)
    $26.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $26.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $26.Add_Click({ 
        Write-Host "Installando Winrar"
        choco install winrar -y
            Write-host "Completato"
    })    
    
    $27                       = New-Object System.Windows.Forms.Button
    $27.FlatStyle             = 'Flat'
    $27.Text                  = "Chrome"
    $27.width                 = 100
    $27.height                = 30
    $27.Location              = New-Object System.Drawing.Point(10, 115)
    $27.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $27.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $27.Add_Click({ 
        Write-Host "Installando Google Chrome"
    choco install googlechrome -y
    Write-host "Completato"
    })    
    
    $28                       = New-Object System.Windows.Forms.Button
    $28.FlatStyle             = 'Flat'
    $28.Text                  = "Firefox"
    $28.width                 = 100
    $28.height                = 30
    $28.Location              = New-Object System.Drawing.Point(120, 115)
    $28.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $28.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $28.Add_Click({ 
        Write-Host "Installando Mozilla Firefox"
    choco install firefox -y
    Write-host "Completato"
    })    
    
    $29                       = New-Object System.Windows.Forms.Button
    $29.FlatStyle             = 'Flat'
    $29.Text                  = "Opera"
    $29.width                 = 100
    $29.height                = 30
    $29.Location              = New-Object System.Drawing.Point(230, 115)
    $29.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $29.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $29.Add_Click({ 
        Write-Host "Installando Opera"
        choco install opera -y
    Write-host "Completato"
    })    
    
    $210                       = New-Object System.Windows.Forms.Button
    $210.FlatStyle             = 'Flat'
    $210.Text                  = "Midori"
    $210.width                 = 100
    $210.height                = 30
    $210.Location              = New-Object System.Drawing.Point(340, 115)
    $210.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $210.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $210.Add_Click({ 
        Write-Host "Installando Midori"
    choco install midori-browser -y
    Write-host "Completato"
    })   
    
    $211                       = New-Object System.Windows.Forms.Button
    $211.FlatStyle             = 'Flat'
    $211.Text                  = "VLC"
    $211.width                 = 100
    $211.height                = 30
    $211.Location              = New-Object System.Drawing.Point(10, 155)
    $211.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $211.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $211.Add_Click({ 
        Write-Host "Installando VLC"
        choco install vlc -y
    Write-host "Completato"
    })       
 
    $212                       = New-Object System.Windows.Forms.Button
    $212.FlatStyle             = 'Flat'
    $212.Text                  = "K-Lite Mega"
    $212.width                 = 100
    $212.height                = 30
    $212.Location              = New-Object System.Drawing.Point(120, 155)
    $212.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $212.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $212.Add_Click({ 
        Write-Host "Installando K-Lite Mega"
        choco install k-litecodecpackmega -y
    Write-host "Completato"
    })   

    $213                       = New-Object System.Windows.Forms.Button
    $213.FlatStyle             = 'Flat'
    $213.Text                  = "Kodi"
    $213.width                 = 100
    $213.height                = 30
    $213.Location              = New-Object System.Drawing.Point(230, 155)
    $213.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $213.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $213.Add_Click({ 
        Write-Host "Installando Kodi"
        choco install kodi -y
    Write-host "Completato"
    })   

    $214                       = New-Object System.Windows.Forms.Button
    $214.FlatStyle             = 'Flat'
    $214.Text                  = "Telegram"
    $214.width                 = 100
    $214.height                = 30
    $214.Location              = New-Object System.Drawing.Point(10, 195)
    $214.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $214.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $214.Add_Click({ 
        Write-Host "Installando Telegram"
        choco install telegram -y
    Write-host "Completato"
    }) 

    $215                       = New-Object System.Windows.Forms.Button
    $215.FlatStyle             = 'Flat'
    $215.Text                  = "Whatsapp"
    $215.width                 = 100
    $215.height                = 30
    $215.Location              = New-Object System.Drawing.Point(120, 195)
    $215.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $215.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $215.Add_Click({ 
        Write-Host "Installando Whatsapp"
        choco install whatsapp -y
    Write-host "Completato"
    })   

    $216                       = New-Object System.Windows.Forms.Button
    $216.FlatStyle             = 'Flat'
    $216.Text                  = "Discord"
    $216.width                 = 100
    $216.height                = 30
    $216.Location              = New-Object System.Drawing.Point(230, 195)
    $216.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $216.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $216.Add_Click({ 
        Write-Host "Installando Discord"
        choco install discord.install -y
    Write-host "Completato"
    })   

    $217                       = New-Object System.Windows.Forms.Button
    $217.FlatStyle             = 'Flat'
    $217.Text                  = "Signal"
    $217.width                 = 100
    $217.height                = 30
    $217.Location              = New-Object System.Drawing.Point(340, 195)
    $217.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $217.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $217.Add_Click({ 
        Write-Host "Installando Signal"
        choco install signal -y
    Write-host "Completato"
    })   

    $218                       = New-Object System.Windows.Forms.Button
    $218.FlatStyle             = 'Flat'
    $218.Text                  = "Ms Teams"
    $218.width                 = 100
    $218.height                = 30
    $218.Location              = New-Object System.Drawing.Point(450, 195)
    $218.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $218.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $218.Add_Click({ 
        Write-Host "Installando Microsoft Teams"
        choco install microsoft-teams.install -y
    Write-host "Completato, Assicurati di riavviare il Pc"
    })   

    $219                       = New-Object System.Windows.Forms.Button
    $219.FlatStyle             = 'Flat'
    $219.Text                  = "Anydesk"
    $219.width                 = 100
    $219.height                = 30
    $219.Location              = New-Object System.Drawing.Point(10, 235)
    $219.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $219.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $219.Add_Click({ 
        Write-Host "Installando Anydesk"
        choco install anydesk -y
    Write-host "Completato"
    })   

    $220                       = New-Object System.Windows.Forms.Button
    $220.FlatStyle             = 'Flat'
    $220.Text                  = "TeamViewer"
    $220.width                 = 100
    $220.height                = 30
    $220.Location              = New-Object System.Drawing.Point(120, 235)
    $220.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $220.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $220.Add_Click({ 
        Write-Host "Installando TeamViewer"
        choco install teamviewer -y
    Write-host "Completato"
    })
    
    $221                       = New-Object System.Windows.Forms.Button
    $221.FlatStyle             = 'Flat'
    $221.Text                  = "Parsec"
    $221.width                 = 100
    $221.height                = 30
    $221.Location              = New-Object System.Drawing.Point(230, 235)
    $221.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $221.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $221.Add_Click({ 
        Write-Host "Installando Parsec"
        choco install parsec -y
    Write-host "Completato"
    })   

    $222                       = New-Object System.Windows.Forms.Button
    $222.FlatStyle             = 'Flat'
    $222.Text                  = "PDF24"
    $222.width                 = 100
    $222.height                = 30
    $222.Location              = New-Object System.Drawing.Point(10, 275)
    $222.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $222.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $222.Add_Click({ 
        Write-Host "Installando PDF24"
        choco install pdf24 -y
    Write-host "Completato"
    })   

    $223                       = New-Object System.Windows.Forms.Button
    $223.FlatStyle             = 'Flat'
    $223.Text                  = "Okular"
    $223.width                 = 100
    $223.height                = 30
    $223.Location              = New-Object System.Drawing.Point(120, 275)
    $223.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $223.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $223.Add_Click({ 
        Write-Host "Installando Okular"
        choco install okular -y
    Write-host "Completato"
    })   

    $224                       = New-Object System.Windows.Forms.Button
    $224.FlatStyle             = 'Flat'
    $224.Text                  = "Adobe Reader"
    $224.width                 = 100
    $224.height                = 30
    $224.Location              = New-Object System.Drawing.Point(230, 275)
    $224.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $224.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $224.Add_Click({ 
        Write-Host "Installando Adobe Reader"
        choco install adobereader -y
    Write-host "Completato"
    })   

    $225                       = New-Object System.Windows.Forms.Button
    $225.FlatStyle             = 'Flat'
    $225.Text                  = "Foxit Reader"
    $225.width                 = 100
    $225.height                = 30
    $225.Location              = New-Object System.Drawing.Point(340, 275)
    $225.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $225.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $225.Add_Click({ 
        Write-Host "Installando Foxit Reader"
        choco install foxitreader -y
    Write-host "Completato"
    })   

    $226                       = New-Object System.Windows.Forms.Button
    $226.FlatStyle             = 'Flat'
    $226.Text                  = "Notepad++"
    $226.width                 = 100
    $226.height                = 30
    $226.Location              = New-Object System.Drawing.Point(10, 315)
    $226.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $226.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $226.Add_Click({ 
        Write-Host "Installando Notepad++"
        choco install notepadplusplus -y
    Write-host "Completato"
    })   

    $227                       = New-Object System.Windows.Forms.Button
    $227.FlatStyle             = 'Flat'
    $227.Text                  = "VS Code"
    $227.width                 = 100
    $227.height                = 30
    $227.Location              = New-Object System.Drawing.Point(120, 315)
    $227.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $227.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $227.Add_Click({ 
        Write-Host "Installando Visual Studio Code"
        choco install vscode -y
    Write-host "Completato"
    })   

    $228                       = New-Object System.Windows.Forms.Button
    $228.FlatStyle             = 'Flat'
    $228.Text                  = "LibreOffice"
    $228.width                 = 100
    $228.height                = 30
    $228.Location              = New-Object System.Drawing.Point(230, 315)
    $228.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $228.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $228.Add_Click({ 
        Write-Host "Installando LibreOffice"
        choco install libreoffice-fresh -y
    Write-host "Completato"
    })   

    $229                       = New-Object System.Windows.Forms.Button
    $229.FlatStyle             = 'Flat'
    $229.Text                  = "OpenOffice"
    $229.width                 = 100
    $229.height                = 30
    $229.Location              = New-Object System.Drawing.Point(340, 315)
    $229.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $229.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $229.Add_Click({ 
        Write-Host "Installando OpenOffice"
        choco install onlyoffice -y
    Write-host "Completato"
    })   

    $230                       = New-Object System.Windows.Forms.Button
    $230.FlatStyle             = 'Flat'
    $230.Text                  = "Radmin-VPN"
    $230.width                 = 100
    $230.height                = 30
    $230.Location              = New-Object System.Drawing.Point(10, 355)
    $230.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $230.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $230.Add_Click({ 
        Write-Host "Installando Radmin-VPN"
        choco install radmin-vpn -y
    Write-host "Completato"
    })     

    $231                       = New-Object System.Windows.Forms.Button
    $231.FlatStyle             = 'Flat'
    $231.Text                  = "Putty"
    $231.width                 = 100
    $231.height                = 30
    $231.Location              = New-Object System.Drawing.Point(120, 355)
    $231.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $231.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $231.Add_Click({ 
        Write-Host "Installando Putty"
        choco install putty -y
    Write-host "Completato"
    })   

    $232                       = New-Object System.Windows.Forms.Button
    $232.FlatStyle             = 'Flat'
    $232.Text                  = "Filezilla"
    $232.width                 = 100
    $232.height                = 30
    $232.Location              = New-Object System.Drawing.Point(230, 355)
    $232.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $232.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $232.Add_Click({ 
        Write-Host "Installando Filezilla"
        choco install filezilla -y
    Write-host "Completato"
    })   

    $233                       = New-Object System.Windows.Forms.Button
    $233.FlatStyle             = 'Flat'
    $233.Text                  = "Wireshark"
    $233.width                 = 100
    $233.height                = 30
    $233.Location              = New-Object System.Drawing.Point(340, 355)
    $233.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $233.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $233.Add_Click({ 
        Write-Host "Installando Wireshark"
        choco install wireshark -y
    Write-host "Completato"
    })   
     
    $234                       = New-Object System.Windows.Forms.Button
    $234.FlatStyle             = 'Flat'
    $234.Text                  = "Megasync"
    $234.width                 = 100
    $234.height                = 30
    $234.Location              = New-Object System.Drawing.Point(10, 395)
    $234.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $234.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $234.Add_Click({ 
        Write-Host "Installando Megasync"
        choco install megasync -y
    Write-host "Completato"
    })   

    $235                       = New-Object System.Windows.Forms.Button
    $235.FlatStyle             = 'Flat'
    $235.Text                  = "Resilio Sync"
    $235.width                 = 100
    $235.height                = 30
    $235.Location              = New-Object System.Drawing.Point(120, 395)
    $235.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $235.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $235.Add_Click({ 
        Write-Host "Installando Resilio Sync"
        choco install resilio-sync-home -y
    Write-host "Completato"
    })   

    $236                       = New-Object System.Windows.Forms.Button
    $236.FlatStyle             = 'Flat'
    $236.Text                  = "SynologyDrive"
    $236.width                 = 100
    $236.height                = 30
    $236.Location              = New-Object System.Drawing.Point(230, 395)
    $236.Font                  = New-Object System.Drawing.Font('Consolas',8)
    $236.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $236.Add_Click({ 
        Write-Host "Installando Synology Drive"
        choco install cloudstation -y
    Write-host "Completato"
    })   
    
    $237                       = New-Object System.Windows.Forms.Button
    $237.FlatStyle             = 'Flat'
    $237.Text                  = "Steam"
    $237.width                 = 100
    $237.height                = 30
    $237.Location              = New-Object System.Drawing.Point(10, 435)
    $237.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $237.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $237.Add_Click({ 
        Write-Host "Installando Steam"
        choco install steam -y
    Write-host "Completato"
    })   

    $238                       = New-Object System.Windows.Forms.Button
    $238.FlatStyle             = 'Flat'
    $238.Text                  = "Antimicro"
    $238.width                 = 100
    $238.height                = 30
    $238.Location              = New-Object System.Drawing.Point(120, 435)
    $238.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $238.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $238.Add_Click({ 
        Write-Host "Installando Antimicro"
        choco install antimicro -y
    Write-host "Completato"
    })   

    $239                       = New-Object System.Windows.Forms.Button
    $239.FlatStyle             = 'Flat'
    $239.Text                  = "RetroArch"
    $239.width                 = 100
    $239.height                = 30
    $239.Location              = New-Object System.Drawing.Point(230, 435)
    $239.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $239.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $239.Add_Click({ 
        Write-Host "Installando RetroArch"
        choco install retroarch -y
    Write-host "Completato"
    })   

    $240                       = New-Object System.Windows.Forms.Button
    $240.FlatStyle             = 'Flat'
    $240.Text                  = "Qbittorrent"
    $240.width                 = 100
    $240.height                = 30
    $240.Location              = New-Object System.Drawing.Point(10, 475)
    $240.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $240.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $240.Add_Click({ 
        Write-Host "Installando Qbitorrent"
        choco install qbittorrent -y
    Write-host "Completato"
    })   

    $241                       = New-Object System.Windows.Forms.Button
    $241.FlatStyle             = 'Flat'
    $241.Text                  = "JDownloader"
    $241.width                 = 100
    $241.height                = 30
    $241.Location              = New-Object System.Drawing.Point(120, 475)
    $241.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $241.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $241.Add_Click({ 
        Write-Host "Installando JDwonloader"
        choco install jdownloader -y
    Write-host "Completato"
    })   

    $242                       = New-Object System.Windows.Forms.Button
    $242.FlatStyle             = 'Flat'
    $242.Text                  = "IDM"
    $242.width                 = 100
    $242.height                = 30
    $242.Location              = New-Object System.Drawing.Point(230, 475)
    $242.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $242.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $242.Add_Click({ 
        Write-Host "Installando Internet Download Manager"
        choco install internet-download-manager -y
    Write-host "Completato"
    })   

    $243                       = New-Object System.Windows.Forms.Button
    $243.FlatStyle             = 'Flat'
    $243.Text                  = "OldCalculator"
    $243.width                 = 100
    $243.height                = 30
    $243.Location              = New-Object System.Drawing.Point(10, 515)
    $243.Font                  = New-Object System.Drawing.Font('Consolas',8)
    $243.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $243.Add_Click({ 
        Write-Host "Installando OldCalculator"
        choco install oldcalc -y
    Write-host "Completato"
    })  

    $244                       = New-Object System.Windows.Forms.Button
    $244.FlatStyle             = 'Flat'
    $244.Text                  = "ProceXp"
    $244.width                 = 100
    $244.height                = 30
    $244.Location              = New-Object System.Drawing.Point(120, 515)
    $244.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $244.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $244.Add_Click({ 
        Write-Host "Installando ProceXP"
        choco install procexp -y
    Write-host "Completato"
    })  

    $245                       = New-Object System.Windows.Forms.Button
    $245.FlatStyle             = 'Flat'
    $245.Text                  = "Windows Terminal"
    $245.width                 = 100
    $245.height                = 30
    $245.Location              = New-Object System.Drawing.Point(230, 515)
    $245.Font                  = New-Object System.Drawing.Font('Consolas',7)
    $245.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $245.Add_Click({ 
        Write-Host "Installando Windows Terminal"
        choco install microsoft-windows-terminal -y
    Write-host "Completato"
    }) 

    $246                       = New-Object System.Windows.Forms.Button
    $246.FlatStyle             = 'Flat'
    $246.Text                  = "PowerToys"
    $246.width                 = 100
    $246.height                = 30
    $246.Location              = New-Object System.Drawing.Point(340, 515)
    $246.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $246.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $246.Add_Click({ 
        Write-Host "Installando PowerToys"
        choco install powertoys -y
    Write-host "Completato"
    })  

    $247                       = New-Object System.Windows.Forms.Button
    $247.FlatStyle             = 'Flat'
    $247.Text                  = "WinAero Tweaker"
    $247.width                 = 100
    $247.height                = 30
    $247.Location              = New-Object System.Drawing.Point(450, 515)
    $247.Font                  = New-Object System.Drawing.Font('Consolas',7)
    $247.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $247.Add_Click({ 
        Write-Host "Installando WinaeroTweaker"
        choco install winaero-tweaker -y
    Write-host "Completato"
    })  

    $248                       = New-Object System.Windows.Forms.Button
    $248.FlatStyle             = 'Flat'
    $248.Text                  = "IrfanView"
    $248.width                 = 100
    $248.height                = 30
    $248.Location              = New-Object System.Drawing.Point(10, 555)
    $248.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $248.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $248.Add_Click({ 
        Write-Host "Installando Irfanview"
        choco install irfanview -y
    Write-host "Completato"
    })  

    $249                       = New-Object System.Windows.Forms.Button
    $249.FlatStyle             = 'Flat'
    $249.Text                  = "Bitwarden"
    $249.width                 = 100
    $249.height                = 30
    $249.Location              = New-Object System.Drawing.Point(120, 555)
    $249.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $249.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $249.Add_Click({ 
        Write-Host "Installando Bitwarden"
        choco install bitwarden -y
    Write-host "Completato"
    })  

    $250                       = New-Object System.Windows.Forms.Button
    $250.FlatStyle             = 'Flat'
    $250.Text                  = "EarTrumpet"
    $250.width                 = 100
    $250.height                = 30
    $250.Location              = New-Object System.Drawing.Point(230, 555)
    $250.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $250.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $250.Add_Click({ 
        Write-Host "Installando EarTrumpet"
        choco install eartrumpet -y
    Write-host "Completato"
    }) 

    $251                       = New-Object System.Windows.Forms.Button
    $251.FlatStyle             = 'Flat'
    $251.Text                  = "Spotify"
    $251.width                 = 100
    $251.height                = 30
    $251.Location              = New-Object System.Drawing.Point(340, 555)
    $251.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $251.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $251.Add_Click({ 
        Write-Host "Installando Spotify"
        choco install spotify -y
    Write-host "Completato"
    })  

    $252                       = New-Object System.Windows.Forms.Button
    $252.FlatStyle             = 'Flat'
    $252.Text                  = "KDE Connect"
    $252.width                 = 100
    $252.height                = 30
    $252.Location              = New-Object System.Drawing.Point(450, 555)
    $252.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $252.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $252.Add_Click({ 
        Write-Host "Installando KDE Connect"
        choco install kdeconnect-kde -y
    Write-host "Completato"
    })  
    
    $253                       = New-Object System.Windows.Forms.Button
    $253.FlatStyle             = 'Flat'
    $253.Text                  = "MalwareBytes"
    $253.width                 = 100
    $253.height                = 30
    $253.Location              = New-Object System.Drawing.Point(10, 595)
    $253.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $253.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $253.Add_Click({ 
        Write-Host "Installando MalwareBytes"
        choco install malwarebytes -y
    Write-host "Completato"
    })  

    $254                       = New-Object System.Windows.Forms.Button
    $254.FlatStyle             = 'Flat'
    $254.Text                  = "Thunderbird"
    $254.width                 = 100
    $254.height                = 30
    $254.Location              = New-Object System.Drawing.Point(120, 595)
    $254.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $254.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $254.Add_Click({ 
        Write-Host "Installando Thunderbird"
        choco install thunderbird -y
    Write-host "Completato"
    })  
    
    $255                       = New-Object System.Windows.Forms.Button
    $255.FlatStyle             = 'Flat'
    $255.Text                  = "OBS Studio"
    $255.width                 = 100
    $255.height                = 30
    $255.Location              = New-Object System.Drawing.Point(230, 595)
    $255.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $255.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $255.Add_Click({ 
        Write-Host "Installando OBS Studio"
        choco install obs-studio -y
    Write-host "Completato"
    })  

    $256                       = New-Object System.Windows.Forms.Button
    $256.FlatStyle             = 'Flat'
    $256.Text                  = "Logitech Options"
    $256.width                 = 100
    $256.height                = 30
    $256.Location              = New-Object System.Drawing.Point(340, 595)
    $256.Font                  = New-Object System.Drawing.Font('Consolas',7)
    $256.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $256.Add_Click({ 
        Write-Host "Installando Logitech Options"
        choco install logitech-options -y
    Write-host "Completato"
    })  

    $257                       = New-Object System.Windows.Forms.Button
    $257.FlatStyle             = 'Flat'
    $257.Text                  = "Calibre"
    $257.width                 = 100
    $257.height                = 30
    $257.Location              = New-Object System.Drawing.Point(450, 595)
    $257.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $257.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $257.Add_Click({ 
        Write-Host "Installando Calibre"
        choco install calibre -y
    Write-host "Completato"
    })  

    $258                       = New-Object System.Windows.Forms.Button
    $258.FlatStyle             = 'Flat'
    $258.Text                  = "MKVToolnix"
    $258.width                 = 100
    $258.height                = 30
    $258.Location              = New-Object System.Drawing.Point(10, 635)
    $258.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $258.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $258.Add_Click({ 
        Write-Host "Installando MKV Toolnix"
        choco install mkvtoolnix -y
    Write-host "Completato"
    })  

    $259                       = New-Object System.Windows.Forms.Button
    $259.FlatStyle             = 'Flat'
    $259.Text                  = "Audacity"
    $259.width                 = 100
    $259.height                = 30
    $259.Location              = New-Object System.Drawing.Point(120, 635)
    $259.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $259.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $259.Add_Click({ 
        Write-Host "Installando Audacity"
        choco install audacity -y
    Write-host "Completato"
    })  

    $260                       = New-Object System.Windows.Forms.Button
    $260.FlatStyle             = 'Flat'
    $260.Text                  = "Imgburn"
    $260.width                 = 100
    $260.height                = 30
    $260.Location              = New-Object System.Drawing.Point(230, 635)
    $260.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $260.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $260.Add_Click({ 
        Write-Host "Installando Imgburn"
        choco install imgburn -y
    Write-host "Completato"
    })  

    $261                       = New-Object System.Windows.Forms.Button
    $261.FlatStyle             = 'Flat'
    $261.Text                  = "Sharex"
    $261.width                 = 100
    $261.height                = 30
    $261.Location              = New-Object System.Drawing.Point(340, 635)
    $261.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $261.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $261.Add_Click({ 
        Write-Host "Installando Sharex"
        choco install sharex -y
    Write-host "Completato"
    })  

    $262                       = New-Object System.Windows.Forms.Button
    $262.FlatStyle             = 'Flat'
    $262.Text                  = "Gimp"
    $262.width                 = 100
    $262.height                = 30
    $262.Location              = New-Object System.Drawing.Point(450, 635)
    $262.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $262.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $262.Add_Click({ 
        Write-Host "Installando Gimp"
        choco install gimp -y
    Write-host "Completato"
    })  

    $263                       = New-Object System.Windows.Forms.Button
    $263.FlatStyle             = 'Flat'
    $263.Text                  = "Directx"
    $263.width                 = 100
    $263.height                = 30
    $263.Location              = New-Object System.Drawing.Point(10, 675)
    $263.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $263.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $263.Add_Click({ 
        Write-Host "Installando Directx"
        choco install directx -y
    Write-host "Completato"
    })  

    $264                       = New-Object System.Windows.Forms.Button
    $264.FlatStyle             = 'Flat'
    $264.Text                  = ".Net"
    $264.width                 = 100
    $264.height                = 30
    $264.Location              = New-Object System.Drawing.Point(120, 675)
    $264.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $264.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $264.Add_Click({ 
        Write-Host "Installando .NET"
        choco install dotnet -y
        choco install dotnet4.7 -y
        choco install dotnetfx -y
    Write-host "Completato"
    })  

    $265                       = New-Object System.Windows.Forms.Button
    $265.FlatStyle             = 'Flat'
    $265.Text                  = "Visual C++"
    $265.width                 = 100
    $265.height                = 30
    $265.Location              = New-Object System.Drawing.Point(230, 675)
    $265.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $265.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $265.Add_Click({ 
        Write-Host "Installando Visual C++"
        choco install vcredist2005 -y
        choco install vcredist2008 -y
        choco install vcredist2010 -y
        choco install vcredist2012 -y
        choco install vcredist2013 -y
        choco install vcredist140 -y
    Write-host "Completato"
    })  

    $266                       = New-Object System.Windows.Forms.Button
    $266.FlatStyle             = 'Flat'
    $266.Text                  = "Java"
    $266.width                 = 100
    $266.height                = 30
    $266.Location              = New-Object System.Drawing.Point(340, 675)
    $266.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $266.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $266.Add_Click({ 
        Write-Host "Installando Java"
        choco install jre8
    Write-host "Completato"
    })  

    $267                       = New-Object System.Windows.Forms.Button
    $267.FlatStyle             = 'Flat'
    $267.Text                  = "Python"
    $267.width                 = 100
    $267.height                = 30
    $267.Location              = New-Object System.Drawing.Point(450, 675)
    $267.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $267.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $267.Add_Click({ 
        Write-Host "Installando Python"
        choco install python -y
    Write-host "Completato"
    })  

    $268                       = New-Object System.Windows.Forms.Button
    $268.FlatStyle             = 'Flat'
    $268.Text                  = "VirtualBox"
    $268.width                 = 100
    $268.height                = 30
    $268.Location              = New-Object System.Drawing.Point(10, 715)
    $268.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $268.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $268.Add_Click({ 
        Write-Host "Installando VirtualBox"
        choco install virtualbox -y
    Write-host "Completato"
    })  

    $269                       = New-Object System.Windows.Forms.Button
    $269.FlatStyle             = 'Flat'
    $269.Text                  = "VMware Tools"
    $269.width                 = 100
    $269.height                = 30
    $269.Location              = New-Object System.Drawing.Point(120, 715)
    $269.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $269.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $269.Add_Click({ 
        Write-Host "Installando VMWare Tools"
        choco install vmware-tools -y
    Write-host "Completato"
    })  

    $270                       = New-Object System.Windows.Forms.Button
    $270.FlatStyle             = 'Flat'
    $270.Text                  = "Samsung Magician"
    $270.width                 = 100
    $270.height                = 30
    $270.Location              = New-Object System.Drawing.Point(230, 715)
    $270.Font                  = New-Object System.Drawing.Font('Consolas',7)
    $270.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $270.Add_Click({ 
        Write-Host "Installando Samsung Magician"
        choco install samsung-magician -y
    Write-host "Completato"
    })  

    $271                       = New-Object System.Windows.Forms.Button
    $271.FlatStyle             = 'Flat'
    $271.Text                  = "BleachBit"
    $271.width                 = 100
    $271.height                = 30
    $271.Location              = New-Object System.Drawing.Point(340, 715)
    $271.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $271.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $271.Add_Click({ 
        Write-Host "Installando BleachBit"
        choco install bleachbit -y
    Write-host "Completato"
    })  

    $272                       = New-Object System.Windows.Forms.Button
    $272.FlatStyle             = 'Flat'
    $272.Text                  = "Ccleaner"
    $272.width                 = 100
    $272.height                = 30
    $272.Location              = New-Object System.Drawing.Point(450, 715)
    $272.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $272.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $272.Add_Click({ 
        Write-Host "Installando Ccleaner"
        choco install ccleaner -y
    Write-host "Completato"
    })  

    $273                       = New-Object System.Windows.Forms.Button
    $273.FlatStyle             = 'Flat'
    $273.Text                  = "CPU-Z"
    $273.width                 = 100
    $273.height                = 30
    $273.Location              = New-Object System.Drawing.Point(10, 755)
    $273.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $273.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $273.Add_Click({ 
        Write-Host "Installando CPU-Z"
        choco install cpu-z -y
    Write-host "Completato"
    })  

    $274                       = New-Object System.Windows.Forms.Button
    $274.FlatStyle             = 'Flat'
    $274.Text                  = "GPU-Z"
    $274.width                 = 100
    $274.height                = 30
    $274.Location              = New-Object System.Drawing.Point(120, 755)
    $274.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $274.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $274.Add_Click({ 
        Write-Host "Installando GPU-Z"
        choco install gpu-z -y
    Write-host "Completato"
    })  

    $275                       = New-Object System.Windows.Forms.Button
    $275.FlatStyle             = 'Flat'
    $275.Text                  = "HWInfo"
    $275.width                 = 100
    $275.height                = 30
    $275.Location              = New-Object System.Drawing.Point(230, 755)
    $275.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $275.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $275.Add_Click({ 
        Write-Host "Installando HWInfo"
        choco install hwinfo -y
    Write-host "Completato"
    })  

    $276                       = New-Object System.Windows.Forms.Button
    $276.FlatStyle             = 'Flat'
    $276.Text                  = "TPCView"
    $276.width                 = 100
    $276.height                = 30
    $276.Location              = New-Object System.Drawing.Point(340, 755)
    $276.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $276.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $276.Add_Click({ 
        Write-Host "Installando TPCView"
        choco install tcpview -y
    Write-host "Completato"
    })  

    $277                       = New-Object System.Windows.Forms.Button
    $277.FlatStyle             = 'Flat'
    $277.Text                  = "ProcessHacker"
    $277.width                 = 100
    $277.height                = 30
    $277.Location              = New-Object System.Drawing.Point(450, 755)
    $277.Font                  = New-Object System.Drawing.Font('Consolas',8)
    $277.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $277.Add_Click({ 
        Write-Host "Installando ProcessHacker"
        choco install processhacker -y
    Write-host "Completato"
    })  
    
    $278                       = New-Object System.Windows.Forms.Button
    $278.FlatStyle             = 'Flat'
    $278.Text                  = "CrystalDisk Info"
    $278.width                 = 100
    $278.height                = 30
    $278.Location              = New-Object System.Drawing.Point(10, 795)
    $278.Font                  = New-Object System.Drawing.Font('Consolas',7)
    $278.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $278.Add_Click({ 
        Write-Host "Installando CrystalDisk Info"
        choco install crystaldiskinfo.portable -y
    Write-host "Completato"
    })  

    $279                       = New-Object System.Windows.Forms.Button
    $279.FlatStyle             = 'Flat'
    $279.Text                  = "CrystalDisk Mark"
    $279.width                 = 100
    $279.height                = 30
    $279.Location              = New-Object System.Drawing.Point(120, 795)
    $279.Font                  = New-Object System.Drawing.Font('Consolas',7)
    $279.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $279.Add_Click({ 
        Write-Host "Installando CrystalDisk Mark"
        choco install crystaldiskmark -y
    Write-host "Completato"
    })  

    $280                       = New-Object System.Windows.Forms.Button
    $280.FlatStyle             = 'Flat'
    $280.Text                  = "Partition Master"
    $280.width                 = 100
    $280.height                = 30
    $280.Location              = New-Object System.Drawing.Point(230, 795)
    $280.Font                  = New-Object System.Drawing.Font('Consolas',7)
    $280.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $280.Add_Click({ 
        Write-Host "Installando Partition Master"
        choco install partitionmasterfree -y
    Write-host "Completato"
    })  

    $281                       = New-Object System.Windows.Forms.Button
    $281.FlatStyle             = 'Flat'
    $281.Text                  = "SysInternal"
    $281.width                 = 100
    $281.height                = 30
    $281.Location              = New-Object System.Drawing.Point(340, 795)
    $281.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $281.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $281.Add_Click({ 
        Write-Host "Installando SysInternal"
        choco install sysinternals -y
    Write-host "Completato"
    })  

    $282                       = New-Object System.Windows.Forms.Button
    $282.FlatStyle             = 'Flat'
    $282.Text                  = "MSI Afterburner"
    $282.width                 = 100
    $282.height                = 30
    $282.Location              = New-Object System.Drawing.Point(450, 795)
    $282.Font                  = New-Object System.Drawing.Font('Consolas',7)
    $282.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $282.Add_Click({ 
        Write-Host "Installando MSI Afterburner"
        choco install msiafterburner -y
    Write-host "Completato"
    })  

    $283                       = New-Object System.Windows.Forms.Button
    $283.FlatStyle             = 'Flat'
    $283.Text                  = "Revo Uninstaller"
    $283.width                 = 100
    $283.height                = 30
    $283.Location              = New-Object System.Drawing.Point(10, 835)
    $283.Font                  = New-Object System.Drawing.Font('Consolas',7)
    $283.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $283.Add_Click({ 
        Write-Host "Installando Revo Uninstaller"
        choco install revo-uninstaller -y
    Write-host "Completato"
    })  

    $284                       = New-Object System.Windows.Forms.Button
    $284.FlatStyle             = 'Flat'
    $284.Text                  = "Glary Utilities"
    $284.width                 = 100
    $284.height                = 30
    $284.Location              = New-Object System.Drawing.Point(120, 835)
    $284.Font                  = New-Object System.Drawing.Font('Consolas',7)
    $284.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $284.Add_Click({ 
        Write-Host "Installando Glary Utilities"
        choco install glaryutilities-free -y
    Write-host "Completato"
    })  

    $285                       = New-Object System.Windows.Forms.Button
    $285.FlatStyle             = 'Flat'
    $285.Text                  = "Bulk Crap Uninstaller"
    $285.width                 = 100
    $285.height                = 30
    $285.Location              = New-Object System.Drawing.Point(230, 835)
    $285.Font                  = New-Object System.Drawing.Font('Consolas',7)
    $285.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
        
    $285.Add_Click({ 
        Write-Host "Installando Bulk Crap Uninstaller"
        choco install bulk-crap-uninstaller -y
    Write-host "Completato"
    })  

    $2CustomizeForm.controls.AddRange(@($21,$22,$23,$2p1,$24,$25,$26,$27,$28,$29,$210,$211,$212,$213,$214,$215,$216,$217,$218,$219,$220,$221,$222,$223,$224,$225,$226,$227,$228,$229,$230,$231,$232,$233,$234,$235,$236,$237,$238,$239,$240,$241,$242,$243,$244,$245,$246,$247,$248,$249,$250,$251,$252,$253,$254,$255,$256,$257,$258,$259,$260,$261,$262,$263,$264,$265,$266,$267,$268,$269,$270,$271,$272,$273,$274,$275,$276,$277,$278,$279,$280,$281,$282,$283,$284,$285))

            Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }
    
    [void]$2CustomizeForm.ShowDialog()

})

######################
### END CHOCOLATEY ###
######################

######################
### TWEAKS PRIVACY ###
######################

$Button3.Add_Click({
    $3CustomizeForm                  = New-Object System.Windows.Forms.Form
    $3CustomizeForm.ClientSize       = New-Object System.Drawing.Point(1270,970)
    $3CustomizeForm.StartPosition    = 'CenterScreen'
    $3CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $3CustomizeForm.MinimizeBox      = $false
    $3CustomizeForm.MaximizeBox      = $true
    $3CustomizeForm.ShowIcon         = $false
    $3CustomizeForm.Text             = "Tweaks Privacy"
    $3CustomizeForm.TopMost          = $false
    $3CustomizeForm.AutoScroll       = $true
    $3CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

    $31                       = New-Object System.Windows.Forms.Button
    $31.FlatStyle             = 'Flat'
    $31.Text                  = "O&O Shutup"
    $31.width                 = 300
    $31.height                = 30
    $31.Location              = New-Object System.Drawing.Point(10, 10)
    $31.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $31.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $31.Add_Click({ 
        Write-Host "O&O Shutup"
        Import-Module BitsTransfer      choco install shutup10 -y
        Start-BitsTransfer -Source "https://raw.githubusercontent.com/Iblis94/Paki/main/ooshutup10.cfg" -Destination ooshutup10.cfg      OOSU10 ooshutup10.cfg /quiet
        Start-BitsTransfer -Source "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -Destination OOSU10.exe    
        ./OOSU10.exe ooshutup10.cfg /quiet
        Write-host "Completato"
    })

    $32                       = New-Object System.Windows.Forms.Button
    $32.FlatStyle             = 'Flat'
    $32.Text                  = "Disattiva Accesso Lista Lingue"
    $32.width                 = 300
    $32.height                = 30
    $32.Location              = New-Object System.Drawing.Point(10, 50)
    $32.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $32.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $32.Add_Click({ 
        Write-Host "Disattivando Accesso Lista Lingue"
        Set-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Type DWord -Value 1  
        Write-host "Completato"
    })

    $33                       = New-Object System.Windows.Forms.Button
    $33.FlatStyle             = 'Flat'
    $33.Text                  = "Disattiva Apps Suggerite"
    $33.width                 = 300
    $33.height                = 30
    $33.Location              = New-Object System.Drawing.Point(10, 90)
    $33.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $33.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $33.Add_Click({ 
        Write-Host "Disattivando Applicazioni Suggerite"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableThirdPartySuggestions" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT" -Name "DontOfferThroughWUAU" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows" -Name "CEIPEnable" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "AITEnable" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableUAR" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" -Name "Start" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" -Name "Start" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-314559Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
        
        Write-host "Completato"
    })

    $34                       = New-Object System.Windows.Forms.Button
    $34.FlatStyle             = 'Flat'
    $34.Text                  = "Disattiva Telemetria"
    $34.width                 = 300
    $34.height                = 30
    $34.Location              = New-Object System.Drawing.Point(10, 130)
    $34.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $34.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $34.Add_Click({ 
        Write-Host "Disattivando Telemetria"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
    
        Write-host "Completato"
    })

    $35                       = New-Object System.Windows.Forms.Button
    $35.FlatStyle             = 'Flat'
    $35.Text                  = "Disattiva Cronologia Attivita'"
    $35.width                 = 300
    $35.height                = 30
    $35.Location              = New-Object System.Drawing.Point(10, 170)
    $35.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $35.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $35.Add_Click({ 
    
        Write-Host "Disattivando Cronologia Attivita'"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
    
        Write-host "Completato"
    })

    $36                       = New-Object System.Windows.Forms.Button
    $36.FlatStyle             = 'Flat'
    $36.Text                  = "Disattiva Tracking Posizione"
    $36.width                 = 300
    $36.height                = 30
    $36.Location              = New-Object System.Drawing.Point(10, 210)
    $36.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $36.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $36.Add_Click({ 
        Write-Host "Disattivando Tracking di Posizione"
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Deny"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value 0
    
    
        Write-host "Completato"
    })

    $37                       = New-Object System.Windows.Forms.Button
    $37.FlatStyle             = 'Flat'
    $37.Text                  = "Disattiva Report Errori"
    $37.width                 = 300
    $37.height                = 30
    $37.Location              = New-Object System.Drawing.Point(10, 250)
    $37.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $37.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $37.Add_Click({ 
        Write-Host "Disattivando Report Errori"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
    
        Write-host "Completato"
    })

    $38                       = New-Object System.Windows.Forms.Button
    $38.FlatStyle             = 'Flat'
    $38.Text                  = "Disattiva Tracking Diagnostica"
    $38.width                 = 300
    $38.height                = 30
    $38.Location              = New-Object System.Drawing.Point(10, 290)
    $38.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $38.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $38.Add_Click({ 
        Write-Host "Disattivando Servizio di Tracking Diagnostica"
        Stop-Service "DiagTrack" -WarningAction SilentlyContinue
        Set-Service "DiagTrack" -StartupType Disabled
        
        Write-host "Completato"
    })

    $39                       = New-Object System.Windows.Forms.Button
    $39.FlatStyle             = 'Flat'
    $39.Text                  = "Disattiva WAP Push Service"
    $39.width                 = 300
    $39.height                = 30
    $39.Location              = New-Object System.Drawing.Point(10, 330)
    $39.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $39.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $39.Add_Click({ 
        Write-Host "Disattivando WAP Push Service"
        Stop-Service "dmwappushservice" -WarningAction SilentlyContinue
        Set-Service "dmwappushservice" -StartupType Disabled
    
        Write-host "Completato"
    })

    $310                       = New-Object System.Windows.Forms.Button
    $310.FlatStyle             = 'Flat'
    $310.Text                  = "Disattiva Home Group Services"
    $310.width                 = 300
    $310.height                = 30
    $310.Location              = New-Object System.Drawing.Point(10, 370)
    $310.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $310.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $310.Add_Click({ 
        Write-Host "Disattivando Home Group Services"
        Stop-Service "HomeGroupListener" -WarningAction SilentlyContinue
        Set-Service "HomeGroupListener" -StartupType Disabled
        Stop-Service "HomeGroupProvider" -WarningAction SilentlyContinue
        Set-Service "HomeGroupProvider" -StartupType Disabled
        
        Write-host "Completato"
    })

    $311                       = New-Object System.Windows.Forms.Button
    $311.FlatStyle             = 'Flat'
    $311.Text                  = "Disattiva Assistenza Remota"
    $311.width                 = 300
    $311.height                = 30
    $311.Location              = New-Object System.Drawing.Point(10, 410)
    $311.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $311.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $311.Add_Click({ 
        Write-Host "Disattivando Assistenza Remota"
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Type DWord -Value 0
        
        Write-host "Completato"
    })

    $312                       = New-Object System.Windows.Forms.Button
    $312.FlatStyle             = 'Flat'
    $312.Text                  = "Disattiva Controllo Archiaviazione"
    $312.width                 = 300
    $312.height                = 30
    $312.Location              = New-Object System.Drawing.Point(10, 450)
    $312.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $312.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $312.Add_Click({ 
        Write-Host "Disattivando Controllo Archiviazione"
        Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Recurse -ErrorAction SilentlyContinue
        
        Write-host "Completato"
    })

    $313                       = New-Object System.Windows.Forms.Button
    $313.FlatStyle             = 'Flat'
    $313.Text                  = "Disattiva Superfetch"
    $313.width                 = 300
    $313.height                = 30
    $313.Location              = New-Object System.Drawing.Point(10, 490)
    $313.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $313.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $313.Add_Click({ 
        Write-Host "Disattivando Superfetch"
        Stop-Service "SysMain" -WarningAction SilentlyContinue
        Set-Service "SysMain" -StartupType Disabled
        
        Write-host "Completato"
    })

    $314                       = New-Object System.Windows.Forms.Button
    $314.FlatStyle             = 'Flat'
    $314.Text                  = "Disattiva Hibernation"
    $314.width                 = 300
    $314.height                = 30
    $314.Location              = New-Object System.Drawing.Point(10, 530)
    $314.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $314.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $314.Add_Click({ 
        Write-Host "Disattivando Ibernazione"
        Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernateEnabled" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type DWord -Value 0
        powercfg /HIBERNATE OFF 2>&1 | Out-Null
        
        Write-host "Completato"
    })

    $315                       = New-Object System.Windows.Forms.Button
    $315.FlatStyle             = 'Flat'
    $315.Text                  = "Disattiva Auto Manteinance"
    $315.width                 = 300
    $315.height                = 30
    $315.Location              = New-Object System.Drawing.Point(10, 570)
    $315.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $315.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $315.Add_Click({ 
        Write-Host "Disattivando Auto Manteinance"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "MaintenanceDisabled" -Type dword -Value 1
        
        Write-host "Completato"
    })

    $316                       = New-Object System.Windows.Forms.Button
    $316.FlatStyle             = 'Flat'
    $316.Text                  = "Disattiva Spazio Riservato"
    $316.width                 = 300
    $316.height                = 30
    $316.Location              = New-Object System.Drawing.Point(10, 610)
    $316.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $316.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $316.Add_Click({ 
        Write-Host "Disattivando Reserved Storage"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" -Name "ShippedWithReserves" -Type dword -Value 0
    
        Write-host "Completato"
    })

    $317                       = New-Object System.Windows.Forms.Button
    $317.FlatStyle             = 'Flat'
    $317.Text                  = "Disattiva AeroShake"
    $317.width                 = 300
    $317.height                = 30
    $317.Location              = New-Object System.Drawing.Point(10, 650)
    $317.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $317.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $317.Add_Click({ 
        Write-Host "Disattivando AeroShake"
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisallowShaking" -Type dword -Value 1
    
        Write-host "Completato"
    })

    $318                       = New-Object System.Windows.Forms.Button
    $318.FlatStyle             = 'Flat'
    $318.Text                  = "Disattiva Paint3D"
    $318.width                 = 300
    $318.height                = 30
    $318.Location              = New-Object System.Drawing.Point(10, 690)
    $318.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $318.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $318.Add_Click({ 
        Write-Host "Disattivando Paint3D"
        $Paint3Dstuff = @(
                "HKCR:\SystemFileAssociations\.3mf\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.bmp\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.fbx\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.gif\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.jfif\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.jpe\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.jpeg\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.jpg\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.png\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.tif\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.tiff\Shell\3D Edit"
            )
            #Rename reg key to remove it, so it's revertible
            foreach ($Paint3D in $Paint3Dstuff) {
                If (Test-Path $Paint3D) {
                $rmPaint3D = $Paint3D + "_"
                Set-Item $Paint3D $rmPaint3D
            }
            }
        Write-host "Completato"
    })

    $319                       = New-Object System.Windows.Forms.Button
    $319.FlatStyle             = 'Flat'
    $319.Text                  = "Disattiva InstallService"
    $319.width                 = 300
    $319.height                = 30
    $319.Location              = New-Object System.Drawing.Point(10, 730)
    $319.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $319.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $319.Add_Click({ 
        Write-Host "Disattivando InstallService"
        Stop-Service InstallService
        Set-Service InstallService -StartupType Disabled
        
        Write-host "Completato"
    })

    $320                       = New-Object System.Windows.Forms.Button
    $320.FlatStyle             = 'Flat'
    $320.Text                  = "Disattiva Ripristino PC"
    $320.width                 = 300
    $320.height                = 30
    $320.Location              = New-Object System.Drawing.Point(10, 770)
    $320.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $320.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $320.Add_Click({ 
        Write-Host "Disattivando Ripristino di Sistema"
        Disable-ComputerRestore -Drive "$env:SYSTEMDRIVE"
        
        Write-host "Completato"
    })

    $321                       = New-Object System.Windows.Forms.Button
    $321.FlatStyle             = 'Flat'
    $321.Text                  = "Disattiva Deframmentazione Programmata"
    $321.width                 = 300
    $321.height                = 30
    $321.Location              = New-Object System.Drawing.Point(10, 810)
    $321.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $321.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $321.Add_Click({ 
        Write-Host "Disattivando Deframmentazione Programmata"
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Defrag\ScheduledDefrag" | Out-Null
      
        Write-host "Completato"
    })

    $322                       = New-Object System.Windows.Forms.Button
    $322.FlatStyle             = 'Flat'
    $322.Text                  = "Disattiva Condivisione Connessione Internet"
    $322.width                 = 300
    $322.height                = 30
    $322.Location              = New-Object System.Drawing.Point(10, 850)
    $322.Font                  = New-Object System.Drawing.Font('Consolas',8)
    $322.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $322.Add_Click({ 
        Write-Host "Disattivando Condivisione Connessione Internet"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections" -Name "NC_ShowSharedAccessUI" -Type DWord -Value 0       
        Write-host "Completato"
    })

    $323                       = New-Object System.Windows.Forms.Button
    $323.FlatStyle             = 'Flat'
    $323.Text                  = "Disattiva Aggiunti di Recente da Start"
    $323.width                 = 300
    $323.height                = 30
    $323.Location              = New-Object System.Drawing.Point(10, 890)
    $323.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $323.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $323.Add_Click({ 
        Write-Host "Disattivando 'Aggiunti di Recenti' da Start"
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Type DWord -Value 1
        
        Write-host "Completato"
    })

    $324                       = New-Object System.Windows.Forms.Button
    $324.FlatStyle             = 'Flat'
    $324.Text                  = "Disattiva Piu' Usati da Start"
    $324.width                 = 300
    $324.height                = 30
    $324.Location              = New-Object System.Drawing.Point(10, 930)
    $324.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $324.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $324.Add_Click({ 
        Write-Host "Disattivando Piu' Usati da Start"
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoStartMenuMFUprogramsList" -Type DWord -Value 1
        
        Write-host "Completato"
    })

    $325                       = New-Object System.Windows.Forms.Button
    $325.FlatStyle             = 'Flat'
    $325.Text                  = "Disattiva Background Apps"
    $325.width                 = 300
    $325.height                = 30
    $325.Location              = New-Object System.Drawing.Point(440, 10)
    $325.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $325.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $325.Add_Click({ 
        Write-Host "Disabling Background application access..."
        Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach {
            Set-ItemProperty -Path $_.PsPath -Name "Disabled" -Type DWord -Value 1
            Set-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -Type DWord -Value 1
        }
        Write-host "Completato"
    })
    
    $326                       = New-Object System.Windows.Forms.Button
    $326.FlatStyle             = 'Flat'
    $326.Text                  = "Revert"
    $326.width                 = 100
    $326.height                = 30
    $326.Location              = New-Object System.Drawing.Point(750, 10)
    $326.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $326.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $326.Add_Click({ 
        Write-Host "Allowing Background Apps..."
        Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach {
            Remove-ItemProperty -Path $_.PsPath -Name "Disabled" -ErrorAction SilentlyContinue
            Remove-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -ErrorAction SilentlyContinue
        }
        Write-host "Completato"
    })

    $327                       = New-Object System.Windows.Forms.Button
    $327.FlatStyle             = 'Flat'
    $327.Text                  = "Disabilita Action Center"
    $327.width                 = 300
    $327.height                = 30
    $327.Location              = New-Object System.Drawing.Point(440, 50)
    $327.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $327.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $327.Add_Click({ 
        Write-Host "Disabling Action Center..."
        If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
            New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Type DWord -Value 0
    
        Write-host "Completato"
    })
    
    $328                       = New-Object System.Windows.Forms.Button
    $328.FlatStyle             = 'Flat'
    $328.Text                  = "Revert"
    $328.width                 = 100
    $328.height                = 30
    $328.Location              = New-Object System.Drawing.Point(750, 50)
    $328.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $328.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $328.Add_Click({ 
        Write-Host "Enabling Action Center..."
        Remove-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -ErrorAction SilentlyContinue 
        Write-host "Completato"
    })

    $329                       = New-Object System.Windows.Forms.Button
    $329.FlatStyle             = 'Flat'
    $329.Text                  = "Disattiva Windows Search"
    $329.width                 = 300
    $329.height                = 30
    $329.Location              = New-Object System.Drawing.Point(440, 90)
    $329.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $329.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $329.Add_Click({ 
        Write-Host "Disabling Bing Search in Start Menu..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name ShellFeedsTaskbarViewMode -Type DWord -Value 2
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1 -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1    
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Type DWord -Value 1
        Write-Host "Stopping and disabling Windows Search indexing service..."
        Stop-Service "WSearch" -WarningAction SilentlyContinue
        Set-Service "WSearch" -StartupType Disabled
        Write-Host "Hiding Taskbar Search icon / box..."
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0
    
        Write-host "Completato"
    })
    
    $330                       = New-Object System.Windows.Forms.Button
    $330.FlatStyle             = 'Flat'
    $330.Text                  = "Revert"
    $330.width                 = 100
    $330.height                = 30
    $330.Location              = New-Object System.Drawing.Point(750, 90)
    $330.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $330.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $330.Add_Click({ 
        Write-Host "Restoring Windows Search..."
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value "1"
        Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -ErrorAction SilentlyContinue
        Write-Host "Restore and Starting Windows Search Service..."
        Set-Service "WSearch" -StartupType Automatic
        Start-Service "WSearch" -WarningAction SilentlyContinue
        Write-Host "Restore Windows Search Icon..."
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 1 
        Write-host "Completato"
    })

    $331                       = New-Object System.Windows.Forms.Button
    $331.FlatStyle             = 'Flat'
    $331.Text                  = "Tutta la Banda Disponibile"
    $331.width                 = 300
    $331.height                = 30
    $331.Location              = New-Object System.Drawing.Point(440, 130)
    $331.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $331.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $331.Add_Click({ 
        $ErrorActionPreference = 'SilentlyContinue'
        $Bandwidth = "HKLM:\SOFTWARE\Policies\Microsoft\Psched"
        New-Item -Path $Bandwidth -ItemType Directory -Force
        Set-ItemProperty -Path $Bandwidth -Name "NonBestEffortLimit" -Type DWord -Value 0
    
        Write-host "Completato"
    })
    
    $332                       = New-Object System.Windows.Forms.Button
    $332.FlatStyle             = 'Flat'
    $332.Text                  = "Revert"
    $332.width                 = 100
    $332.height                = 30
    $332.Location              = New-Object System.Drawing.Point(750, 130)
    $332.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $332.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $332.Add_Click({ 
        $ErrorActionPreference = 'SilentlyContinue'
        $Bandwidth = "HKLM:\SOFTWARE\Policies\Microsoft\Psched"
        Remove-ItemProperty -Path $Bandwidth -Name "NonBestEffortLimit"
        Write-host "Completato"
    })

    $333                       = New-Object System.Windows.Forms.Button
    $333.FlatStyle             = 'Flat'
    $333.Text                  = "Disattiva Cortana"
    $333.width                 = 300
    $333.height                = 30
    $333.Location              = New-Object System.Drawing.Point(440, 170)
    $333.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $333.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $333.Add_Click({ 
        Write-Host "Disabling Cortana..."
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0
    
        Write-host "Completato"
    })
    
    $334                       = New-Object System.Windows.Forms.Button
    $334.FlatStyle             = 'Flat'
    $334.Text                  = "Revert"
    $334.width                 = 100
    $334.height                = 30
    $334.Location              = New-Object System.Drawing.Point(750, 170)
    $334.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $334.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $334.Add_Click({ 
        Write-Host "Enabling Cortana..."
        Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -ErrorAction SilentlyContinue
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 0
        Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -ErrorAction SilentlyContinue 
        Write-host "Completato"
    })

    $335                       = New-Object System.Windows.Forms.Button
    $335.FlatStyle             = 'Flat'
    $335.Text                  = "Imposta Dark Mode"
    $335.width                 = 300
    $335.height                = 30
    $335.Location              = New-Object System.Drawing.Point(440, 210)
    $335.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $335.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $335.Add_Click({ 
        Write-Host "Enabling Dark Mode"
        Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
    
        Write-host "Completato"
    })
    
    $336                       = New-Object System.Windows.Forms.Button
    $336.FlatStyle             = 'Flat'
    $336.Text                  = "Light"
    $336.width                 = 100
    $336.height                = 30
    $336.Location              = New-Object System.Drawing.Point(750, 210)
    $336.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $336.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $336.Add_Click({ 
        Write-Host "Switching Back to Light Mode"
        Remove-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme
        Write-host "Completato"
    })

    $337                       = New-Object System.Windows.Forms.Button
    $337.FlatStyle             = 'Flat'
    $337.Text                  = "Revert"
    $337.width                 = 100
    $337.height                = 30
    $337.Location              = New-Object System.Drawing.Point(320, 170)
    $337.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $337.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $337.Add_Click({ 
        Write-Host "Enabling Activity History..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $338                       = New-Object System.Windows.Forms.Button
    $338.FlatStyle             = 'Flat'
    $338.Text                  = "Revert"
    $338.width                 = 100
    $338.height                = 30
    $338.Location              = New-Object System.Drawing.Point(320, 210)
    $338.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $338.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $338.Add_Click({ 
        Write-Host "Enabling Location Tracking..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Allow"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value 1
        Write-host "Completato"
    })

    $339                       = New-Object System.Windows.Forms.Button
    $339.FlatStyle             = 'Flat'
    $339.Text                  = "Disattiva Aggiornamento Automatico Mappe"
    $339.width                 = 300
    $339.height                = 30
    $339.Location              = New-Object System.Drawing.Point(440, 250)
    $339.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $339.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $339.Add_Click({ 
        Write-Host "Disabling automatic Maps updates..."
        Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0
    
        Write-host "Completato"
    })
    
    $340                       = New-Object System.Windows.Forms.Button
    $340.FlatStyle             = 'Flat'
    $340.Text                  = "Revert"
    $340.width                 = 100
    $340.height                = 30
    $340.Location              = New-Object System.Drawing.Point(750, 250)
    $340.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $340.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $340.Add_Click({ 
        Write-Host "Enable automatic Maps updates..."
        Remove-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $341                       = New-Object System.Windows.Forms.Button
    $341.FlatStyle             = 'Flat'
    $341.Text                  = "Disabilita Feedback"
    $341.width                 = 300
    $341.height                = 30
    $341.Location              = New-Object System.Drawing.Point(440, 290)
    $341.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $341.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $341.Add_Click({ 
        Write-Host "Disabling Feedback..."
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
    
        Write-host "Completato"
    })
    
    $342                       = New-Object System.Windows.Forms.Button
    $342.FlatStyle             = 'Flat'
    $342.Text                  = "Revert"
    $342.width                 = 100
    $342.height                = 30
    $342.Location              = New-Object System.Drawing.Point(750, 290)
    $342.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $342.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $342.Add_Click({ 
        Write-Host "Enabling Feedback..."
        Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -ErrorAction SilentlyContinue
        Enable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
        Enable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
        Write-host "Completato"
    })

    $343                       = New-Object System.Windows.Forms.Button
    $343.FlatStyle             = 'Flat'
    $343.Text                  = "Disattiva Esperienze Condivise"
    $343.width                 = 300
    $343.height                = 30
    $343.Location              = New-Object System.Drawing.Point(440, 330)
    $343.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $343.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $343.Add_Click({ 
        Write-Host "Disabling Tailored Experiences..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableCdp" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableMmx" -Type DWord -Value 0
        If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
            New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
    
        Write-host "Completato"
    })
    
    $344                       = New-Object System.Windows.Forms.Button
    $344.FlatStyle             = 'Flat'
    $344.Text                  = "Revert"
    $344.width                 = 100
    $344.height                = 30
    $344.Location              = New-Object System.Drawing.Point(750, 330)
    $344.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $344.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $344.Add_Click({ 
        Write-Host "Enabling Tailored Experiences..."
        Remove-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $345                       = New-Object System.Windows.Forms.Button
    $345.FlatStyle             = 'Flat'
    $345.Text                  = "Disabilita Advertising ID"
    $345.width                 = 300
    $345.height                = 30
    $345.Location              = New-Object System.Drawing.Point(440, 370)
    $345.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $345.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $345.Add_Click({ 
        Write-Host "Disabling Advertising ID..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1
    
        Write-host "Completato"
    })
    
    $346                       = New-Object System.Windows.Forms.Button
    $346.FlatStyle             = 'Flat'
    $346.Text                  = "Revert"
    $346.width                 = 100
    $346.height                = 30
    $346.Location              = New-Object System.Drawing.Point(750, 370)
    $346.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $346.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $346.Add_Click({ 
        Write-Host "Enabling Advertising ID..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $347                       = New-Object System.Windows.Forms.Button
    $347.FlatStyle             = 'Flat'
    $347.Text                  = "Revert"
    $347.width                 = 100
    $347.height                = 30
    $347.Location              = New-Object System.Drawing.Point(320, 90)
    $347.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $347.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $347.Add_Click({ 
        Write-Host "Enabling Application suggestions..."
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 1
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $348                       = New-Object System.Windows.Forms.Button
    $348.FlatStyle             = 'Flat'
    $348.Text                  = "Disabilita SmartScreen"
    $348.width                 = 300
    $348.height                = 30
    $348.Location              = New-Object System.Drawing.Point(440, 410)
    $348.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $348.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $348.Add_Click({ 
        Write-Host "Disabling SmartScreen Filter..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -Type DWord -Value 0
    
        Write-host "Completato"
    })
    
    $349                       = New-Object System.Windows.Forms.Button
    $349.FlatStyle             = 'Flat'
    $349.Text                  = "Revert"
    $349.width                 = 100
    $349.height                = 30
    $349.Location              = New-Object System.Drawing.Point(750, 410)
    $349.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $349.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $349.Add_Click({ 
        Write-Host "Enabling SmartScreen Filter..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $350                       = New-Object System.Windows.Forms.Button
    $350.FlatStyle             = 'Flat'
    $350.Text                  = "Disabilita WiFi-Sense"
    $350.width                 = 300
    $350.height                = 30
    $350.Location              = New-Object System.Drawing.Point(440, 450)
    $350.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $350.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $350.Add_Click({ 
        Write-Host "Disabling Wi-Fi Sense..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "AutoConnectAllowedOEM" -Type Dword -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "WiFISenseAllowed" -Type Dword -Value 0
    
        Write-host "Completato"
    })
    
    $351                       = New-Object System.Windows.Forms.Button
    $351.FlatStyle             = 'Flat'
    $351.Text                  = "Revert"
    $351.width                 = 100
    $351.height                = 30
    $351.Location              = New-Object System.Drawing.Point(750, 450)
    $351.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $351.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $351.Add_Click({ 
        Write-Host "Enabling Wi-Fi Sense..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 1
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "AutoConnectAllowedOEM" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "WiFISenseAllowed" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $352                       = New-Object System.Windows.Forms.Button
    $352.FlatStyle             = 'Flat'
    $352.Text                  = "Disattiva Adobe Flash"
    $352.width                 = 300
    $352.height                = 30
    $352.Location              = New-Object System.Drawing.Point(440, 490)
    $352.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $352.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $352.Add_Click({ 
        Write-Host "Disattivando Adobe Flash"
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer" -Name "DisableFlashInIE" -Type DWord -Value 1
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons" -Name "FlashPlayerEnabled" -Type DWord -Value 0
        
        Write-host "Completato"
    })

    $353                       = New-Object System.Windows.Forms.Button
    $353.FlatStyle             = 'Flat'
    $353.Text                  = "Disattiva IE Primo Accesso"
    $353.width                 = 300
    $353.height                = 30
    $353.Location              = New-Object System.Drawing.Point(440, 530)
    $353.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $353.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $353.Add_Click({ 
        Write-Host "Disattivando IE Primo Accesso"
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Type DWord -Value 1
        
        Write-host "Completato"
    })

    $354                       = New-Object System.Windows.Forms.Button
    $354.FlatStyle             = 'Flat'
    $354.Text                  = "NTFS >260 Caratteri"
    $354.width                 = 300
    $354.height                = 30
    $354.Location              = New-Object System.Drawing.Point(440, 570)
    $354.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $354.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $354.Add_Click({ 
        Write-Host "Attivando NTFS con piu' di 260 Caratteri"
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Type DWord -Value 1
      
        Write-host "Completato"
    })

    $355                       = New-Object System.Windows.Forms.Button
    $355.FlatStyle             = 'Flat'
    $355.Text                  = "Disattiva Cloudstore"
    $355.width                 = 300
    $355.height                = 30
    $355.Location              = New-Object System.Drawing.Point(440, 610)
    $355.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $355.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $355.Add_Click({ 
        Write-Host "Disattivando CloudStore se Presente"
        $CloudStore = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore'
        If (Test-Path $CloudStore) {
            Stop-Process Explorer.exe -Force
            Remove-Item $CloudStore -Recurse -Force
            Start-Process Explorer.exe -Wait
        }
        Write-host "Completato"
    })

    $356                       = New-Object System.Windows.Forms.Button
    $356.FlatStyle             = 'Flat'
    $356.Text                  = "Blocca Update Windows Store Apps"
    $356.width                 = 300
    $356.height                = 30
    $356.Location              = New-Object System.Drawing.Point(440, 650)
    $356.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $356.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $356.Add_Click({ 
        Write-Host "Disattivando Update Automatico Windows Store App"
        $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"
        If (!(Test-Path $registryPath)) {
            Mkdir $registryPath
            New-ItemProperty $registryPath AutoDownload -Value 2 
        }
        Set-ItemProperty $registryPath AutoDownload -Value 2
        #Stop WindowsStore Installer Service and set to Disabled
        
        Write-host "Completato"
    })

    $357                       = New-Object System.Windows.Forms.Button
    $357.FlatStyle             = 'Flat'
    $357.Text                  = "Disattiva Chiavi Registro Backgound App"
    $357.width                 = 300
    $357.height                = 30
    $357.Location              = New-Object System.Drawing.Point(440, 690)
    $357.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $357.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $357.Add_Click({ 
        Write-Host "Disattivando Alcune Chiavi di Registro"
        $ErrorActionPreference = 'SilentlyContinue'
            $Keys = @(
                
                New-PSDrive  HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
                #Remove Background Tasks
                "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
                "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
                "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
                "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
                "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
                "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
                
                #Windows File
                "HKCR:\Extensions\ContractId\Windows.File\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
                
                #Registry keys to delete if they aren't uninstalled by RemoveAppXPackage/RemoveAppXProvisionedPackage
                "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
                "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
                "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
                "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
                "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
                
                #Scheduled Tasks to delete
                "HKCR:\Extensions\ContractId\Windows.PreInstalledConfigTask\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
                
                #Windows Protocol Keys
                "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
                "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
                "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
                "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
                   
                #Windows Share Target
                "HKCR:\Extensions\ContractId\Windows.ShareTarget\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            )
        Write-host "Completato"
    })

    $358                       = New-Object System.Windows.Forms.Button
    $358.FlatStyle             = 'Flat'
    $358.Text                  = "Ottimizzazione Schermo Intero"
    $358.width                 = 300
    $358.height                = 30
    $358.Location              = New-Object System.Drawing.Point(440, 730)
    $358.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $358.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $358.Add_Click({ 
        Write-Host "Attivando Ottimizzazione Schermo Intero"
        Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Type DWord -Value 0
        Remove-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehavior" -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Type DWord -Value 0
        
        Write-host "Completato"
    })

    $359                       = New-Object System.Windows.Forms.Button
    $359.FlatStyle             = 'Flat'
    $359.Text                  = "BIOS in UTC Time"
    $359.width                 = 300
    $359.height                = 30
    $359.Location              = New-Object System.Drawing.Point(440, 770)
    $359.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $359.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $359.Add_Click({ 
        Write-Host "Modifica: BIOS in UTC Time"
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 1
       
        Write-host "Completato"
    })

    $360                       = New-Object System.Windows.Forms.Button
    $360.FlatStyle             = 'Flat'
    $360.Text                  = "Task Manager Mostra Dettagli"
    $360.width                 = 300
    $360.height                = 30
    $360.Location              = New-Object System.Drawing.Point(440, 810)
    $360.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $360.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $360.Add_Click({ 
        Write-Host "Modifica: Task Manager Mostra Dettagli"
        $taskmgr = Start-Process -WindowStyle Hidden -FilePath taskmgr.exe -PassThru
        Do {
            Start-Sleep -Milliseconds 100
            $preferences = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -ErrorAction SilentlyContinue
        } Until ($preferences)
        Stop-Process $taskmgr
        $preferences.Preferences[28] = 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -Type Binary -Value $preferences.Preferences
       
        Write-host "Completato"
    })

    $361                       = New-Object System.Windows.Forms.Button
    $361.FlatStyle             = 'Flat'
    $361.Text                  = "Mostra Dettagli Operazioni File"
    $361.width                 = 300
    $361.height                = 30
    $361.Location              = New-Object System.Drawing.Point(440, 850)
    $361.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $361.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $361.Add_Click({ 
        Write-Host "Modifica: Operazioni File Mostra Dettagli"
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1
        
        Write-host "Completato"
    })

    $362                       = New-Object System.Windows.Forms.Button
    $362.FlatStyle             = 'Flat'
    $362.Text                  = "Blocca Controllo PDF di Edge"
    $362.width                 = 300
    $362.height                = 30
    $362.Location              = New-Object System.Drawing.Point(440, 890)
    $362.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $362.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $362.Add_Click({ 
        Write-Host "Disattivando Controllo PDF di Edge"
        $NoPDF = "HKCR:\.pdf"
        $NoProgids = "HKCR:\.pdf\OpenWithProgids"
        $NoWithList = "HKCR:\.pdf\OpenWithList" 
        If (!(Get-ItemProperty $NoPDF  NoOpenWith)) {
            New-ItemProperty $NoPDF NoOpenWith 
        }        
        If (!(Get-ItemProperty $NoPDF  NoStaticDefaultVerb)) {
            New-ItemProperty $NoPDF  NoStaticDefaultVerb 
        }        
        If (!(Get-ItemProperty $NoProgids  NoOpenWith)) {
            New-ItemProperty $NoProgids  NoOpenWith 
        }        
        If (!(Get-ItemProperty $NoProgids  NoStaticDefaultVerb)) {
            New-ItemProperty $NoProgids  NoStaticDefaultVerb 
        }        
        If (!(Get-ItemProperty $NoWithList  NoOpenWith)) {
            New-ItemProperty $NoWithList  NoOpenWith
        }        
        If (!(Get-ItemProperty $NoWithList  NoStaticDefaultVerb)) {
            New-ItemProperty $NoWithList  NoStaticDefaultVerb 
        }
            
        #Appends an underscore '_' to the Registry key for Edge
        $Edge = "HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_"
        If (Test-Path $Edge) {
            Set-Item $Edge AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_ 
        } 
        Write-host "Completato"
    })
    

    $363                       = New-Object System.Windows.Forms.Button
    $363.FlatStyle             = 'Flat'
    $363.Text                  = "Nascondi Icona Task da Start"
    $363.width                 = 300
    $363.height                = 30
    $363.Location              = New-Object System.Drawing.Point(440, 930)
    $363.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $363.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $363.Add_Click({ 
        Write-Host "Modifica: Nascondendo Icona Task da Start"
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
        
        Write-host "Completato"
    })

    $364                       = New-Object System.Windows.Forms.Button
    $364.FlatStyle             = 'Flat'
    $364.Text                  = "Nascondi Icona People da Start"
    $364.width                 = 300
    $364.height                = 30
    $364.Location              = New-Object System.Drawing.Point(870, 10)
    $364.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $364.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $364.Add_Click({ 
        Write-Host "Modifica: Nascondendo Icona People da Start"
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0
        
        Write-host "Completato"
    })

    $365                       = New-Object System.Windows.Forms.Button
    $365.FlatStyle             = 'Flat'
    $365.Text                  = "Attiva Powerplan Max"
    $365.width                 = 300
    $365.height                = 30
    $365.Location              = New-Object System.Drawing.Point(870, 50)
    $365.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $365.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $365.Add_Click({ 
        Write-Host "Installando Powerplan"
        powercfg -duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a
        powercfg -duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e
        powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
        powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
        
        Write-host "Completato"
    })

    $366                       = New-Object System.Windows.Forms.Button
    $366.FlatStyle             = 'Flat'
    $366.Text                  = "Taskbar Piu' Trasparente"
    $366.width                 = 300
    $366.height                = 30
    $366.Location              = New-Object System.Drawing.Point(870, 90)
    $366.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $366.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $366.Add_Click({ 
        Write-Host "Modifica: Taskbar Piu' Trasparente"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "UseOLEDTaskbarTransparency" -Type dword -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Dwm" -Name "ForceEffectMode" -Type dword -Value 1
        
        Write-host "Completato"
    })

    $367                       = New-Object System.Windows.Forms.Button
    $367.FlatStyle             = 'Flat'
    $367.Text                  = "Mostra tutte le Icone in Start"
    $367.width                 = 300
    $367.height                = 30
    $367.Location              = New-Object System.Drawing.Point(870, 130)
    $367.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $367.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $367.Add_Click({ 
        Write-Host "Showing all tray icons..."
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 0
        
        Write-host "Completato"
    })

    $368                       = New-Object System.Windows.Forms.Button
    $368.FlatStyle             = 'Flat'
    $368.Text                  = "IRP Stack Size"
    $368.width                 = 300
    $368.height                = 30
    $368.Location              = New-Object System.Drawing.Point(870, 170)
    $368.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $368.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $368.Add_Click({ 
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Type DWord -Value 20

        Write-host "Completato"
    })

    $369                       = New-Object System.Windows.Forms.Button
    $369.FlatStyle             = 'Flat'
    $369.Text                  = "SVCHost Tweak"
    $369.width                 = 300
    $369.height                = 30
    $369.Location              = New-Object System.Drawing.Point(870, 210)
    $369.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $369.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $369.Add_Click({ 
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value 4194304

        Write-host "Completato"
    })

    $370                       = New-Object System.Windows.Forms.Button
    $370.FlatStyle             = 'Flat'
    $370.Text                  = "Migliora Vita SSD"
    $370.width                 = 300
    $370.height                = 30
    $370.Location              = New-Object System.Drawing.Point(870, 250)
    $370.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $370.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $370.Add_Click({ 
        fsutil behavior set DisableLastAccess 1
        fsutil behavior set EncryptPagingFile 0
        
        Write-host "Completato"
    })

    $371                       = New-Object System.Windows.Forms.Button
    $371.FlatStyle             = 'Flat'
    $371.Text                  = "Pannello di Controllo Icone Grandi"
    $371.width                 = 300
    $371.height                = 30
    $371.Location              = New-Object System.Drawing.Point(870, 290)
    $371.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $371.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $371.Add_Click({ 
        Write-Host "Modifica: Pannello di Controllo Icone Grandi"
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "StartupPage" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "AllItemsIconView" -Type DWord -Value 0
        
        Write-host "Completato"
    })

    $372                       = New-Object System.Windows.Forms.Button
    $372.FlatStyle             = 'Flat'
    $372.Text                  = "Revert"
    $372.width                 = 100
    $372.height                = 30
    $372.Location              = New-Object System.Drawing.Point(320, 50)
    $372.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $372.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $372.Add_Click({ 
        Remove-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut"
        New-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Type DWord -Value 0
        
        Write-host "Completato"
    })

    $373                       = New-Object System.Windows.Forms.Button
    $373.FlatStyle             = 'Flat'
    $373.Text                  = "Vecchio Slider Volume"
    $373.width                 = 300
    $373.height                = 30
    $373.Location              = New-Object System.Drawing.Point(870, 330)
    $373.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $373.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $373.Add_Click({ 
        Write-Host "Restoring old volume slider"
        New-FolderForced -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC"
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" "EnableMtcUvc" 0
        
        Write-host "Completato"
    })

    $374                       = New-Object System.Windows.Forms.Button
    $374.FlatStyle             = 'Flat'
    $374.Text                  = "Blocca UWP Accesso"
    $374.width                 = 300
    $374.height                = 30
    $374.Location              = New-Object System.Drawing.Point(870, 370)
    $374.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $374.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $374.Add_Click({ 
        Write-Host "Disabling UWP apps background access..."
        If ([System.Environment]::OSVersion.Version.Build -ge 17763) {
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsRunInBackground" -Type DWord -Value 2
        } Else {
            Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*", "Microsoft.Windows.ShellExperienceHost*" | ForEach-Object {
                Set-ItemProperty -Path $_.PsPath -Name "Disabled" -Type DWord -Value 1
                Set-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -Type DWord -Value 1
            }
        }
        Write-Host "Disabling access to voice activation from UWP apps..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoice" -Type DWord -Value 2
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoiceAboveLock" -Type DWord -Value 2
        Write-Host "Disabling access to notifications from UWP apps..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessNotifications" -Type DWord -Value 2
        Write-Host "Disabling access to account info from UWP apps..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessAccountInfo" -Type DWord -Value 2
        Write-Host "Disabling access to contacts from UWP apps..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessContacts" -Type DWord -Value 2
        Write-Host "Disabling access to calendar from UWP apps..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessCalendar" -Type DWord -Value 2
        Write-Host "Disabling access to phone calls from UWP apps..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessPhone" -Type DWord -Value 2
        Write-Host "Disabling access to call history from UWP apps..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessCallHistory" -Type DWord -Value 2
        Write-Host "Disabling access to email from UWP apps..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessEmail" -Type DWord -Value 2
        Write-Host "Disabling access to tasks from UWP apps..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessTasks" -Type DWord -Value 2
        Write-Host "Disabling access to messaging from UWP apps..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessMessaging" -Type DWord -Value 2
        Write-Host "Disabling access to radios from UWP apps..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessRadios" -Type DWord -Value 2
        Write-Host "Disabling access to other devices from UWP apps..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsSyncWithDevices" -Type DWord -Value 2
        Write-Host "Disabling access to diagnostic information from UWP apps..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsGetDiagnosticInfo" -Type DWord -Value 2
        Write-Host "Disabling access to libraries and file system from UWP apps..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" -Name "Value" -Type String -Value "Deny"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" -Name "Value" -Type String -Value "Deny"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Name "Value" -Type String -Value "Deny"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Name "Value" -Type String -Value "Deny"
        Write-Host "Disabling UWP apps swap file..."
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "SwapfileControl" -Type Dword -Value 0

        Write-host "Completato"
    })

    $375                       = New-Object System.Windows.Forms.Button
    $375.FlatStyle             = 'Flat'
    $375.Text                  = "Revert"
    $375.width                 = 100
    $375.height                = 30
    $375.Location              = New-Object System.Drawing.Point(1180, 370)
    $375.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $375.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $375.Add_Click({ 
        Write-Host "Enabling UWP apps swap file..."
        Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "SwapfileControl" -ErrorAction SilentlyContinue
        Write-Host "Enabling access to libraries and file system from UWP apps..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" -Name "Value" -Type String -Value "Allow"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" -Name "Value" -Type String -Value "Allow"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Name "Value" -Type String -Value "Allow"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Name "Value" -Type String -Value "Allow"
        Write-Host "Enabling access to diagnostic information from UWP apps..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsGetDiagnosticInfo" -ErrorAction SilentlyContinue
        Write-Host "Enabling access to other devices from UWP apps..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsSyncWithDevices" -ErrorAction SilentlyContinue
        Write-Host "Enabling access to radios from UWP apps..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessRadios" -ErrorAction SilentlyContinue
        Write-Host "Enabling access to messaging from UWP apps..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessMessaging" -ErrorAction SilentlyContinue
        Write-Host "Enabling access to tasks from UWP apps..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessTasks" -ErrorAction SilentlyContinue
        Write-Host "Enabling access to email from UWP apps..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessEmail" -ErrorAction SilentlyContinue
        Write-Host "Enabling access to call history from UWP apps..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessCallHistory" -ErrorAction SilentlyContinue
        Write-Host "Enabling access to phone calls from UWP apps..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessPhone" -ErrorAction SilentlyContinue
        Write-Host "Enabling access to calendar from UWP apps..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessCalendar" -ErrorAction SilentlyContinue
        Write-Host "Enabling access to contacts from UWP apps..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessContacts" -ErrorAction SilentlyContinue
        Write-Host "Enabling access to account info from UWP apps..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessAccountInfo" -ErrorAction SilentlyContinue
        Write-Host "Enabling access to notifications from UWP apps..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessNotifications" -ErrorAction SilentlyContinue
        Write-Host "Enabling access to voice activation from UWP apps..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoice" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoiceAboveLock" -ErrorAction SilentlyContinue
        Write-Host "Enabling UWP apps background access..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsRunInBackground" -ErrorAction SilentlyContinue
        Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" | ForEach-Object {
            Remove-ItemProperty -Path $_.PsPath -Name "Disabled" -ErrorAction SilentlyContinue
            Remove-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -ErrorAction SilentlyContinue
        }
        Write-host "Completato"
    })

    $376                       = New-Object System.Windows.Forms.Button
    $376.FlatStyle             = 'Flat'
    $376.Text                  = "Modifica Hosts (Blocca Telemetria)"
    $376.width                 = 300
    $376.height                = 30
    $376.Location              = New-Object System.Drawing.Point(870, 410)
    $376.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $376.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $376.Add_Click({ 
        Write-Host "Adding Telemetry domains to hosts file"
        $hosts_file = "$env:systemroot\System32\drivers\etc\hosts"
        $domains = @(
            "184-86-53-99.deploy.static.akamaitechnologies.com"
            "a-0001.a-msedge.net"
            "a-0002.a-msedge.net"
            "a-0003.a-msedge.net"
            "a-0004.a-msedge.net"
            "a-0005.a-msedge.net"
            "a-0006.a-msedge.net"
            "a-0007.a-msedge.net"
            "a-0008.a-msedge.net"
            "a-0009.a-msedge.net"
            "a1621.g.akamai.net"
            "a1856.g2.akamai.net"
            "a1961.g.akamai.net"
            #"a248.e.akamai.net"            #makes iTunes download button disappear (#43)
            "a978.i6g1.akamai.net"
            "a.ads1.msn.com"
            "a.ads2.msads.net"
            "a.ads2.msn.com"
            "ac3.msn.com"
            "ad.doubleclick.net"
            "adnexus.net"
            "adnxs.com"
            "ads1.msads.net"
            "ads1.msn.com"
            "ads.msn.com"
            "aidps.atdmt.com"
            "aka-cdn-ns.adtech.de"
            "a-msedge.net"
            "any.edge.bing.com"
            "a.rad.msn.com"
            "az361816.vo.msecnd.net"
            "az512334.vo.msecnd.net"
            "b.ads1.msn.com"
            "b.ads2.msads.net"
            "bingads.microsoft.com"
            "b.rad.msn.com"
            "bs.serving-sys.com"
            "c.atdmt.com"
            "cdn.atdmt.com"
            "cds26.ams9.msecn.net"
            "choice.microsoft.com"
            "choice.microsoft.com.nsatc.net"
            "compatexchange.cloudapp.net"
            "corpext.msitadfs.glbdns2.microsoft.com"
            "corp.sts.microsoft.com"
            "cs1.wpc.v0cdn.net"
            "db3aqu.atdmt.com"
            "df.Telemetry.microsoft.com"
            "diagnostics.support.microsoft.com"
            "e2835.dspb.akamaiedge.net"
            "e7341.g.akamaiedge.net"
            "e7502.ce.akamaiedge.net"
            "e8218.ce.akamaiedge.net"
            "ec.atdmt.com"
            "fe2.update.microsoft.com.akadns.net"
            "feedback.microsoft-hohm.com"
            "feedback.search.microsoft.com"
            "feedback.windows.com"
            "flex.msn.com"
            "g.msn.com"
            "h1.msn.com"
            "h2.msn.com"
            "hostedocsp.globalsign.com"
            "i1.services.social.microsoft.com"
            "i1.services.social.microsoft.com.nsatc.net"
            "ipv6.msftncsi.com"
            "ipv6.msftncsi.com.edgesuite.net"
            "lb1.www.ms.akadns.net"
            "live.rads.msn.com"
            "m.adnxs.com"
            "msedge.net"
            "msftncsi.com"
            "msnbot-65-55-108-23.search.msn.com"
            "msntest.serving-sys.com"
            "oca.Telemetry.microsoft.com"
            "oca.Telemetry.microsoft.com.nsatc.net"
            "onesettings-db5.metron.live.nsatc.net"
            "pre.footprintpredict.com"
            "preview.msn.com"
            "rad.live.com"
            "rad.msn.com"
            "redir.metaservices.microsoft.com"
            "reports.wes.df.Telemetry.microsoft.com"
            "schemas.microsoft.akadns.net"
            "secure.adnxs.com"
            "secure.flashtalking.com"
            "services.wes.df.Telemetry.microsoft.com"
            "settings-sandbox.data.microsoft.com"
            #"settings-win.data.microsoft.com"       #may cause issues with Windows Updates
            "sls.update.microsoft.com.akadns.net"
            #"sls.update.microsoft.com.nsatc.net"    #may cause issues with Windows Updates
            "sqm.df.Telemetry.microsoft.com"
            "sqm.Telemetry.microsoft.com"
            "sqm.Telemetry.microsoft.com.nsatc.net"
            "ssw.live.com"
            "static.2mdn.net"
            "statsfe1.ws.microsoft.com"
            "statsfe2.update.microsoft.com.akadns.net"
            "statsfe2.ws.microsoft.com"
            "survey.watson.microsoft.com"
            "telecommand.Telemetry.microsoft.com"
            "telecommand.Telemetry.microsoft.com.nsatc.net"
            "Telemetry.appex.bing.net"
            "Telemetry.microsoft.com"
            "Telemetry.urs.microsoft.com"
            "vortex-bn2.metron.live.com.nsatc.net"
            "vortex-cy2.metron.live.com.nsatc.net"
            "vortex.data.microsoft.com"
            "vortex-sandbox.data.microsoft.com"
            "vortex-win.data.microsoft.com"
            "cy2.vortex.data.microsoft.com.akadns.net"
            "watson.live.com"
            "watson.microsoft.com"
            "watson.ppe.Telemetry.microsoft.com"
            "watson.Telemetry.microsoft.com"
            "watson.Telemetry.microsoft.com.nsatc.net"
            "wes.df.Telemetry.microsoft.com"
            "win10.ipv6.microsoft.com"
            "www.bingads.microsoft.com"
            "www.go.microsoft.akadns.net"
            "www.msftncsi.com"
            "client.wns.windows.com"
            #"wdcp.microsoft.com"                       #may cause issues with Windows Defender Cloud-based protection
            #"dns.msftncsi.com"                         #This causes Windows to think it doesn't have internet
            #"storeedgefd.dsx.mp.microsoft.com"         #breaks Windows Store
            "wdcpalt.microsoft.com"
            #"settings-ssl.xboxlive.com"                #Breaks XBOX Live Games
            #"settings-ssl.xboxlive.com-c.edgekey.net"  #Breaks XBOX Live Games
            #"settings-ssl.xboxlive.com-c.edgekey.net.globalredir.akadns.net" #Breaks XBOX Live Games
            "e87.dspb.akamaidege.net"
            "insiderservice.microsoft.com"
            "insiderservice.trafficmanager.net"
            "e3843.g.akamaiedge.net"
            "flightingserviceweurope.cloudapp.net"
            #"sls.update.microsoft.com"                 #may cause issues with Windows Updates
            "static.ads-twitter.com"                    #may cause issues with Twitter login
            "www-google-analytics.l.google.com"
            "p.static.ads-twitter.com"                  #may cause issues with Twitter login
            "hubspot.net.edge.net"
            "e9483.a.akamaiedge.net"
        
            #"www.google-analytics.com"
            #"padgead2.googlesyndication.com"
            #"mirror1.malwaredomains.com"
            #"mirror.cedia.org.ec"
            "stats.g.doubleclick.net"
            "stats.l.doubleclick.net"
            "adservice.google.de"
            "adservice.google.com"
            "googleads.g.doubleclick.net"
            "pagead46.l.doubleclick.net"
            "hubspot.net.edgekey.net"
            "insiderppe.cloudapp.net"                   #Feedback-Hub
            "livetileedge.dsx.mp.microsoft.com"
        
            #extra
            "fe2.update.microsoft.com.akadns.net"
            "s0.2mdn.net"
            "statsfe2.update.microsoft.com.akadns.net"
            "survey.watson.microsoft.com"
            "view.atdmt.com"
            "watson.microsoft.com"
            "watson.ppe.Telemetry.microsoft.com"
            "watson.Telemetry.microsoft.com"
            "watson.Telemetry.microsoft.com.nsatc.net"
            "wes.df.Telemetry.microsoft.com"
            "m.hotmail.com"
        
            #can cause issues with Skype (#79) or other services (#171)
            "apps.skype.com"
            "c.msn.com"
            #"login.live.com"                  #prevents login to outlook and other live apps
            "pricelist.skype.com"
            "s.gateway.messenger.live.com"
            "ui.skype.com"
        )
        Write-Host "" | Out-File -Encoding ASCII -Append $hosts_file
        foreach ($domain in $domains) {
            if (-Not (Select-String -Path $hosts_file -Pattern $domain)) {
                Write-Host "0.0.0.0 $domain" | Out-File -Encoding ASCII -Append $hosts_file
            }
        }
        
        Write-Host "Adding Telemetry ips to firewall"
        $ips = @(
            "134.170.30.202"
            "137.116.81.24"
            "157.56.106.189"
            "184.86.53.99"
            "2.22.61.43"
            "2.22.61.66"
            "204.79.197.200"
            "23.218.212.69"
            "65.39.117.230"
            "65.52.108.33"   #Causes problems with Microsoft Store
            "65.55.108.23"
            "64.4.54.254"
        )
        Remove-NetFirewallRule -DisplayName "Block Telemetry IPs" -ErrorAction SilentlyContinue | Out-Null
        New-NetFirewallRule -DisplayName "Block Telemetry IPs" -Direction Outbound `
            -Action Block -RemoteAddress ([string[]]$ips) | Out-Null
        
        Write-Host "Importing Policies"
        #GPO Configurations
        $gposdir = "$(Get-Location)\Files\GPOs"
        Foreach ($gpocategory in Get-ChildItem "$(Get-Location)\Files\GPOs") {
            
            Write-Host "Importing $gpocategory Policies"
        
            Foreach ($gpo in (Get-ChildItem "$(Get-Location)\Files\GPOs\$gpocategory")) {
                $gpopath = "$gposdir\$gpocategory\$gpo"
                Write-Host "Importing $gpo ...."
                .\Files\LGPO\LGPO.exe /g $gpopath > $null 2>&1
                Write-Host "Done"
            }
        }
        Add-Type -AssemblyName PresentationFramework
        $Answer = [System.Windows.MessageBox]::Show("Reboot to make changes effective?", "Restart Computer", "YesNo", "Question")
        Switch ($Answer) {
            "Yes" { Write-Host "Performing Gpupdate"; Get-Job; Gpupdate /force /boot; Write-Warning "Restarting Computer in 15 Seconds"; Start-sleep -seconds 15; Restart-Computer -Force }
            "No" { Write-Host "Performing Gpupdate" ; Get-Job; Gpupdate /force; Write-Warning "A reboot is required for all changed to take effect" }
            Default { Write-Warning "A reboot is required for all changed to take effect" }
        }
        Write-host "Completato"
    })

    $377                       = New-Object System.Windows.Forms.Button
    $377.FlatStyle             = 'Flat'
    $377.Text                  = "Si Compressione Disco e No Indicizzazione"
    $377.width                 = 300
    $377.height                = 30
    $377.Location              = New-Object System.Drawing.Point(870, 450)
    $377.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $377.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $377.Add_Click({ 
    #Enable Disk Compression and Disable File Indexing
    Start-Job -Name "Enable Disk Compression and Disable File Indexing" -ScriptBlock {
        $DriveLetters = (Get-WmiObject -Class Win32_Volume).DriveLetter
        ForEach ($Drive in $DriveLetters) {
            If (-not ([string]::IsNullOrEmpty($Drive))) {
                $indexing = $Drive.IndexingEnabled
                #Write-Host "Enabling Disk Compression on the $Drive Drive"
                #Enable-NtfsCompression -Path "$Drive"\ -Recurse
                if ("$indexing" -eq $True) {
                    Write-Host "Disabling File Index on the $Drive Drive"
                    Get-WmiObject -Class Win32_Volume -Filter "DriveLetter='$Drive'" | Set-WmiInstance -Arguments @{IndexingEnabled = $False } | Out-Null
                }
            }
        }
    }
        Write-host "Completato"
    })

    $378                       = New-Object System.Windows.Forms.Button
    $378.FlatStyle             = 'Flat'
    $378.Text                  = "Disattiva Servizi"
    $378.width                 = 300
    $378.height                = 30
    $378.Location              = New-Object System.Drawing.Point(870, 490)
    $378.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $378.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $378.Add_Click({ 
        #Disable Unnecessary Windows Services
        Stop-Service "MessagingService"
        Set-Service "MessagingService" -StartupType Disabled
        Stop-Service "PimIndexMaintenanceSvc"
        Set-Service "PimIndexMaintenanceSvc" -StartupType Disabled
        Stop-Service "RetailDemo"
        Set-Service "RetailDemo" -StartupType Disabled
        Stop-Service "MapsBroker"
        Set-Service "MapsBroker" -StartupType Disabled
        Stop-Service "wlidsvc"
        Set-Service "wlidsvc" -StartupType Disabled
        Stop-Service "DoSvc"
        Set-Service "DoSvc" -StartupType Disabled
        Stop-Service "OneSyncSvc"
        Set-Service "OneSyncSvc" -StartupType Disabled
        Stop-Service "UnistoreSvc"
        Set-Service "UnistoreSvc" -StartupType Disabled





    #   Description:
    # This script disables unwanted Windows services. If you do not want to disable
    # certain services comment out the corresponding lines below.

    $services = @(
        "diagnosticshub.standardcollector.service" # Microsoft (R) Diagnostics Hub Standard Collector Service
        "DiagTrack"                                # Diagnostics Tracking Service
        "dmwappushservice"                         # WAP Push Message Routing Service (see known issues)
        "lfsvc"                                    # Geolocation Service
        "MapsBroker"                               # Downloaded Maps Manager
        "NetTcpPortSharing"                        # Net.Tcp Port Sharing Service
        "RemoteAccess"                             # Routing and Remote Access
        "RemoteRegistry"                           # Remote Registry
        "SharedAccess"                             # Internet Connection Sharing (ICS)
        "TrkWks"                                   # Distributed Link Tracking Client
        "WbioSrvc"                                 # Windows Biometric Service (required for Fingerprint reader / facial detection)
        #"WlanSvc"                                 # WLAN AutoConfig
        "WMPNetworkSvc"                            # Windows Media Player Network Sharing Service
        #"wscsvc"                                  # Windows Security Center Service
        #"WSearch"                                 # Windows Search
        "XblAuthManager"                           # Xbox Live Auth Manager
        "XblGameSave"                              # Xbox Live Game Save Service
        "XboxNetApiSvc"                            # Xbox Live Networking Service
        "ndu"                                      # Windows Network Data Usage Monitor
        # Services which cannot be disabled
        #"WdNisSvc"
    )

    foreach ($service in $services) {
        Write-Host "Trying to disable $service"
        Get-Service -Name $service | Set-Service -StartupType Disabled
    }

        Write-host "Completato"
    })

    $379                       = New-Object System.Windows.Forms.Button
    $379.FlatStyle             = 'Flat'
    $379.Text                  = "Disattiva Sticky Keys Prompt"
    $379.width                 = 300
    $379.height                = 30
    $379.Location              = New-Object System.Drawing.Point(870, 530)
    $379.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $379.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $379.Add_Click({ 
    # Disable Sticky keys prompt
        Write-Host "Disabling Sticky keys prompt..."
        Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "506"
        Write-host "Completato"
    })

    $3110                       = New-Object System.Windows.Forms.Button
    $3110.FlatStyle             = 'Flat'
    $3110.Text                  = "Revert"
    $3110.width                 = 100
    $3110.height                = 30
    $3110.Location              = New-Object System.Drawing.Point(1180, 530)
    $3110.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $3110.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $3110.Add_Click({ 
    # Enable Sticky keys prompt
        Write-Host "Enabling Sticky keys prompt..."
        Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "510"
        Write-host "Completato"
    })

    $380                       = New-Object System.Windows.Forms.Button
    $380.FlatStyle             = 'Flat'
    $380.Text                  = "Treat As Internal Port"
    $380.width                 = 300
    $380.height                = 30
    $380.Location              = New-Object System.Drawing.Point(870, 570)
    $380.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $380.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $380.Add_Click({ 
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" -Name "TreatAsInternalPort"   -Type MultiString -Value 0,1,2,3,4,5
        Write-host "Completato"
    })

    $381                       = New-Object System.Windows.Forms.Button
    $381.FlatStyle             = 'Flat'
    $381.Text                  = "Revert"
    $381.width                 = 100
    $381.height                = 30
    $381.Location              = New-Object System.Drawing.Point(320, 130)
    $381.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $381.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $381.Add_Click({ 
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 3
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 3
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 3
    Start-Service DiagTrack | Set-Service -StartupType Automatic
    Start-Service dmwappushservice | Set-Service -StartupType Automatic
    Write-host "Completato"
    })


    $382                       = New-Object System.Windows.Forms.Button
    $382.FlatStyle             = 'Flat'
    $382.Text                  = "Disattiva Autoplay"
    $382.width                 = 300
    $382.height                = 30
    $382.Location              = New-Object System.Drawing.Point(870, 610)
    $382.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $382.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $382.Add_Click({ 
    # Disable Autoplay
        Write-Host "Disabling Autoplay..."
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" -Name "DisableAutoplay" -Type DWord -Value 1
        Write-host "Completato"
    })

    $383                       = New-Object System.Windows.Forms.Button
    $383.FlatStyle             = 'Flat'
    $383.Text                  = "Revert"
    $383.width                 = 100
    $383.height                = 30
    $383.Location              = New-Object System.Drawing.Point(1180, 610)
    $383.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $383.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $383.Add_Click({ 
    # Enable Autoplay
        Write-Host "Enabling Autoplay..."
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" -Name "DisableAutoplay" -Type DWord -Value 0
        Write-host "Completato"
    })

    $384                       = New-Object System.Windows.Forms.Button
    $384.FlatStyle             = 'Flat'
    $384.Text                  = "Disattiva Fast Startup"
    $384.width                 = 300
    $384.height                = 30
    $384.Location              = New-Object System.Drawing.Point(870, 650)
    $384.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $384.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $384.Add_Click({ 
    # Disable Fast Startup
        Write-Host "Disabling Fast Startup..."
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Type DWord -Value 0
        Write-host "Completato"
    })
    
    $385                       = New-Object System.Windows.Forms.Button
    $385.FlatStyle             = 'Flat'
    $385.Text                  = "Revert"
    $385.width                 = 100
    $385.height                = 30
    $385.Location              = New-Object System.Drawing.Point(1180, 650)
    $385.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $385.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $385.Add_Click({ 
    # Enable Fast Startup
        Write-Host "Enabling Fast Startup..."
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Type DWord -Value 1
        Write-host "Completato"
    })

    $386                       = New-Object System.Windows.Forms.Button
    $386.FlatStyle             = 'Flat'
    $386.Text                  = "Disattiva Autorun per tutti i dispositivi"
    $386.width                 = 300
    $386.height                = 30
    $386.Location              = New-Object System.Drawing.Point(870, 690)
    $386.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $386.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $386.Add_Click({ 
    # Disable Autorun for all drives
        Write-Host "Disabling Autorun for all drives..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -Type DWord -Value 255
        Write-host "Completato"
    })

    $387                       = New-Object System.Windows.Forms.Button
    $387.FlatStyle             = 'Flat'
    $387.Text                  = "Revert"
    $387.width                 = 100
    $387.height                = 30
    $387.Location              = New-Object System.Drawing.Point(1180, 690)
    $387.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $387.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $387.Add_Click({ 
    # Enable Autorun for removable drives
        Write-Host "Enabling Autorun for all drives..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $388                       = New-Object System.Windows.Forms.Button
    $388.FlatStyle             = 'Flat'
    $388.Text                  = "Disattiva Desktop Remoto"
    $388.width                 = 300
    $388.height                = 30
    $388.Location              = New-Object System.Drawing.Point(870, 730)
    $388.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $388.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $388.Add_Click({ 
    # Disable Remote Desktop
        Write-Host "Disabling Remote Desktop..."
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Type DWord -Value 1
        Disable-NetFirewallRule -Name "RemoteDesktop*"
        Write-host "Completato"
    })

    $389                       = New-Object System.Windows.Forms.Button
    $389.FlatStyle             = 'Flat'
    $389.Text                  = "Revert"
    $389.width                 = 100
    $389.height                = 30
    $389.Location              = New-Object System.Drawing.Point(1180, 730)
    $389.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $389.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $389.Add_Click({ 
    # Enable Remote Desktop w/o Network Level Authentication
        Write-Host "Enabling Remote Desktop w/o Network Level Authentication..."
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Type DWord -Value 0
        Enable-NetFirewallRule -Name "RemoteDesktop*"
        Write-host "Completato"
    })

    $390                       = New-Object System.Windows.Forms.Button
    $390.FlatStyle             = 'Flat'
    $390.Text                  = "Revert"
    $390.width                 = 100
    $390.height                = 30
    $390.Location              = New-Object System.Drawing.Point(320, 410)
    $390.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $390.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $390.Add_Click({ 
    # Enable Remote Assistance - Not applicable to Server (unless Remote Assistance is explicitly installed)
        Write-Host "Enabling Remote Assistance..."
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Type DWord -Value 1
        Write-host "Completato"
    })

    $391                       = New-Object System.Windows.Forms.Button
    $391.FlatStyle             = 'Flat'
    $391.Text                  = "Disattiva Indicizzazione"
    $391.width                 = 300
    $391.height                = 30
    $391.Location              = New-Object System.Drawing.Point(870, 770)
    $391.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $391.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $391.Add_Click({ 
        $obj = Get-WmiObject -Class Win32_Volume -Filter "DriveLetter='$Drive'"
        $indexing = $obj.IndexingEnabled
        if("$indexing" -eq $True){
            write-host "Disabling indexing of drive $Drive"
            $obj | Set-WmiInstance -Arguments @{IndexingEnabled=$False} | Out-Null
        }
        Write-host "Completato"
    })

    $394                       = New-Object System.Windows.Forms.Button
    $394.FlatStyle             = 'Flat'
    $394.Text                  = "Disattiva 'Cerca un'app nello store'"
    $394.width                 = 300
    $394.height                = 30
    $394.Location              = New-Object System.Drawing.Point(870, 810)
    $394.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $394.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $394.Add_Click({ 
    # Disable search for app in store for unknown extensions
    Write-Host "Disabling search for app in store for unknown extensions..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoUseStoreOpenWith" -Type DWord -Value 1
        Write-host "Completato"
    })

    $395                       = New-Object System.Windows.Forms.Button
    $395.FlatStyle             = 'Flat'
    $395.Text                  = "Revert"
    $395.width                 = 100
    $395.height                = 30
    $395.Location              = New-Object System.Drawing.Point(1180, 810)
    $395.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $395.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $395.Add_Click({ 
    # Enable search for app in store for unknown extensions
        Write-Host "Enabling search for app in store for unknown extensions..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoUseStoreOpenWith" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $396                       = New-Object System.Windows.Forms.Button
    $396.FlatStyle             = 'Flat'
    $396.Text                  = "Disattiva 'Come vuoi aprire questo file'"
    $396.width                 = 300
    $396.height                = 30
    $396.Location              = New-Object System.Drawing.Point(870, 850)
    $396.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $396.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $396.Add_Click({ 
    # Disable 'How do you want to open this file?' prompt
        Write-Host "Disabling 'How do you want to open this file?' prompt..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoNewAppAlert" -Type DWord -Value 1
        Write-host "Completato"
    })

    $397                       = New-Object System.Windows.Forms.Button
    $397.FlatStyle             = 'Flat'
    $397.Text                  = "Revert"
    $397.width                 = 100
    $397.height                = 30
    $397.Location              = New-Object System.Drawing.Point(1180, 850)
    $397.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $397.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $397.Add_Click({ 
    
    # Enable 'How do you want to open this file?' prompt
        Write-Host "Enabling 'How do you want to open this file?' prompt..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoNewAppAlert" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $398                       = New-Object System.Windows.Forms.Button
    $398.FlatStyle             = 'Flat'
    $398.Text                  = "Disattiva Lista File Recenti"
    $398.width                 = 300
    $398.height                = 30
    $398.Location              = New-Object System.Drawing.Point(870, 890)
    $398.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $398.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $398.Add_Click({ 
    # Disable recent files lists
    # Stops creating most recently used (MRU) items lists such as 'Recent Items' menu on the Start menu, jump lists, and shortcuts at the bottom of the 'File' menu in applications.
        Write-Host "Disabling recent files lists..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsHistory" -Type DWord -Value 1
        Write-host "Completato"
    })

    $399                       = New-Object System.Windows.Forms.Button
    $399.FlatStyle             = 'Flat'
    $399.Text                  = "Revert"
    $399.width                 = 100
    $399.height                = 30
    $399.Location              = New-Object System.Drawing.Point(1180, 890)
    $399.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $399.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $399.Add_Click({ 
    # Enable recent files lists
        Write-Host "Enabling recent files lists..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsHistory" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $3100                       = New-Object System.Windows.Forms.Button
    $3100.FlatStyle             = 'Flat'
    $3100.Text                  = "Attiva Pulizia File Recenti all'uscita"
    $3100.width                 = 300
    $3100.height                = 30
    $3100.Location              = New-Object System.Drawing.Point(870, 930)
    $3100.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $3100.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $3100.Add_Click({ 
    # Enable clearing of recent files on exit
    # Empties most recently used (MRU) items lists such as 'Recent Items' menu on the Start menu, jump lists, and shortcuts at the bottom of the 'File' menu in applications during every logout.
        Write-Host "Enabling clearing of recent files on exit..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "ClearRecentDocsOnExit" -Type DWord -Value 1
        Write-host "Completato"
    })

    $3101                       = New-Object System.Windows.Forms.Button
    $3101.FlatStyle             = 'Flat'
    $3101.Text                  = "Revert"
    $3101.width                 = 100
    $3101.height                = 30
    $3101.Location              = New-Object System.Drawing.Point(1180, 930)
    $3101.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $3101.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $3101.Add_Click({ 
    # Disable clearing of recent files on exit
        Write-Host "Disabling clearing of recent files on exit..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "ClearRecentDocsOnExit" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $3102                       = New-Object System.Windows.Forms.Button
    $3102.FlatStyle             = 'Flat'
    $3102.Text                  = "Revert"
    $3102.width                 = 100
    $3102.height                = 30
    $3102.Location              = New-Object System.Drawing.Point(320, 530)
    $3102.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $3102.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $3102.Add_Click({ 
    # Enable Hibernation - Do not use on Server with automatically started Hyper-V hvboot service as it may lead to BSODs (Win10 with Hyper-V is fine)
        Write-Host "Enabling Hibernation..."
        Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernteEnabled" -Type Dword -Value 1
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type Dword -Value 1
        Write-host "Completato"
    })

    $3103                       = New-Object System.Windows.Forms.Button
    $3103.FlatStyle             = 'Flat'
    $3103.Text                  = "Revert"
    $3103.width                 = 100
    $3103.height                = 30
    $3103.Location              = New-Object System.Drawing.Point(320, 250)
    $3103.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $3103.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $3103.Add_Click({ 
    # Enable Error reporting
        Write-Host "Enabling Error reporting..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -ErrorAction SilentlyContinue
        Enable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
        Write-host "Completato"
    })

    $3104                       = New-Object System.Windows.Forms.Button
    $3104.FlatStyle             = 'Flat'
    $3104.Text                  = "Revert"
    $3104.width                 = 100
    $3104.height                = 30
    $3104.Location              = New-Object System.Drawing.Point(320, 290)
    $3104.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $3104.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $3104.Add_Click({ 
    # Enable and start Diagnostics Tracking Service
        Write-Host "Enabling and starting Diagnostics Tracking Service..."
        Set-Service "DiagTrack" -StartupType Automatic
        Start-Service "DiagTrack" -WarningAction SilentlyContinue
        Write-host "Completato"
    })

    $3105                       = New-Object System.Windows.Forms.Button
    $3105.FlatStyle             = 'Flat'
    $3105.Text                  = "Revert"
    $3105.width                 = 100
    $3105.height                = 30
    $3105.Location              = New-Object System.Drawing.Point(320, 330)
    $3105.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $3105.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $3105.Add_Click({ 
    # Enable and start WAP Push Service
        Write-Host "Enabling and starting WAP Push Service..."
        Set-Service "dmwappushservice" -StartupType Automatic
        Start-Service "dmwappushservice" -WarningAction SilentlyContinue
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\dmwappushservice" -Name "DelayedAutoStart" -Type DWord -Value 1
        Write-host "Completato"
    })

    $3106                       = New-Object System.Windows.Forms.Button
    $3106.FlatStyle             = 'Flat'
    $3106.Text                  = "Revert"
    $3106.width                 = 100
    $3106.height                = 30
    $3106.Location              = New-Object System.Drawing.Point(320, 810)
    $3106.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $3106.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $3106.Add_Click({ 
    # Enable scheduled defragmentation task
        Write-Host "Enabling scheduled defragmentation..."
        Enable-ScheduledTask -TaskName "Microsoft\Windows\Defrag\ScheduledDefrag" | Out-Null
        Write-host "Completato"
    })    

    $3107                       = New-Object System.Windows.Forms.Button
    $3107.FlatStyle             = 'Flat'
    $3107.Text                  = "Revert"
    $3107.width                 = 100
    $3107.height                = 30
    $3107.Location              = New-Object System.Drawing.Point(320, 490)
    $3107.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $3107.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $3107.Add_Click({ 
    
    # Start and enable Superfetch service - Not applicable to Server
        Write-Host "Starting and enabling Superfetch service..."
        Set-Service "SysMain" -StartupType Automatic
        Start-Service "SysMain" -WarningAction SilentlyContinue
        Write-host "Completato"
    })

    $3108                       = New-Object System.Windows.Forms.Button
    $3108.FlatStyle             = 'Flat'
    $3108.Text                  = "Revert"
    $3108.width                 = 100
    $3108.height                = 30
    $3108.Location              = New-Object System.Drawing.Point(320, 450)
    $3108.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $3108.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $3108.Add_Click({ 
    # Enable Storage Sense - automatic disk cleanup - Not applicable to Server
        Write-Host "Attiva Controllo Archiviazione..."
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "01" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "04" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "08" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "32" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "StoragePoliciesNotified" -Type DWord -Value 1
        Write-host "Completato"
    })

    $3109                       = New-Object System.Windows.Forms.Button
    $3109.FlatStyle             = 'Flat'
    $3109.Text                  = "Revert"
    $3109.width                 = 100
    $3109.height                = 30
    $3109.Location              = New-Object System.Drawing.Point(1180, 130)
    $3109.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $3109.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $3109.Add_Click({ 
        Write-Host "Hiding tray icons..."
        Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -ErrorAction SilentlyContinue 
        Write-Host "Done - Reverted to Stock Settings"
        
        Write-host "Completato"
    })

    $3CustomizeForm.controls.AddRange(@($31,$32,$33,$34,$35,$36,$37,$38,$39,$310,$311,$312,$313,$314,$315,$316,$317,$318,$319,$320,$321,$322,$323,$324,$325,$326,$327,$328,$329,$330,$331,$332,$333,$334,$335,$336,$337,$338,$339,$340,$341,$342,$343,$344,$345,$346,$347,$348,$349,$350,$351,$352,$353,$354,$355,$356,$357,$358,$359,$360,$361,$362,$363,$364,$365,$366,$367,$368,$369,$370,$371,$372,$373,$374,$375,$376,$377,$378,$379,$380,$381,$382,$383,$384,$385,$386,$387,$388,$389,$390,$391,$392,$393,$394,$395,$396,$397,$398,$399,$3100,$3101,$3102,$3103,$3104,$3105,$3106,$3107,$3108,$3109,$3110))

            Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }
    
    [void]$3CustomizeForm.ShowDialog()

})

##########################
### END TWEAKS PRIVACY ###
##########################

##############
### UPDATE ###
##############

$Button4.Add_Click({
    $4CustomizeForm                  = New-Object System.Windows.Forms.Form
    $4CustomizeForm.ClientSize       = New-Object System.Drawing.Point(430,370)
    $4CustomizeForm.StartPosition    = 'CenterScreen'
    $4CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $4CustomizeForm.MinimizeBox      = $false
    $4CustomizeForm.MaximizeBox      = $false
    $4CustomizeForm.ShowIcon         = $false
    $4CustomizeForm.Text             = "Tweaks Update"
    $4CustomizeForm.TopMost          = $false
    $4CustomizeForm.AutoScroll       = $false
    $4CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

    $41                       = New-Object System.Windows.Forms.Button
    $41.FlatStyle             = 'Flat'
    $41.Text                  = "Disattiva Risveglio per Aggiornamenti"
    $41.width                 = 300
    $41.height                = 30
    $41.Location              = New-Object System.Drawing.Point(10, 10)
    $41.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $41.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $41.Add_Click({ 
        Write-Host "Disabling nightly wake-up for Automatic Maintenance..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "WakeUp" -Type DWord -Value 0
        Write-host "Completato"
    })
    
    $42                       = New-Object System.Windows.Forms.Button
    $42.FlatStyle             = 'Flat'
    $42.Text                  = "Revert"
    $42.width                 = 100
    $42.height                = 30
    $42.Location              = New-Object System.Drawing.Point(320, 10)
    $42.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $42.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $42.Add_Click({ 
        Write-Host "Enabling nightly wake-up for Automatic Maintenance..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "WakeUp" -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })

    $43                       = New-Object System.Windows.Forms.Button
    $43.FlatStyle             = 'Flat'
    $43.Text                  = "Disattiva Download Automatico Aggiornamenti"
    $43.width                 = 300
    $43.height                = 30
    $43.Location              = New-Object System.Drawing.Point(10, 50)
    $43.Font                  = New-Object System.Drawing.Font('Consolas',8)
    $43.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $43.Add_Click({ 
        Write-Host "Disabling Windows Update automatic downloads..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -Type DWord -Value 2
    }
        Write-host "Completato"
    })
    
    $44                       = New-Object System.Windows.Forms.Button
    $44.FlatStyle             = 'Flat'
    $44.Text                  = "Revert"
    $44.width                 = 100
    $44.height                = 30
    $44.Location              = New-Object System.Drawing.Point(320, 50)
    $44.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $44.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $44.Add_Click({ 
        Write-Host "Enabling Windows Update automatic downloads..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $45                       = New-Object System.Windows.Forms.Button
    $45.FlatStyle             = 'Flat'
    $45.Text                  = "Disattiva Aggiornamenti Dispositivi Microsoft"
    $45.width                 = 300
    $45.height                = 30
    $45.Location              = New-Object System.Drawing.Point(10, 90)
    $45.Font                  = New-Object System.Drawing.Font('Consolas',8)
    $45.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $45.Add_Click({ 
        Write-Host "Disabling updates for other Microsoft products..."
        If ((New-Object -ComObject Microsoft.Update.ServiceManager).Services | Where-Object { $_.ServiceID -eq "7971f918-a847-4430-9279-4a52d1efe18d"}) {
            (New-Object -ComObject Microsoft.Update.ServiceManager).RemoveService("7971f918-a847-4430-9279-4a52d1efe18d") | Out-Null
        }
    
        Write-host "Completato"
    })
    
    $46                       = New-Object System.Windows.Forms.Button
    $46.FlatStyle             = 'Flat'
    $46.Text                  = "Revert"
    $46.width                 = 100
    $46.height                = 30
    $46.Location              = New-Object System.Drawing.Point(320, 90)
    $46.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $46.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $46.Add_Click({ 
        Write-Host "Enabling updates for other Microsoft products..."
        (New-Object -ComObject Microsoft.Update.ServiceManager).AddService2("7971f918-a847-4430-9279-4a52d1efe18d", 7, "") | Out-Null
        Write-host "Completato"
    })

    $47                       = New-Object System.Windows.Forms.Button
    $47.FlatStyle             = 'Flat'
    $47.Text                  = "Disattiva Tool Malicious Software Removal"
    $47.width                 = 300
    $47.height                = 30
    $47.Location              = New-Object System.Drawing.Point(10, 130)
    $47.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $47.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $47.Add_Click({ 
        Write-Host "Disabling Malicious Software Removal Tool offering..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT" -Name "DontOfferThroughWUAU" -Type DWord -Value 1
    
        Write-host "Completato"
    })
    
    $48                       = New-Object System.Windows.Forms.Button
    $48.FlatStyle             = 'Flat'
    $48.Text                  = "Revert"
    $48.width                 = 100
    $48.height                = 30
    $48.Location              = New-Object System.Drawing.Point(320, 130)
    $48.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $48.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $48.Add_Click({ 
        Write-Host "Enabling Malicious Software Removal Tool offering..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT" -Name "DontOfferThroughWUAU" -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })

    $49                       = New-Object System.Windows.Forms.Button
    $49.FlatStyle             = 'Flat'
    $49.Text                  = "P2P Update solo per Rete Privata"
    $49.width                 = 300
    $49.height                = 30
    $49.Location              = New-Object System.Drawing.Point(10, 170)
    $49.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $49.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $49.Add_Click({ 
        Write-Host "Restricting Windows Update P2P optimization to local network..."
        If ([System.Environment]::OSVersion.Version.Build -eq 10240) {
            # Method used in 1507
            If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")) {
                New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 1
        } ElseIf ([System.Environment]::OSVersion.Version.Build -le 14393) {
            # Method used in 1511 and 1607
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Type DWord -Value 1
        } Else {
            # Method used since 1703
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -ErrorAction SilentlyContinue
        }
        Write-host "Completato"
    })
    
    $410                       = New-Object System.Windows.Forms.Button
    $410.FlatStyle             = 'Flat'
    $410.Text                  = "Revert"
    $410.width                 = 100
    $410.height                = 30
    $410.Location              = New-Object System.Drawing.Point(320, 170)
    $410.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $410.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $410.Add_Click({ 
        Write-Host "Unrestricting Windows Update P2P optimization to internet..."
        If ([System.Environment]::OSVersion.Version.Build -eq 10240) {
            # Method used in 1507
            If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")) {
                New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 3
        } ElseIf ([System.Environment]::OSVersion.Version.Build -le 14393) {
            # Method used in 1511 and 1607
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -ErrorAction SilentlyContinue
        } Else {
            # Method used since 1703
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Type DWord -Value 3
        }
        Write-host "Completato"
    })

    $411                       = New-Object System.Windows.Forms.Button
    $411.FlatStyle             = 'Flat'
    $411.Text                  = "Default Windows Update"
    $411.width                 = 300
    $411.height                = 30
    $411.Location              = New-Object System.Drawing.Point(10, 210)
    $411.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $411.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $411.Add_Click({ 
        Write-Host "Enabling driver offering through Windows Update..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -ErrorAction SilentlyContinue
        Write-Host "Enabling Windows Update automatic restart..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })
    
    $412                       = New-Object System.Windows.Forms.Button
    $412.FlatStyle             = 'Flat'
    $412.Text                  = "Security"
    $412.width                 = 100
    $412.height                = 30
    $412.Location              = New-Object System.Drawing.Point(320, 210)
    $412.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $412.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $412.Add_Click({ 
        Write-Host "Disabling driver offering through Windows Update..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Type DWord -Value 1
        Write-Host "Disabling Windows Update automatic restart..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
        Write-host "Completato"
    })

    $413                       = New-Object System.Windows.Forms.Button
    $413.FlatStyle             = 'Flat'
    $413.Text                  = "Disattiva Download Driver da Windows Update"
    $413.width                 = 300
    $413.height                = 30
    $413.Location              = New-Object System.Drawing.Point(10, 250)
    $413.Font                  = New-Object System.Drawing.Font('Consolas',8)
    $413.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $413.Add_Click({ 
        Write-Host "Disabling driver offering through Windows Update..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "SearchOrderConfig" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Type DWord -Value 1
    
        Write-host "Completato"
    })
    
    $414                       = New-Object System.Windows.Forms.Button
    $414.FlatStyle             = 'Flat'
    $414.Text                  = "Revert"
    $414.width                 = 100
    $414.height                = 30
    $414.Location              = New-Object System.Drawing.Point(320, 250)
    $414.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $414.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $414.Add_Click({ 
        Write-Host "Enabling driver offering through Windows Update..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "SearchOrderConfig" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $415                       = New-Object System.Windows.Forms.Button
    $415.FlatStyle             = 'Flat'
    $415.Text                  = "Disattiva Riavvio Automatico dopo Update"
    $415.width                 = 300
    $415.height                = 30
    $415.Location              = New-Object System.Drawing.Point(10, 290)
    $415.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $415.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $415.Add_Click({ 
        Write-Host "Disabling Windows Update automatic restart..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe" -Name "Debugger" -Type String -Value "cmd.exe"
    
        Write-host "Completato"
    })
    
    $416                       = New-Object System.Windows.Forms.Button
    $416.FlatStyle             = 'Flat'
    $416.Text                  = "Revert"
    $416.width                 = 100
    $416.height                = 30
    $416.Location              = New-Object System.Drawing.Point(320, 290)
    $416.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $416.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $416.Add_Click({ 
        Write-Host "Enabling Windows Update automatic restart..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe" -Name "Debugger" -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })

    $417                       = New-Object System.Windows.Forms.Button
    $417.FlatStyle             = 'Flat'
    $417.Text                  = "Disattiva Notifiche Aggiornamenti"
    $417.width                 = 300
    $417.height                = 30
    $417.Location              = New-Object System.Drawing.Point(10, 330)
    $417.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $417.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $417.Add_Click({ 
        Write-Host "Disable 'Updates are available' message"
        takeown /F "$env:WinDIR\System32\MusNotification.exe"
        icacls "$env:WinDIR\System32\MusNotification.exe" /deny "$($EveryOne):(X)"
        takeown /F "$env:WinDIR\System32\MusNotificationUx.exe"
        icacls "$env:WinDIR\System32\MusNotificationUx.exe" /deny "$($EveryOne):(X)"
        
        Write-host "Completato"
    })

    $4CustomizeForm.controls.AddRange(@($41,$42,$43,$44,$45,$46,$47,$48,$49,$410,$411,$412,$413,$414,$415,$416,$417))

            Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }
    
    [void]$4CustomizeForm.ShowDialog()

})

##################
### END UPDATE ###
##################

################
### SECURITY ###
################

$Button5.Add_Click({
    $5CustomizeForm                  = New-Object System.Windows.Forms.Form
    $5CustomizeForm.ClientSize       = New-Object System.Drawing.Point(430,970)
    $5CustomizeForm.StartPosition    = 'CenterScreen'
    $5CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $5CustomizeForm.MinimizeBox      = $false
    $5CustomizeForm.MaximizeBox      = $true
    $5CustomizeForm.ShowIcon         = $false
    $5CustomizeForm.Text             = "Tweaks Security"
    $5CustomizeForm.TopMost          = $false
    $5CustomizeForm.AutoScroll       = $true
    $5CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

	$51                       = New-Object System.Windows.Forms.Button
	$51.FlatStyle             = 'Flat'
	$51.Text                  = "Abilita Controllo Accesso Cartelle"
	$51.width                 = 300
	$51.height                = 30
	$51.Location              = New-Object System.Drawing.Point(10, 10)
	$51.Font                  = New-Object System.Drawing.Font('Consolas',9)
	$51.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
	
	$51.Add_Click({ 
		Write-Host "Enabling Controlled Folder Access..."
		Set-MpPreference -EnableControlledFolderAccess Enabled -ErrorAction SilentlyContinue
		
		Write-host "Completato"
	})
	
	$52                       = New-Object System.Windows.Forms.Button
	$52.FlatStyle             = 'Flat'
	$52.Text                  = "Revert"
	$52.width                 = 100
	$52.height                = 30
	$52.Location              = New-Object System.Drawing.Point(320, 10)
	$52.Font                  = New-Object System.Drawing.Font('Consolas',9)
	$52.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
	 
	$52.Add_Click({ 
		Write-Host "Disabling Controlled Folder Access..."
		Set-MpPreference -EnableControlledFolderAccess Disabled -ErrorAction SilentlyContinue
		
		Write-host "Completato"
	})

	$53                       = New-Object System.Windows.Forms.Button
    $53.FlatStyle             = 'Flat'
    $53.Text                  = "Abilita Core Isolation Memory Integrity"
    $53.width                 = 300
    $53.height                = 30
    $53.Location              = New-Object System.Drawing.Point(10, 50)
    $53.Font                  = New-Object System.Drawing.Font('Consolas',8)
    $53.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $53.Add_Click({ 
        Write-Host "Enabling Core Isolation Memory Integrity..."
        If (!(Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity")) {
            New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name "Enabled" -Type DWord -Value 1
        
        Write-host "Completato"
    })
    
    $54                       = New-Object System.Windows.Forms.Button
    $54.FlatStyle             = 'Flat'
    $54.Text                  = "Revert"
    $54.width                 = 100
    $54.height                = 30
    $54.Location              = New-Object System.Drawing.Point(320, 50)
    $54.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $54.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $54.Add_Click({ 
        Write-Host "Disabling Core Isolation Memory Integrity..."
        Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name "Enabled" -ErrorAction SilentlyContinue        
        Write-host "Completato"
    })

    $55                       = New-Object System.Windows.Forms.Button
    $55.FlatStyle             = 'Flat'
    $55.Text                  = "Abilita Defender Application Guard"
    $55.width                 = 300
    $55.height                = 30
    $55.Location              = New-Object System.Drawing.Point(10, 90)
    $55.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $55.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $55.Add_Click({ 
        Write-Host "Enabling Windows Defender Application Guard..."
        Enable-WindowsOptionalFeature -online -FeatureName "Windows-Defender-ApplicationGuard" -NoRestart -WarningAction SilentlyContinue | Out-Null
        
        Write-host "Completato"
    })
    
    $56                       = New-Object System.Windows.Forms.Button
    $56.FlatStyle             = 'Flat'
    $56.Text                  = "Revert"
    $56.width                 = 100
    $56.height                = 30
    $56.Location              = New-Object System.Drawing.Point(320, 90)
    $56.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $56.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $56.Add_Click({ 
        Write-Host "Disabling Windows Defender Application Guard..."
        Disable-WindowsOptionalFeature -online -FeatureName "Windows-Defender-ApplicationGuard" -NoRestart -WarningAction SilentlyContinue | Out-Null
        
        
        Write-host "Completato"
    })

    $57                       = New-Object System.Windows.Forms.Button
    $57.FlatStyle             = 'Flat'
    $57.Text                  = "Disattiva Messaggi Account Offline"
    $57.width                 = 300
    $57.height                = 30
    $57.Location              = New-Object System.Drawing.Point(10, 130)
    $57.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $57.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $57.Add_Click({ 
        Write-Host "Hiding Account Protection warning..."
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows Security Health\State")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows Security Health\State" -Force | Out-Null
        }
        Set-ItemProperty "HKCU:\Software\Microsoft\Windows Security Health\State" -Name "AccountProtection_MicrosoftAccount_Disconnected" -Type DWord -Value 1
        
        Write-host "Completato"
    })
    
    $58                       = New-Object System.Windows.Forms.Button
    $58.FlatStyle             = 'Flat'
    $58.Text                  = "Revert"
    $58.width                 = 100
    $58.height                = 30
    $58.Location              = New-Object System.Drawing.Point(320, 130)
    $58.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $58.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $58.Add_Click({ 
        Write-Host "Showing Account Protection warning..."
        Remove-ItemProperty "HKCU:\Software\Microsoft\Windows Security Health\State" -Name "AccountProtection_MicrosoftAccount_Disconnected" -ErrorAction SilentlyContinue
        
        Write-host "Completato"
    })

    $59                       = New-Object System.Windows.Forms.Button
    $59.FlatStyle             = 'Flat'
    $59.Text                  = "Disattiva Blocco File Scaricati"
    $59.width                 = 300
    $59.height                = 30
    $59.Location              = New-Object System.Drawing.Point(10, 170)
    $59.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $59.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $59.Add_Click({ 
        Write-Host "Disabling blocking of downloaded files..."
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -Type DWord -Value 1
        
        Write-host "Completato"
    })
    
    $510                       = New-Object System.Windows.Forms.Button
    $510.FlatStyle             = 'Flat'
    $510.Text                  = "Revert"
    $510.width                 = 100
    $510.height                = 30
    $510.Location              = New-Object System.Drawing.Point(320, 170)
    $510.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $510.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $510.Add_Click({ 
        Write-Host "Enabling blocking of downloaded files..."
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -ErrorAction SilentlyContinue        
        Write-host "Completato"
    })

    $511                       = New-Object System.Windows.Forms.Button
    $511.FlatStyle             = 'Flat'
    $511.Text                  = "Disattiva esecuzione di *vbs script"
    $511.width                 = 300
    $511.height                = 30
    $511.Location              = New-Object System.Drawing.Point(10, 210)
    $511.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $511.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $511.Add_Click({ 
        Write-Host "Disabling Windows Script Host..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Script Host\Settings" -Name "Enabled" -Type DWord -Value 0
        
        Write-host "Completato"
    })
    
    $512                       = New-Object System.Windows.Forms.Button
    $512.FlatStyle             = 'Flat'
    $512.Text                  = "Revert"
    $512.width                 = 100
    $512.height                = 30
    $512.Location              = New-Object System.Drawing.Point(320, 210)
    $512.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $512.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $512.Add_Click({ 
        Write-Host "Enabling Windows Script Host..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Script Host\Settings" -Name "Enabled" -ErrorAction SilentlyContinue
        
        Write-host "Completato"
    })

    $513                       = New-Object System.Windows.Forms.Button
    $513.FlatStyle             = 'Flat'
    $513.Text                  = "Strong Cryptography per <4.6 .Net"
    $513.width                 = 300
    $513.height                = 30
    $513.Location              = New-Object System.Drawing.Point(10, 250)
    $513.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $513.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $513.Add_Click({ 
        Write-Host "Enabling .NET strong cryptography..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -Type DWord -Value 1
        
        Write-host "Completato"
    })
    
    $514                       = New-Object System.Windows.Forms.Button
    $514.FlatStyle             = 'Flat'
    $514.Text                  = "Revert"
    $514.width                 = 100
    $514.height                = 30
    $514.Location              = New-Object System.Drawing.Point(320, 250)
    $514.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $514.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $514.Add_Click({ 
        Write-Host "Disabling .NET strong cryptography..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -ErrorAction SilentlyContinue
        
        Write-host "Completato"
    })

    $515                       = New-Object System.Windows.Forms.Button
    $515.FlatStyle             = 'Flat'
    $515.Text                  = "Attiva Metldown Flag"
    $515.width                 = 300
    $515.height                = 30
    $515.Location              = New-Object System.Drawing.Point(10, 290)
    $515.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $515.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $515.Add_Click({ 
        Write-Host "Enabling Meltdown (CVE-2017-5754) compatibility flag..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat" -Name "cadca5fe-87d3-4b96-b7fb-a231484277cc" -Type DWord -Value 0
        
        Write-host "Completato"
    })
    
    $516                       = New-Object System.Windows.Forms.Button
    $516.FlatStyle             = 'Flat'
    $516.Text                  = "Revert"
    $516.width                 = 100
    $516.height                = 30
    $516.Location              = New-Object System.Drawing.Point(320, 290)
    $516.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $516.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $516.Add_Click({ 
        Write-Host "Disabling Meltdown (CVE-2017-5754) compatibility flag..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat" -Name "cadca5fe-87d3-4b96-b7fb-a231484277cc" -ErrorAction SilentlyContinue
        
        Write-host "Completato"
    })

    $517                       = New-Object System.Windows.Forms.Button
    $517.FlatStyle             = 'Flat'
    $517.Text                  = "UAC Minimo"
    $517.width                 = 300
    $517.height                = 30
    $517.Location              = New-Object System.Drawing.Point(10, 330)
    $517.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $517.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $517.Add_Click({ 
        Write-Host "Lowering UAC level..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Type DWord -Value 0
        
        Write-host "Completato"
    })
    
    $518                       = New-Object System.Windows.Forms.Button
    $518.FlatStyle             = 'Flat'
    $518.Text                  = "Revert"
    $518.width                 = 100
    $518.height                = 30
    $518.Location              = New-Object System.Drawing.Point(320, 330)
    $518.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $518.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $518.Add_Click({ 
        Write-Host "Raising UAC level..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Type DWord -Value 5
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Type DWord -Value 1
        
        Write-host "Completato"
    })

    $519                       = New-Object System.Windows.Forms.Button
    $519.FlatStyle             = 'Flat'
    $519.Text                  = "Disattiva Condivisione HDD tra Utenti"
    $519.width                 = 300
    $519.height                = 30
    $519.Location              = New-Object System.Drawing.Point(10, 370)
    $519.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $519.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $519.Add_Click({ 
        Write-Host "Disabling sharing mapped drives between users..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -ErrorAction SilentlyContinue

        Write-host "Completato"
    })
    
    $520                       = New-Object System.Windows.Forms.Button
    $520.FlatStyle             = 'Flat'
    $520.Text                  = "Revert"
    $520.width                 = 100
    $520.height                = 30
    $520.Location              = New-Object System.Drawing.Point(320, 370)
    $520.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $520.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $520.Add_Click({ 
        Write-Host "Enabling sharing mapped drives between users..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -Type DWord -Value 1
        
        Write-host "Completato"
    })

    $521                       = New-Object System.Windows.Forms.Button
    $521.FlatStyle             = 'Flat'
    $521.Text                  = "Disattiva Condivisione Amministrative"
    $521.width                 = 300
    $521.height                = 30
    $521.Location              = New-Object System.Drawing.Point(10, 410)
    $521.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $521.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $521.Add_Click({ 
        Write-Host "Disabling implicit administrative shares..."
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "AutoShareWks" -Type DWord -Value 0
              
        Write-host "Completato"
    })
    
    $522                       = New-Object System.Windows.Forms.Button
    $522.FlatStyle             = 'Flat'
    $522.Text                  = "Revert"
    $522.width                 = 100
    $522.height                = 30
    $522.Location              = New-Object System.Drawing.Point(320, 410)
    $522.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $522.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $522.Add_Click({ 
        Write-Host "Enabling implicit administrative shares..."
        Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "AutoShareWks" -ErrorAction SilentlyContinue
        
        
        Write-host "Completato"
    })

    $523                       = New-Object System.Windows.Forms.Button
    $523.FlatStyle             = 'Flat'
    $523.Text                  = "Disattiva SMB Server"
    $523.width                 = 300
    $523.height                = 30
    $523.Location              = New-Object System.Drawing.Point(10, 450)
    $523.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $523.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $523.Add_Click({ 
        Write-Host "Disabling SMB Server..."
        Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
        Set-SmbServerConfiguration -EnableSMB2Protocol $false -Force
        
        Write-host "Completato"
    })
    
    $524                       = New-Object System.Windows.Forms.Button
    $524.FlatStyle             = 'Flat'
    $524.Text                  = "Revert"
    $524.width                 = 100
    $524.height                = 30
    $524.Location              = New-Object System.Drawing.Point(320, 450)
    $524.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $524.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $524.Add_Click({ 
        Write-Host "Enabling SMB Server..."
        Set-SmbServerConfiguration -EnableSMB2Protocol $true -Force
        
        Write-host "Completato"
    })

    $525                       = New-Object System.Windows.Forms.Button
    $525.FlatStyle             = 'Flat'
    $525.Text                  = "Disattiva LLMNR"
    $525.width                 = 300
    $525.height                = 30
    $525.Location              = New-Object System.Drawing.Point(10, 490)
    $525.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $525.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $525.Add_Click({ 
        Write-Host "Disabling LLMNR..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -Type DWord -Value 0
        
        Write-host "Completato"
    })
    
    $526                       = New-Object System.Windows.Forms.Button
    $526.FlatStyle             = 'Flat'
    $526.Text                  = "Revert"
    $526.width                 = 100
    $526.height                = 30
    $526.Location              = New-Object System.Drawing.Point(320, 490)
    $526.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $526.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $526.Add_Click({ 
        Write-Host "Enabling LLMNR..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -ErrorAction SilentlyContinue
                
        Write-host "Completato"
    })

    $527                       = New-Object System.Windows.Forms.Button
    $527.FlatStyle             = 'Flat'
    $527.Text                  = "Imposta Rete Privata"
    $527.width                 = 300
    $527.height                = 30
    $527.Location              = New-Object System.Drawing.Point(10, 530)
    $527.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $527.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $527.Add_Click({ 
        Write-Host "Setting current network profile to private..."
        Set-NetConnectionProfile -NetworkCategory Private
        
        Write-host "Completato"
    })
    
    $528                       = New-Object System.Windows.Forms.Button
    $528.FlatStyle             = 'Flat'
    $528.Text                  = "Pubblica"
    $528.width                 = 100
    $528.height                = 30
    $528.Location              = New-Object System.Drawing.Point(320, 530)
    $528.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $528.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $528.Add_Click({ 
        Write-Host "Setting current network profile to public..."
        Set-NetConnectionProfile -NetworkCategory Public
        
        Write-host "Completato"
    })

    $529                       = New-Object System.Windows.Forms.Button
    $529.FlatStyle             = 'Flat'
    $529.Text                  = "Tutte Reti Private"
    $529.width                 = 300
    $529.height                = 30
    $529.Location              = New-Object System.Drawing.Point(10, 570)
    $529.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $529.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $529.Add_Click({ 
        Write-Host "Setting unknown networks profile to private..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24" -Name "Category" -Type DWord -Value 1
        
        Write-host "Completato"
    })
    
    $530                       = New-Object System.Windows.Forms.Button
    $530.FlatStyle             = 'Flat'
    $530.Text                  = "Pubblica"
    $530.width                 = 100
    $530.height                = 30
    $530.Location              = New-Object System.Drawing.Point(320, 570)
    $530.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $530.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $530.Add_Click({ 
        Write-Host "Setting unknown networks profile to public..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24" -Name "Category" -ErrorAction SilentlyContinue
        
        Write-host "Completato"
    })

    $531                       = New-Object System.Windows.Forms.Button
    $531.FlatStyle             = 'Flat'
    $531.Text                  = "Disattiva Installazione Device di Rete"
    $531.width                 = 300
    $531.height                = 30
    $531.Location              = New-Object System.Drawing.Point(10, 610)
    $531.Font                  = New-Object System.Drawing.Font('Consolas',8)
    $531.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $531.Add_Click({ 
        Write-Host "Disabling automatic installation of network devices..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private" -Name "AutoSetup" -Type DWord -Value 0
        
        Write-host "Completato"
    })
    
    $532                       = New-Object System.Windows.Forms.Button
    $532.FlatStyle             = 'Flat'
    $532.Text                  = "Revert"
    $532.width                 = 100
    $532.height                = 30
    $532.Location              = New-Object System.Drawing.Point(320, 610)
    $532.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $532.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $532.Add_Click({ 
        Write-Host "Enabling automatic installation of network devices..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private" -Name "AutoSetup" -ErrorAction SilentlyContinue
        
        Write-host "Completato"
    })

    $533                       = New-Object System.Windows.Forms.Button
    $533.FlatStyle             = 'Flat'
    $533.Text                  = "Disabilita Firewall"
    $533.width                 = 300
    $533.height                = 30
    $533.Location              = New-Object System.Drawing.Point(10, 650)
    $533.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $533.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $533.Add_Click({ 
        Write-Host "Disabling Firewall..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile" -Name "EnableFirewall" -Type DWord -Value 0
        
        Write-host "Completato"
    })
    
    $534                       = New-Object System.Windows.Forms.Button
    $534.FlatStyle             = 'Flat'
    $534.Text                  = "Revert"
    $534.width                 = 100
    $534.height                = 30
    $534.Location              = New-Object System.Drawing.Point(320, 650)
    $534.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $534.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $534.Add_Click({ 
        Write-Host "Enabling Firewall..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile" -Name "EnableFirewall" -ErrorAction SilentlyContinue
        
        Write-host "Completato"
    })

    $535                       = New-Object System.Windows.Forms.Button
    $535.FlatStyle             = 'Flat'
    $535.Text                  = "Disattiva Defender"
    $535.width                 = 300
    $535.height                = 30
    $535.Location              = New-Object System.Drawing.Point(10, 690)
    $535.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $535.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $535.Add_Click({ 
        Write-Host "Disabling Windows Defender..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Type DWord -Value 1
        If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsDefender" -ErrorAction SilentlyContinue
        } ElseIf ([System.Environment]::OSVersion.Version.Build -ge 15063) {
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -ErrorAction SilentlyContinue
        }
        Write-host "Completato"
    })
    
    $536                       = New-Object System.Windows.Forms.Button
    $536.FlatStyle             = 'Flat'
    $536.Text                  = "Revert"
    $536.width                 = 100
    $536.height                = 30
    $536.Location              = New-Object System.Drawing.Point(320, 690)
    $536.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $536.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $536.Add_Click({ 
        Write-Host "Enabling Windows Defender..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -ErrorAction SilentlyContinue
        If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsDefender" -Type ExpandString -Value "`"%ProgramFiles%\Windows Defender\MSASCuiL.exe`""
        } ElseIf ([System.Environment]::OSVersion.Version.Build -ge 15063) {
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -Type ExpandString -Value "`"%ProgramFiles%\Windows Defender\MSASCuiL.exe`""
        }
        
        Write-host "Completato"
    })

    $537                       = New-Object System.Windows.Forms.Button
    $537.FlatStyle             = 'Flat'
    $537.Text                  = "Disattiva Defender Cloud"
    $537.width                 = 300
    $537.height                = 30
    $537.Location              = New-Object System.Drawing.Point(10, 730)
    $537.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $537.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $537.Add_Click({ 
        Write-Host "Disabling Windows Defender Cloud..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Name "SpynetReporting" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Name "SubmitSamplesConsent" -Type DWord -Value 2
        
        Write-host "Completato"
    })
    
    $538                       = New-Object System.Windows.Forms.Button
    $538.FlatStyle             = 'Flat'
    $538.Text                  = "Revert"
    $538.width                 = 100
    $538.height                = 30
    $538.Location              = New-Object System.Drawing.Point(320, 730)
    $538.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $538.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $538.Add_Click({ 
        Write-Host "Enabling Windows Defender Cloud..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Name "SpynetReporting" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Name "SubmitSamplesConsent" -ErrorAction SilentlyContinue
        
        Write-host "Completato"
    })

    $539                       = New-Object System.Windows.Forms.Button
    $539.FlatStyle             = 'Flat'
    $539.Text                  = "Abilita F8 Menu Boot"
    $539.width                 = 300
    $539.height                = 30
    $539.Location              = New-Object System.Drawing.Point(10, 770)
    $539.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $539.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $539.Add_Click({ 
            Write-Host "Enabling F8 boot menu options..."
            bcdedit /set `{current`} bootmenupolicy Legacy | Out-Null
        Write-host "Completato"
    })
    
    $540                       = New-Object System.Windows.Forms.Button
    $540.FlatStyle             = 'Flat'
    $540.Text                  = "Revert"
    $540.width                 = 100
    $540.height                = 30
    $540.Location              = New-Object System.Drawing.Point(320, 770)
    $540.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $540.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $540.Add_Click({ 
            Write-Host "Disabling F8 boot menu options..."
            bcdedit /set `{current`} bootmenupolicy Standard | Out-Null
        Write-host "Completato"
    })

    $541                       = New-Object System.Windows.Forms.Button
    $541.FlatStyle             = 'Flat'
    $541.Text                  = "Disattiva NetBIOS su TCP/IP"
    $541.width                 = 300
    $541.height                = 30
    $541.Location              = New-Object System.Drawing.Point(10, 810)
    $541.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $541.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $541.Add_Click({ 
        Write-Host "Disabling NetBIOS over TCP/IP..."
        Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces\Tcpip*" -Name "NetbiosOptions" -Type DWord -Value 2
        
        Write-host "Completato"
    })
    
    $542                       = New-Object System.Windows.Forms.Button
    $542.FlatStyle             = 'Flat'
    $542.Text                  = "Revert"
    $542.width                 = 100
    $542.height                = 30
    $542.Location              = New-Object System.Drawing.Point(320, 810)
    $542.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $542.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $542.Add_Click({ 
        Write-Host "Enabling NetBIOS over TCP/IP..."
        Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces\Tcpip*" -Name "NetbiosOptions" -Type DWord -Value 0
        
        Write-host "Completato"
    })

    $543                       = New-Object System.Windows.Forms.Button
    $543.FlatStyle             = 'Flat'
    $543.Text                  = "Disattiva Condivisione Internet"
    $543.width                 = 300
    $543.height                = 30
    $543.Location              = New-Object System.Drawing.Point(10, 850)
    $543.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $543.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $543.Add_Click({ 
        Write-Host "Disabling Internet Connection Sharing..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections" -Name "NC_ShowSharedAccessUI" -Type DWord -Value 0
        
        Write-host "Completato"
    })
    
    $544                       = New-Object System.Windows.Forms.Button
    $544.FlatStyle             = 'Flat'
    $544.Text                  = "Revert"
    $544.width                 = 100
    $544.height                = 30
    $544.Location              = New-Object System.Drawing.Point(320, 850)
    $544.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $544.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $544.Add_Click({ 
        Write-Host "Enabling Internet Connection Sharing..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections" -Name "NC_ShowSharedAccessUI" -ErrorAction SilentlyContinue
        
        Write-host "Completato"
    })

    $545                       = New-Object System.Windows.Forms.Button
    $545.FlatStyle             = 'Flat'
    $545.Text                  = "Nascondi Defender SysTray Icon"
    $545.width                 = 300
    $545.height                = 30
    $545.Location              = New-Object System.Drawing.Point(10, 890)
    $545.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $545.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $545.Add_Click({ 
        Write-Host "Hiding Windows Defender SysTray icon..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" -Name "HideSystray" -Type DWord -Value 1
        If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsDefender" -ErrorAction SilentlyContinue
        } ElseIf ([System.Environment]::OSVersion.Version.Build -ge 15063) {
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -ErrorAction SilentlyContinue
        }
        Write-host "Completato"
    })
    
    $546                       = New-Object System.Windows.Forms.Button
    $546.FlatStyle             = 'Flat'
    $546.Text                  = "Revert"
    $546.width                 = 100
    $546.height                = 30
    $546.Location              = New-Object System.Drawing.Point(320, 890)
    $546.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $546.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $546.Add_Click({ 
        Write-Host "Showing Windows Defender SysTray icon..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" -Name "HideSystray" -ErrorAction SilentlyContinue
        If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsDefender" -Type ExpandString -Value "`"%ProgramFiles%\Windows Defender\MSASCuiL.exe`""
        } ElseIf ([System.Environment]::OSVersion.Version.Build -ge 15063 -And [System.Environment]::OSVersion.Version.Build -le 17134) {
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -Type ExpandString -Value "%ProgramFiles%\Windows Defender\MSASCuiL.exe"
        } ElseIf ([System.Environment]::OSVersion.Version.Build -ge 17763) {
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -Type ExpandString -Value "%windir%\system32\SecurityHealthSystray.exe"
        }
        Write-host "Completato"
    })

    $547                       = New-Object System.Windows.Forms.Button
    $547.FlatStyle             = 'Flat'
    $547.Text                  = "Disattiva Servizi Defender"
    $547.width                 = 300
    $547.height                = 30
    $547.Location              = New-Object System.Drawing.Point(10, 930)
    $547.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $547.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $547.Add_Click({ 
        Write-Host "Disabling Windows Defender Services"
        Takeown-Registry("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend")
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend" "Start" 4
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend" "AutorunsDisabled" 3
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WdNisSvc" "Start" 4
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WdNisSvc" "AutorunsDisabled" 3
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Sense" "Start" 4
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Sense" "AutorunsDisabled" 3
        
        Write-host "Completato"
    })

    $5CustomizeForm.controls.AddRange(@($51,$52,$53,$54,$55,$56,$57,$58,$59,$510,$511,$512,$513,$514,$515,$516,$517,$518,$519,$520,$521,$522,$523,$524,$525,$526,$527,$528,$529,$530,$531,$532,$533,$534,$535,$536,$537,$538,$539,$540,$541,$542,$543,$544,$545,$546,$547))

            Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }
    
    [void]$5CustomizeForm.ShowDialog()

})

####################
### END SECURITY ###
####################

##########################
### TWEAKS APPLICATION ###
##########################

$Button6.Add_Click({
    $6CustomizeForm                  = New-Object System.Windows.Forms.Form
    $6CustomizeForm.ClientSize       = New-Object System.Drawing.Point(430,1170)
    $6CustomizeForm.StartPosition    = 'CenterScreen'
    $6CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $6CustomizeForm.MinimizeBox      = $false
    $6CustomizeForm.MaximizeBox      = $true
    $6CustomizeForm.ShowIcon         = $false
    $6CustomizeForm.Text             = "Tweaks Applicazioni"
    $6CustomizeForm.TopMost          = $false
    $6CustomizeForm.AutoScroll       = $true
    $6CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

    $61                       = New-Object System.Windows.Forms.Button
    $61.FlatStyle             = 'Flat'
    $61.Text                  = "Rimozione Onedrive"
    $61.width                 = 300
    $61.height                = 30
    $61.Location              = New-Object System.Drawing.Point(10, 10)
    $61.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $61.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $61.Add_Click({ 
		Write-Host "Rimozione in Corso"
		If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) {
			New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" | Out-Null
		}
		Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Type DWord -Value 1
		Stop-Process -Name "OneDrive" -ErrorAction SilentlyContinue
		Start-Sleep -s 2
		$onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
		If (!(Test-Path $onedrive)) {
			$onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
		}
		Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
		Start-Sleep -s 2
		Remove-Item -Path "$env:USERPROFILE\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
		Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
		Remove-Item -Path "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
		Remove-Item -Path "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse -ErrorAction SilentlyContinue
		If (!(Test-Path "HKCR:")) {
			New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
		}
		Remove-Item -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
		Remove-Item -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
        Write-host "Completato"
    })
    
    $62                       = New-Object System.Windows.Forms.Button
    $62.FlatStyle             = 'Flat'
    $62.Text                  = "Disinstalla Windows Store"
    $62.width                 = 300
    $62.height                = 30
    $62.Location              = New-Object System.Drawing.Point(10, 50)
    $62.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $62.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $62.Add_Click({ 
            Write-Host "Uninstalling Windows Store..."
            Get-AppxPackage "Microsoft.DesktopAppInstaller" | Remove-AppxPackage
            Get-AppxPackage "Microsoft.WindowsStore" | Remove-AppxPackage
        Write-host "Completato"
    })
    
    $63                       = New-Object System.Windows.Forms.Button
    $63.FlatStyle             = 'Flat'
    $63.Text                  = "Reinstalla"
    $63.width                 = 100
    $63.height                = 30
    $63.Location              = New-Object System.Drawing.Point(320, 50)
    $63.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $63.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $63.Add_Click({ 
            Write-Host "Installing Windows Store..."
            Get-AppxPackage -AllUsers "Microsoft.DesktopAppInstaller" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
            Get-AppxPackage -AllUsers "Microsoft.WindowsStore" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
        Write-host "Completato"
    })

    $64                       = New-Object System.Windows.Forms.Button
    $64.FlatStyle             = 'Flat'
    $64.Text                  = "Disinstalla Xbox Features"
    $64.width                 = 300
    $64.height                = 30
    $64.Location              = New-Object System.Drawing.Point(10, 90)
    $64.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $64.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $64.Add_Click({ 
            Write-Host "Disabling Xbox features..."
            Get-AppxPackage "Microsoft.XboxApp" | Remove-AppxPackage
            Get-AppxPackage "Microsoft.XboxIdentityProvider" | Remove-AppxPackage -ErrorAction SilentlyContinue
            Get-AppxPackage "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxPackage
            Get-AppxPackage "Microsoft.XboxGameOverlay" | Remove-AppxPackage
            Get-AppxPackage "Microsoft.Xbox.TCUI" | Remove-AppxPackage
            Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 0
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -Type DWord -Value 0
        Write-host "Completato"
    })
    
    $65                       = New-Object System.Windows.Forms.Button
    $65.FlatStyle             = 'Flat'
    $65.Text                  = "Reinstalla"
    $65.width                 = 100
    $65.height                = 30
    $65.Location              = New-Object System.Drawing.Point(320, 90)
    $65.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $65.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $65.Add_Click({ 
            Write-Host "Enabling Xbox features..."
            Get-AppxPackage -AllUsers "Microsoft.XboxApp" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
            Get-AppxPackage -AllUsers "Microsoft.XboxIdentityProvider" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
            Get-AppxPackage -AllUsers "Microsoft.XboxSpeechToTextOverlay" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
            Get-AppxPackage -AllUsers "Microsoft.XboxGameOverlay" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
            Get-AppxPackage -AllUsers "Microsoft.Xbox.TCUI" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
            Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 1
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })
    
    $68                       = New-Object System.Windows.Forms.Button
    $68.FlatStyle             = 'Flat'
    $68.Text                  = "Disinstalla Windows Media Player"
    $68.width                 = 300
    $68.height                = 30
    $68.Location              = New-Object System.Drawing.Point(10, 130)
    $68.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $68.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $68.Add_Click({ 
            Write-Host "Uninstalling Windows Media Player..."
            Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -WarningAction SilentlyContinue | Out-Null
        Write-host "Completato"
    })
    
    $69                       = New-Object System.Windows.Forms.Button
    $69.FlatStyle             = 'Flat'
    $69.Text                  = "Reinstalla"
    $69.width                 = 100
    $69.height                = 30
    $69.Location              = New-Object System.Drawing.Point(320, 130)
    $69.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $69.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $69.Add_Click({ 
            Write-Host "Installing Windows Media Player..."
            Enable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -WarningAction SilentlyContinue | Out-Null
        Write-host "Completato"
    })
    
    $610                       = New-Object System.Windows.Forms.Button
    $610.FlatStyle             = 'Flat'
    $610.Text                  = "Disinstalla Internet Explorer"
    $610.width                 = 300
    $610.height                = 30
    $610.Location              = New-Object System.Drawing.Point(10, 170)
    $610.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $610.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $610.Add_Click({ 
        Write-Host "Uninstalling Internet Explorer..."
        Disable-WindowsOptionalFeature -Online -FeatureName "Internet-Explorer-Optional-$env:PROCESSOR_ARCHITECTURE" -NoRestart -WarningAction SilentlyContinue | Out-Null
        Write-host "Completato"
    })
    
    $611                       = New-Object System.Windows.Forms.Button
    $611.FlatStyle             = 'Flat'
    $611.Text                  = "Reinstalla"
    $611.width                 = 100
    $611.height                = 30
    $611.Location              = New-Object System.Drawing.Point(320, 170)
    $611.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $611.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $611.Add_Click({ 
        Write-Host "Installing Internet Explorer..."
        Enable-WindowsOptionalFeature -Online -FeatureName "Internet-Explorer-Optional-$env:PROCESSOR_ARCHITECTURE" -NoRestart -WarningAction SilentlyContinue | Out-Null
        Write-host "Completato"
    })

    $612                       = New-Object System.Windows.Forms.Button
    $612.FlatStyle             = 'Flat'
    $612.Text                  = "Disinstalla Work Folders"
    $612.width                 = 300
    $612.height                = 30
    $612.Location              = New-Object System.Drawing.Point(10, 210)
    $612.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $612.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $612.Add_Click({ 
        Write-Host "Uninstalling Work Folders Client..."
        Disable-WindowsOptionalFeature -Online -FeatureName "WorkFolders-Client" -NoRestart -WarningAction SilentlyContinue | Out-Null
        Write-host "Completato"
    })
    
    $613                       = New-Object System.Windows.Forms.Button
    $613.FlatStyle             = 'Flat'
    $613.Text                  = "Reinstalla"
    $613.width                 = 100
    $613.height                = 30
    $613.Location              = New-Object System.Drawing.Point(320, 210)
    $613.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $613.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $613.Add_Click({ 
        Write-Host "Installing Work Folders Client..."
        Enable-WindowsOptionalFeature -Online -FeatureName "WorkFolders-Client" -NoRestart -WarningAction SilentlyContinue | Out-Null
        Write-host "Completato"
    })
    
    $614                       = New-Object System.Windows.Forms.Button
    $614.FlatStyle             = 'Flat'
    $614.Text                  = "Disinstalla Linux Subsystem"
    $614.width                 = 300
    $614.height                = 30
    $614.Location              = New-Object System.Drawing.Point(10, 250)
    $614.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $614.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $614.Add_Click({ 
            Write-Host "Uninstalling Linux Subsystem..."
            If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Type DWord -Value 0
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowAllTrustedApps" -Type DWord -Value 0
            }
            Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" -NoRestart -WarningAction SilentlyContinue | Out-Null
        Write-host "Completato"
    })
    
    $615                       = New-Object System.Windows.Forms.Button
    $615.FlatStyle             = 'Flat'
    $615.Text                  = "Reinstalla"
    $615.width                 = 100
    $615.height                = 30
    $615.Location              = New-Object System.Drawing.Point(320, 250)
    $615.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $615.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $615.Add_Click({ 
            Write-Host "Installing Linux Subsystem..."
            If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
                # 1607 needs developer mode to be enabled
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Type DWord -Value 1
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowAllTrustedApps" -Type DWord -Value 1
            }
            Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" -NoRestart -WarningAction SilentlyContinue | Out-Null
        Write-host "Completato"
    })

    $616                       = New-Object System.Windows.Forms.Button
    $616.FlatStyle             = 'Flat'
    $616.Text                  = "Disinstalla Hyper-V"
    $616.width                 = 300
    $616.height                = 30
    $616.Location              = New-Object System.Drawing.Point(10, 290)
    $616.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $616.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $616.Add_Click({ 
            Write-Host "Uninstalling Hyper-V..."
            If ((Get-WmiObject -Class "Win32_OperatingSystem").Caption -like "*Server*") {
                Uninstall-WindowsFeature -Name "Hyper-V" -IncludeManagementTools -WarningAction SilentlyContinue | Out-Null
            } Else {
                Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" -NoRestart -WarningAction SilentlyContinue | Out-Null
            }
        Write-host "Completato"
    })
    
    $617                       = New-Object System.Windows.Forms.Button
    $617.FlatStyle             = 'Flat'
    $617.Text                  = "Reinstalla"
    $617.width                 = 100
    $617.height                = 30
    $617.Location              = New-Object System.Drawing.Point(320, 290)
    $617.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $617.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $617.Add_Click({ 
            Write-Host "Installing Hyper-V..."
            If ((Get-WmiObject -Class "Win32_OperatingSystem").Caption -like "*Server*") {
                Install-WindowsFeature -Name "Hyper-V" -IncludeManagementTools -WarningAction SilentlyContinue | Out-Null
            } Else {
                Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" -NoRestart -WarningAction SilentlyContinue | Out-Null
            }
        Write-host "Completato"
    })

    $618                       = New-Object System.Windows.Forms.Button
    $618.FlatStyle             = 'Flat'
    $618.Text                  = "Rimuovi Photo Viewer da Apri Con"
    $618.width                 = 300
    $618.height                = 30
    $618.Location              = New-Object System.Drawing.Point(10, 330)
    $618.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $618.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $618.Add_Click({ 
        Write-Host "Removing Photo Viewer from `"Open with...`""
        If (!(Test-Path "HKCR:")) {
            New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
        }
        Remove-Item -Path "HKCR:\Applications\photoviewer.dll\shell\open" -Recurse -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })
    
    $619                       = New-Object System.Windows.Forms.Button
    $619.FlatStyle             = 'Flat'
    $619.Text                  = "Reabilita"
    $619.width                 = 100
    $619.height                = 30
    $619.Location              = New-Object System.Drawing.Point(320, 330)
    $619.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $619.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $619.Add_Click({ 
        Write-Host "Adding Photo Viewer to `"Open with...`""
        If (!(Test-Path "HKCR:")) {
            New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
        }
        New-Item -Path "HKCR:\Applications\photoviewer.dll\shell\open\command" -Force | Out-Null
        New-Item -Path "HKCR:\Applications\photoviewer.dll\shell\open\DropTarget" -Force | Out-Null
        Set-ItemProperty -Path "HKCR:\Applications\photoviewer.dll\shell\open" -Name "MuiVerb" -Type String -Value "@photoviewer.dll,-3043"
        Set-ItemProperty -Path "HKCR:\Applications\photoviewer.dll\shell\open\command" -Name "(Default)" -Type ExpandString -Value "%SystemRoot%\System32\rundll32.exe `"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll`", ImageView_Fullscreen %1"
        Set-ItemProperty -Path "HKCR:\Applications\photoviewer.dll\shell\open\DropTarget" -Name "Clsid" -Type String -Value "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"
        Write-host "Completato"
    })

    $620                       = New-Object System.Windows.Forms.Button
    $620.FlatStyle             = 'Flat'
    $620.Text                  = "Disinstalla Microsoft Print to PDF"
    $620.width                 = 300
    $620.height                = 30
    $620.Location              = New-Object System.Drawing.Point(10, 370)
    $620.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $620.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $620.Add_Click({ 
        Write-Host "Uninstalling Microsoft Print to PDF..."
        Disable-WindowsOptionalFeature -Online -FeatureName "Printing-PrintToPDFServices-Features" -NoRestart -WarningAction SilentlyContinue | Out-Null
        Write-host "Completato"
    })
    
    $621                       = New-Object System.Windows.Forms.Button
    $621.FlatStyle             = 'Flat'
    $621.Text                  = "Reinstalla"
    $621.width                 = 100
    $621.height                = 30
    $621.Location              = New-Object System.Drawing.Point(320, 370)
    $621.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $621.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $621.Add_Click({ 
        Write-Host "Installing Microsoft Print to PDF..."
        Enable-WindowsOptionalFeature -Online -FeatureName "Printing-PrintToPDFServices-Features" -NoRestart -WarningAction SilentlyContinue | Out-Null
        Write-host "Completato"
    })

    $622                       = New-Object System.Windows.Forms.Button
    $622.FlatStyle             = 'Flat'
    $622.Text                  = "Disinstalla Microsoft XPS Document Writer"
    $622.width                 = 300
    $622.height                = 30
    $622.Location              = New-Object System.Drawing.Point(10, 410)
    $622.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $622.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $622.Add_Click({ 
        Write-Host "Uninstalling Microsoft XPS Document Writer..."
        Disable-WindowsOptionalFeature -Online -FeatureName "Printing-XPSServices-Features" -NoRestart -WarningAction SilentlyContinue | Out-Null
        Write-host "Completato"
    })
    
    $623                       = New-Object System.Windows.Forms.Button
    $623.FlatStyle             = 'Flat'
    $623.Text                  = "Reinstalla"
    $623.width                 = 100
    $623.height                = 30
    $623.Location              = New-Object System.Drawing.Point(320, 410)
    $623.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $623.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $623.Add_Click({ 
        Write-Host "Installing Microsoft XPS Document Writer..."
        Enable-WindowsOptionalFeature -Online -FeatureName "Printing-XPSServices-Features" -NoRestart -WarningAction SilentlyContinue | Out-Null
        Write-host "Completato"
    })

    $624                       = New-Object System.Windows.Forms.Button
    $624.FlatStyle             = 'Flat'
    $624.Text                  = "Disinstalla Default Fax Printer"
    $624.width                 = 300
    $624.height                = 30
    $624.Location              = New-Object System.Drawing.Point(10, 450)
    $624.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $624.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $624.Add_Click({ 
        Write-Host "Removing Default Fax Printer..."
        Remove-Printer -Name "Fax" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })
    
    $625                       = New-Object System.Windows.Forms.Button
    $625.FlatStyle             = 'Flat'
    $625.Text                  = "Reinstalla"
    $625.width                 = 100
    $625.height                = 30
    $625.Location              = New-Object System.Drawing.Point(320, 450)
    $625.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $625.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $625.Add_Click({ 
        Write-Host "Adding Default Fax Printer..."
        Add-Printer -Name "Fax" -DriverName "Microsoft Shared Fax Driver" -PortName "SHRFAX:" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $626                       = New-Object System.Windows.Forms.Button
    $626.FlatStyle             = 'Flat'
    $626.Text                  = "Disabilita Developer Mode"
    $626.width                 = 300
    $626.height                = 30
    $626.Location              = New-Object System.Drawing.Point(10, 490)
    $626.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $626.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $626.Add_Click({ 
        Write-Host "Disabling Developer Mode..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowAllTrustedApps" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })
    
    $627                       = New-Object System.Windows.Forms.Button
    $627.FlatStyle             = 'Flat'
    $627.Text                  = "Reabilita"
    $627.width                 = 100
    $627.height                = 30
    $627.Location              = New-Object System.Drawing.Point(320, 490)
    $627.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $627.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $627.Add_Click({ 
        Write-Host "Enabling Developer Mode..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowAllTrustedApps" -Type DWord -Value 1
        Write-host "Completato"
    })

    $628                       = New-Object System.Windows.Forms.Button
    $628.FlatStyle             = 'Flat'
    $628.Text                  = "Disinstalla Math Recognizer"
    $628.width                 = 300
    $628.height                = 30
    $628.Location              = New-Object System.Drawing.Point(10, 530)
    $628.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $628.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $628.Add_Click({ 
        Write-Host "Uninstalling Math Recognizer..."
        Get-WindowsCapability -Online | Where-Object { $_.Name -like "MathRecognizer*" } | Remove-WindowsCapability -Online | Out-Null
        Write-host "Completato"
    })
    
    $629                       = New-Object System.Windows.Forms.Button
    $629.FlatStyle             = 'Flat'
    $629.Text                  = "Reinstalla"
    $629.width                 = 100
    $629.height                = 30
    $629.Location              = New-Object System.Drawing.Point(320, 530)
    $629.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $629.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $629.Add_Click({ 
        Write-Host "Installing Math Recognizer..."
        Get-WindowsCapability -Online | Where-Object { $_.Name -like "MathRecognizer*" } | Add-WindowsCapability -Online | Out-Null
        Write-host "Completato"
    })

    $630                       = New-Object System.Windows.Forms.Button
    $630.FlatStyle             = 'Flat'
    $630.Text                  = "Disattiva Telemetria Logitech"
    $630.width                 = 300
    $630.height                = 30
    $630.Location              = New-Object System.Drawing.Point(10, 570)
    $630.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $630.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $630.Add_Click({ 
        #Disable Logitech Gaming service
        Stop-Service "LogiRegistryService"
        Set-Service "LogiRegistryService" -StartupType Disabled
        Write-host "Completato"
    })

    $631                       = New-Object System.Windows.Forms.Button
    $631.FlatStyle             = 'Flat'
    $631.Text                  = "Disattiva Telemetria VS Code"
    $631.width                 = 300
    $631.height                = 30
    $631.Location              = New-Object System.Drawing.Point(10, 610)
    $631.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $631.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $631.Add_Click({ 
        #Disable Visual Studio Telemetry
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\VSCommon\14.0\SQM" -Name "OptIn" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\VSCommon\15.0\SQM" -Name "OptIn" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\VSCommon\16.0\SQM" -Name "OptIn" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\VSCommon\14.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\VSCommon\15.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\VSCommon\16.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\VSCommon\14.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\VSCommon\15.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\VSCommon\16.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\VisualStudio\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\VisualStudio\Telemetry" -Name TurnOffSwitch -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\VisualStudio\Feedback" -Name "DisableFeedbackDialog" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\VisualStudio\Feedback" -Name "DisableEmailInput" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\VisualStudio\Feedback" -Name "DisableScreenshotCapture" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\VisualStudio\Telemetry" -Name "TurnOffSwitch" -Type "DWORD" -Value 1 -Force
        Stop-Service "VSStandardCollectorService150"
        Set-Service "VSStandardCollectorService150" -StartupType Disabled
        Write-host "Completato"
    })

    $632                       = New-Object System.Windows.Forms.Button
    $632.FlatStyle             = 'Flat'
    $632.Text                  = "Disabilita Google Chrome Telemetria"
    $632.width                 = 300
    $632.height                = 30
    $632.Location              = New-Object System.Drawing.Point(10, 650)
    $632.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $632.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $632.Add_Click({ 
       #Block Google Chrome Software Reporter Tool
       New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "ChromeCleanupEnabled" -Type "String" -Value 0 -Force
       New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "ChromeCleanupReportingEnabled" -Type "String" -Value 0 -Force
       New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "MetricsReportingEnabled" -Type "String" -Value 0 -Force
       Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "DisallowRun" -Type "DWORD" -Value 1 -Force
       Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" -Name "1" -Type "String" -Value "software_reporter_tool.exe" /f
       Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\software_reporter_tool.exe" -Name Debugger -Type "String" -Value "%windir%\System32\taskkill.exe" -Force
       Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "ChromeCleanupEnabled" -Type "String" -Value 0 -Force
       Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "ChromeCleanupReportingEnabled" -Type "String" -Value 0 -Force
       Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "MetricsReportingEnabled" -Type "String" -Value 0 -Force
    
        Write-host "Completato"
    })

    $633                       = New-Object System.Windows.Forms.Button
    $633.FlatStyle             = 'Flat'
    $633.Text                  = "Disattiva CClenaer Setting"
    $633.width                 = 300
    $633.height                = 30
    $633.Location              = New-Object System.Drawing.Point(10, 690)
    $633.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $633.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $633.Add_Click({ 
       #Disable CCleaner Health Check
       Stop-Process -Force -Force -Name  ccleaner.exe
       Stop-Process -Force -Force -Name  ccleaner64.exe
       Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "HomeScreen" -Type "String" -Value 2 -Force
    
       #Disable CCleaner Monitoring && more
       Stop-Process -Force -Force -Name "IMAGENAME eq CCleaner*"
       schtasks /Change /TN "CCleaner Update" /Disable
       Get-ScheduledTask -TaskName "CCleaner Update" | Disable-ScheduledTask
       Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "Monitoring" -Type "DWORD" -Value 0 -Force
       Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "HelpImproveCCleaner" -Type "DWORD" -Value 0 -Force
       Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "SystemMonitoring" -Type "DWORD" -Value 0 -Force
       Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "UpdateAuto" -Type "DWORD" -Value 0 -Force
       Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "UpdateCheck" -Type "DWORD" -Value 0 -Force
       Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "CheckTrialOffer" -Type "DWORD" -Value 0 -Force
       Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)HealthCheck" -Type "DWORD" -Value 0 -Force
       Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)QuickClean" -Type "DWORD" -Value 0 -Force
       Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)QuickCleanIpm" -Type "DWORD" -Value 0 -Force
       Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)GetIpmForTrial" -Type "DWORD" -Value 0 -Force
       Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)SoftwareUpdater" -Type "DWORD" -Value 0 -Force
       Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)SoftwareUpdaterIpm" -Type "DWORD" -Value 0 -Force
    
        Write-host "Completato"
    })

    $634                       = New-Object System.Windows.Forms.Button
    $634.FlatStyle             = 'Flat'
    $634.Text                  = "Disattiva Office Telemetria"
    $634.width                 = 300
    $634.height                = 30
    $634.Location              = New-Object System.Drawing.Point(10, 730)
    $634.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $634.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $634.Add_Click({ 
        #Disable Office Telemetry
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Name "DisableTelemetry" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Name "DisableTelemetry" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Name "VerboseLogging" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Name "VerboseLogging" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" -Name "EnableCalendarLogging" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" -Name "EnableCalendarLogging" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Word\Options" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Word\Options" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Word\Options" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Word\Options" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Name "EnableUpload" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Name "EnableLogging" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Name "EnableUpload" -Type "DWORD" -Value 0 -Force
        #Disable Office Telemetry Agent
        schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /DISABLE
        schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack2016" /DISABLE
        schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /DISABLE
        schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn2016" /DISABLE
        #Disable Office Subscription Heartbeat
        schtasks /change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /DISABLE
        schtasks /change /TN "Microsoft\Office\Office 16 Subscription Heartbeat" /DISABLE
        #Disable Office feedback
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" -Name "Enabled" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" -Name "Enabled" -Type "DWORD" -Value 0 -Force
        #Disable Office Customer Experience Improvement Program
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common" -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common" -Name "QMEnable" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" -Name "QMEnable" -Type "DWORD" -Value 0 -Force
    
        Write-host "Completato"
    })

    $635                       = New-Object System.Windows.Forms.Button
    $635.FlatStyle             = 'Flat'
    $635.Text                  = "Disattiva Adobe Reader DC Telemetria"
    $635.width                 = 300
    $635.height                = 30
    $635.Location              = New-Object System.Drawing.Point(10, 770)
    $635.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $635.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $635.Add_Click({ 
        #Disable storing sensitive data in Acrobat Reader DC
        Set-ItemProperty -Path "HKCU:\Software\Adobe\Adobe ARM\1.0\ARM" -Name "iCheck" -Type "String" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown" -Name "cSharePoint" -Type "String" -Value 1 -Force
        Set-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Acrobat Reader\DC\FeatureLockdown\cServices" -Name "bToggleAdobeDocumentServices" -Type "String" -Value 1 -Force
        Set-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Acrobat Reader\DC\FeatureLockdown\cServices" -Name "bToggleAdobeSign" -Type "String" -Value 1 -Force
        Set-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Acrobat Reader\DC\FeatureLockdown\cServices" -Name "bTogglePrefSync" -Type "String" -Value 1 -Force
        Set-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Acrobat Reader\DC\FeatureLockdown\cServices" -Name "bToggleWebConnectors" -Type "String" -Value 1 -Force
        Set-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Acrobat Reader\DC\FeatureLockdown\cServices" -Name "bAdobeSendPluginToggle" -Type "String" -Value 1 -Force
        Set-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Acrobat Reader\DC\FeatureLockdown\cServices" -Name "bUpdater" -Type "String" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\Software\Adobe\Adobe ARM\1.0\ARM" -Name "iCheck" -Type "String" -Value 0 -Force
    
        #Disable Adobe Acrobat Update Service
        Set-Service "Adobe Acrobat Update Task" -StartupType Disabled
        Set-Service "Adobe Flash Player Updater" -StartupType Disabled
        Set-Service "adobeflashplayerupdatesvc" -StartupType Disabled
        Set-Service "adobeupdateservice" -StartupType Disabled
        Set-Service "AdobeARMservice" -StartupType Disabled
        Write-host "Completato"
    })

    $636                       = New-Object System.Windows.Forms.Button
    $636.FlatStyle             = 'Flat'
    $636.Text                  = "Disattiva Firefox Telemetria"
    $636.width                 = 300
    $636.height                = 30
    $636.Location              = New-Object System.Drawing.Point(10, 810)
    $636.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $636.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $636.Add_Click({ 
        #Disable Mozilla Firefox Telemetry
        Set-ItemProperty -Path "HKLM:\Software\Policies\Mozilla\Firefox" -Name "DisableTelemetry" -Type "DWORD" -Value 1 -Force
        #Disable default browser agent reporting policy
        Set-ItemProperty -Path "HKLM:\Software\Policies\Mozilla\Firefox" -Name "DisableDefaultBrowserAgent" -Type "DWORD" -Value 1 -Force
        #Disable default browser agent reporting services
        schtasks.exe /change /disable /tn "\Mozilla\Firefox Default Browser Agent 308046B0AF4A39CB"
        schtasks.exe /change /disable /tn "\Mozilla\Firefox Default Browser Agent D2CEEC440E2074BD"
        Write-host "Completato"
    })

    $637                       = New-Object System.Windows.Forms.Button
    $637.FlatStyle             = 'Flat'
    $637.Text                  = "Disattiva Dropbox Telemetria"
    $637.width                 = 300
    $637.height                = 30
    $637.Location              = New-Object System.Drawing.Point(10, 850)
    $637.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $637.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $637.Add_Click({ 
        #Disable Dropbox Update service
        Set-Service dbupdate -StartupType Disabled
        Set-Service dbupdatem -StartupType Disabled
        Get-ScheduledTask -TaskName "DropboxUpdateTaskMachineCore" | Disable-ScheduledTask
        Get-ScheduledTask -TaskName "DropboxUpdateTaskMachineUA" | Disable-ScheduledTask
        #schtasks /Change /TN "DropboxUpdateTaskMachineCore" /Disable
        #schtasks /Change /TN "DropboxUpdateTaskMachineUA" /Disable
        Write-host "Completato"
    })

    $638                       = New-Object System.Windows.Forms.Button
    $638.FlatStyle             = 'Flat'
    $638.Text                  = "Disattiva Media Player Telemetria"
    $638.width                 = 300
    $638.height                = 30
    $638.Location              = New-Object System.Drawing.Point(10, 890)
    $638.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $638.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $638.Add_Click({ 
        #Disable Media Player Telemetry
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\MediaPlayer\Preferences" -Name "UsageTracking" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\WindowsMediaPlayer" -Name "PreventCDDVDMetadataRetrieval" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\WindowsMediaPlayer" -Name "PreventMusicFileMetadataRetrieval" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\WindowsMediaPlayer" -Name "PreventRadioPresetsRetrieval" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\WMDRM" -Name "DisableOnline" -Type "DWORD" -Value 1 -Force
        Set-Service WMPNetworkSvc -StartupType Disabled
        Write-host "Completato"
    })

    $639                       = New-Object System.Windows.Forms.Button
    $639.FlatStyle             = 'Flat'
    $639.Text                  = "Disattiva Google Update Service"
    $639.width                 = 300
    $639.height                = 30
    $639.Location              = New-Object System.Drawing.Point(10, 930)
    $639.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $639.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $639.Add_Click({ 
        #Disable Google update service
        Get-ScheduledTask -TaskName "GoogleUpdateTaskMachineCore" | Disable-ScheduledTask
        Get-ScheduledTask -TaskName "GoogleUpdateTaskMachineUA" | Disable-ScheduledTask
        #schtasks /Change /TN "GoogleUpdateTaskMachineCore" /Disable
        #schtasks /Change /TN "GoogleUpdateTaskMachineUA" /Disable
        Write-host "Completato"
    })

    $640                       = New-Object System.Windows.Forms.Button
    $640.FlatStyle             = 'Flat'
    $640.Text                  = "Disattiva Sincronia Impostazioni"
    $640.width                 = 300
    $640.height                = 30
    $640.Location              = New-Object System.Drawing.Point(10, 970)
    $640.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $640.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $640.Add_Click({ 
        Write-Host "Disable synchronisation of settings"
        # These only apply if you log on using Microsoft account
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "BackupPolicy" 0x3c
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "DeviceMetadataUploaded" 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "PriorLogons" 1
        $groups = @(
            "Accessibility"
            "AppSync"
            "BrowserSettings"
            "Credentials"
            "DesktopTheme"
            "Language"
            "PackageState"
            "Personalization"
            "StartLayout"
            "Windows"
        )
        foreach ($group in $groups) {
            New-FolderForced -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\$group"
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\$group" "Enabled" 0
        }        
        
        Write-host "Completato"
    })
    
    $641                       = New-Object System.Windows.Forms.Button
    $641.FlatStyle             = 'Flat'
    $641.Text                  = "Disattiva Old Volume Icon"
    $641.width                 = 300
    $641.height                = 30
    $641.Location              = New-Object System.Drawing.Point(10, 1010)
    $641.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $641.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $641.Add_Click({ 
        Write-Host "Disattivando Vecchia Icona Volume"
        New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer -Value “”
        New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAVolume" -Type DWord -Value 1
        Write-host "Completato"
    })

    $642                       = New-Object System.Windows.Forms.Button
    $642.FlatStyle             = 'Flat'
    $642.Text                  = "Disattiva Windows Live ID Service"
    $642.width                 = 300
    $642.height                = 30
    $642.Location              = New-Object System.Drawing.Point(10, 1050)
    $642.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $642.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $642.Add_Click({ 
        #Disable Microsoft Windows Live ID service
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\wlidsvc" -Name Start -Type "DWORD" -Value 4 -Force
        Set-Service wlidsvc -StartupType Disabled
        Write-host "Completato"
    })

    $643                       = New-Object System.Windows.Forms.Button
    $643.FlatStyle             = 'Flat'
    $643.Text                  = "Custom Accent"
    $643.width                 = 300
    $643.height                = 30
    $643.Location              = New-Object System.Drawing.Point(10, 1090)
    $643.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $643.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $643.Add_Click({ 
        Write-Host "Custom Accent..."
        New-Item -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Accents -Value “”
        New-Item -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Accents\0 -Value “”
        New-Item -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Accents\0\Theme0 -Value “”
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Accents\0\Theme0" -Name "Color" -Type dword -Value 4280228376
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "AccentColor" -Type DWord -Value 4280228376
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "AccentColorInactive" -Type DWord -Value 4280228376    
        
        
        Write-host "Completato"
    })

    $644                       = New-Object System.Windows.Forms.Button
    $644.FlatStyle             = 'Flat'
    $644.Text                  = "Opzioni Grafiche: Prestazioni Migliori"
    $644.width                 = 300
    $644.height                = 30
    $644.Location              = New-Object System.Drawing.Point(10, 1130)
    $644.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $644.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $644.Add_Click({ 
        Write-Host "Impostando Opzioni Grafiche per Prestazioni Migliori..."
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](144,18,3,128,16,0,0,0))
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 0
        Write-host "Completato"
    })
    
    $645                       = New-Object System.Windows.Forms.Button
    $645.FlatStyle             = 'Flat'
    $645.Text                  = "Aspetto"
    $645.width                 = 100
    $645.height                = 30
    $645.Location              = New-Object System.Drawing.Point(320, 1130)
    $645.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $645.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $645.Add_Click({ 
        Write-Host "Impostando Opzioni Grafiche per Aspetto Migliore..."
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 1
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 400
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](158,30,7,128,18,0,0,0))
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 1
        Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 1
        Write-host "Completato"
    })

    $6CustomizeForm.controls.AddRange(@($61,$62,$63,$64,$65,$66,$67,$68,$69,$610,$611,$612,$613,$614,$615,$616,$617,$618,$619,$620,$621,$622,$623,$624,$625,$626,$627,$628,$629,$630,$631,$632,$633,$634,$635,$636,$637,$638,$639,$640,$641,$642,$643,$644,$645))

            Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }
    
    [void]$6CustomizeForm.ShowDialog()

})

##############################
### END TWEAKS APPLICATION ###
##############################

#######################
### TWEAKS EXPLORER ###
#######################

$Button7.Add_Click({
    $7CustomizeForm                  = New-Object System.Windows.Forms.Form
    $7CustomizeForm.ClientSize       = New-Object System.Drawing.Point(860,930)
    $7CustomizeForm.StartPosition    = 'CenterScreen'
    $7CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $7CustomizeForm.MinimizeBox      = $false
    $7CustomizeForm.MaximizeBox      = $true
    $7CustomizeForm.ShowIcon         = $false
    $7CustomizeForm.Text             = "Tweaks Explorer"
    $7CustomizeForm.TopMost          = $false
    $7CustomizeForm.AutoScroll       = $true
    $7CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

	$71                       = New-Object System.Windows.Forms.Button
	$71.FlatStyle             = 'Flat'
	$71.Text                  = "Mostra Percorso Completo Barra Titolo"
	$71.width                 = 300
	$71.height                = 30
	$71.Location              = New-Object System.Drawing.Point(10, 10)
	$71.Font                  = New-Object System.Drawing.Font('Consolas',9)
	$71.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
	
	$71.Add_Click({ 
			Write-Host "Showing full directory path in Explorer title bar..."
			If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState")) {
				New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Force | Out-Null
			}
			Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Type DWord -Value 1
		Write-host "Completato"
	})
	
	$72                       = New-Object System.Windows.Forms.Button
	$72.FlatStyle             = 'Flat'
	$72.Text                  = "Revert"
	$72.width                 = 100
	$72.height                = 30
	$72.Location              = New-Object System.Drawing.Point(320, 10)
	$72.Font                  = New-Object System.Drawing.Font('Consolas',9)
	$72.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
	 
	$72.Add_Click({ 
			Write-Host "Hiding full directory path in Explorer title bar..."
			Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -ErrorAction SilentlyContinue
		Write-host "Completato"
	})

    $73                       = New-Object System.Windows.Forms.Button
    $73.FlatStyle             = 'Flat'
    $73.Text                  = "Mostra Estensioni File"
    $73.width                 = 300
    $73.height                = 30
    $73.Location              = New-Object System.Drawing.Point(10, 50)
    $73.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $73.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $73.Add_Click({ 
            Write-Host "Showing known file extensions..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0       
        Write-host "Completato"
    })
    
    $74                       = New-Object System.Windows.Forms.Button
    $74.FlatStyle             = 'Flat'
    $74.Text                  = "Revert"
    $74.width                 = 100
    $74.height                = 30
    $74.Location              = New-Object System.Drawing.Point(320, 50)
    $74.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $74.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $74.Add_Click({ 
            Write-Host "Hiding known file extensions..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 1
        Write-host "Completato"
    })

    $75                       = New-Object System.Windows.Forms.Button
    $75.FlatStyle             = 'Flat'
    $75.Text                  = "Mostra File Nascosti"
    $75.width                 = 300
    $75.height                = 30
    $75.Location              = New-Object System.Drawing.Point(10, 90)
    $75.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $75.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $75.Add_Click({ 
            Write-Host "Showing hidden files..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Type DWord -Value 1
        Write-host "Completato"
    })
    
    $76                       = New-Object System.Windows.Forms.Button
    $76.FlatStyle             = 'Flat'
    $76.Text                  = "Revert"
    $76.width                 = 100
    $76.height                = 30
    $76.Location              = New-Object System.Drawing.Point(320, 90)
    $76.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $76.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $76.Add_Click({ 
            Write-Host "Hiding hidden files..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Type DWord -Value 2
        Write-host "Completato"
    })

    $77                       = New-Object System.Windows.Forms.Button
    $77.FlatStyle             = 'Flat'
    $77.Text                  = "Mostra File Nascosti di Sistema"
    $77.width                 = 300
    $77.height                = 30
    $77.Location              = New-Object System.Drawing.Point(10, 130)
    $77.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $77.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $77.Add_Click({ 
            Write-Host "Showing protected operating system files..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Type DWord -Value 1
        Write-host "Completato"
    })
    
    $78                       = New-Object System.Windows.Forms.Button
    $78.FlatStyle             = 'Flat'
    $78.Text                  = "Revert"
    $78.width                 = 100
    $78.height                = 30
    $78.Location              = New-Object System.Drawing.Point(320, 130)
    $78.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $78.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $78.Add_Click({ 
            Write-Host "Hiding protected operating system files..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Type DWord -Value 0
        Write-host "Completato"
    })

    $79                       = New-Object System.Windows.Forms.Button
    $79.FlatStyle             = 'Flat'
    $79.Text                  = "Nascondi Cartelle Vuote"
    $79.width                 = 300
    $79.height                = 30
    $79.Location              = New-Object System.Drawing.Point(10, 170)
    $79.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $79.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $79.Add_Click({ 
            Write-Host "Showing empty drives (with no media)..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideDrivesWithNoMedia" -Type DWord -Value 0
        Write-host "Completato"
    })
    
    $710                       = New-Object System.Windows.Forms.Button
    $710.FlatStyle             = 'Flat'
    $710.Text                  = "Revert"
    $710.width                 = 100
    $710.height                = 30
    $710.Location              = New-Object System.Drawing.Point(320, 170)
    $710.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $710.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $710.Add_Click({ 
            Write-Host "Hiding empty drives (with no media)..."
            Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideDrivesWithNoMedia" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $711                       = New-Object System.Windows.Forms.Button
    $711.FlatStyle             = 'Flat'
    $711.Text                  = "Mostra Conflitti di Unione Cartelle"
    $711.width                 = 300
    $711.height                = 30
    $711.Location              = New-Object System.Drawing.Point(10, 210)
    $711.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $711.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $711.Add_Click({ 
            Write-Host "Showing folder merge conflicts..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideMergeConflicts" -Type DWord -Value 0
        Write-host "Completato"
    })
    
    $712                       = New-Object System.Windows.Forms.Button
    $712.FlatStyle             = 'Flat'
    $712.Text                  = "Revert"
    $712.width                 = 100
    $712.height                = 30
    $712.Location              = New-Object System.Drawing.Point(320, 210)
    $712.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $712.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $712.Add_Click({ 
            Write-Host "Hiding folder merge conflicts..."
            Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideMergeConflicts" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })
    
    $713                       = New-Object System.Windows.Forms.Button
    $713.FlatStyle             = 'Flat'
    $713.Text                  = "Espansione Pannello Laterale"
    $713.width                 = 300
    $713.height                = 30
    $713.Location              = New-Object System.Drawing.Point(10, 250)
    $713.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $713.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $713.Add_Click({ 
            Write-Host "Enabling navigation pane expanding to current folder..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneExpandToCurrentFolder" -Type DWord -Value 1
        Write-host "Completato"
    })
    
    $714                       = New-Object System.Windows.Forms.Button
    $714.FlatStyle             = 'Flat'
    $714.Text                  = "Revert"
    $714.width                 = 100
    $714.height                = 30
    $714.Location              = New-Object System.Drawing.Point(320, 250)
    $714.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $714.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $714.Add_Click({ 
            Write-Host "Disabling navigation pane expanding to current folder..."
            Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneExpandToCurrentFolder" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $715                       = New-Object System.Windows.Forms.Button
    $715.FlatStyle             = 'Flat'
    $715.Text                  = "Mostra tutti nel Pannello Laterale"
    $715.width                 = 300
    $715.height                = 30
    $715.Location              = New-Object System.Drawing.Point(10, 290)
    $715.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $715.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $715.Add_Click({ 
            Write-Host "Showing all folders in Explorer navigation pane..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneShowAllFolders" -Type DWord -Value 1
        Write-host "Completato"
    })
    
    $716                       = New-Object System.Windows.Forms.Button
    $716.FlatStyle             = 'Flat'
    $716.Text                  = "Revert"
    $716.width                 = 100
    $716.height                = 30
    $716.Location              = New-Object System.Drawing.Point(320, 290)
    $716.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $716.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $716.Add_Click({ 
            Write-Host "Hiding all folders in Explorer navigation pane (except the basic ones)..."
            Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneShowAllFolders" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $717                       = New-Object System.Windows.Forms.Button
    $717.FlatStyle             = 'Flat'
    $717.Text                  = "Mostra Libreria nel Pannello Laterale"
    $717.width                 = 300
    $717.height                = 30
    $717.Location              = New-Object System.Drawing.Point(10, 330)
    $717.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $717.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $717.Add_Click({ 
        Write-Host "Showing Libraries icon in Explorer namespace..."
        If (!(Test-Path "HKCU:\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}")) {
            New-Item -Path "HKCU:\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" -Name "System.IsPinnedToNameSpaceTree" -Type DWord -Value 1
        Write-host "Completato"
    })
    
    $718                       = New-Object System.Windows.Forms.Button
    $718.FlatStyle             = 'Flat'
    $718.Text                  = "Revert"
    $718.width                 = 100
    $718.height                = 30
    $718.Location              = New-Object System.Drawing.Point(320, 330)
    $718.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $718.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $718.Add_Click({ 
        Write-Host "Hiding Libraries icon from Explorer namespace..."
        Remove-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" -Name "System.IsPinnedToNameSpaceTree" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $719                       = New-Object System.Windows.Forms.Button
    $719.FlatStyle             = 'Flat'
    $719.Text                  = "Abilita Apri in un'altra Scheda"
    $719.width                 = 300
    $719.height                = 30
    $719.Location              = New-Object System.Drawing.Point(10, 370)
    $719.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $719.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $719.Add_Click({ 
            Write-Host "Enabling launching folder windows in a separate process..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SeparateProcess" -Type DWord -Value 1
        Write-host "Completato"
    })
    
    $720                       = New-Object System.Windows.Forms.Button
    $720.FlatStyle             = 'Flat'
    $720.Text                  = "Revert"
    $720.width                 = 100
    $720.height                = 30
    $720.Location              = New-Object System.Drawing.Point(320, 370)
    $720.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $720.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $720.Add_Click({ 
            Write-Host "Disabling launching folder windows in a separate process..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SeparateProcess" -Type DWord -Value 0
        Write-host "Completato"
    })

    $721                       = New-Object System.Windows.Forms.Button
    $721.FlatStyle             = 'Flat'
    $721.Text                  = "Abilita Riapri Cartella al Riavvio"
    $721.width                 = 300
    $721.height                = 30
    $721.Location              = New-Object System.Drawing.Point(10, 410)
    $721.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $721.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $721.Add_Click({ 
            Write-Host "Enabling restoring previous folder windows at logon..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "PersistBrowsers" -Type DWord -Value 1
        
        Write-host "Completato"
    })
    
    $722                       = New-Object System.Windows.Forms.Button
    $722.FlatStyle             = 'Flat'
    $722.Text                  = "Revert"
    $722.width                 = 100
    $722.height                = 30
    $722.Location              = New-Object System.Drawing.Point(320, 410)
    $722.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $722.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $722.Add_Click({ 
            Write-Host "Disabling restoring previous folder windows at logon..."
            Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "PersistBrowsers" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $723                       = New-Object System.Windows.Forms.Button
    $723.FlatStyle             = 'Flat'
    $723.Text                  = "Mostra Colori per Criptate e Compresse"
    $723.width                 = 300
    $723.height                = 30
    $723.Location              = New-Object System.Drawing.Point(10, 450)
    $723.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $723.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $723.Add_Click({ 
            Write-Host "Showing coloring of encrypted or compressed NTFS files..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowEncryptCompressedColor" -Type DWord -Value 1
        Write-host "Completato"
    })
    
    $724                       = New-Object System.Windows.Forms.Button
    $724.FlatStyle             = 'Flat'
    $724.Text                  = "Revert"
    $724.width                 = 100
    $724.height                = 30
    $724.Location              = New-Object System.Drawing.Point(320, 450)
    $724.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $724.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $724.Add_Click({ 
            Write-Host "Hiding coloring of encrypted or compressed NTFS files..."
            Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowEncryptCompressedColor" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })
    
    $725                       = New-Object System.Windows.Forms.Button
    $725.FlatStyle             = 'Flat'
    $725.Text                  = "Disabilita Sharing Wizard"
    $725.width                 = 300
    $725.height                = 30
    $725.Location              = New-Object System.Drawing.Point(10, 490)
    $725.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $725.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $725.Add_Click({ 
            Write-Host "Disabling Sharing Wizard..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SharingWizardOn" -Type DWord -Value 0
        Write-host "Completato"
    })
    
    $726                       = New-Object System.Windows.Forms.Button
    $726.FlatStyle             = 'Flat'
    $726.Text                  = "Revert"
    $726.width                 = 100
    $726.height                = 30
    $726.Location              = New-Object System.Drawing.Point(320, 490)
    $726.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $726.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $726.Add_Click({ 
            Write-Host "Enabling Sharing Wizard..."
            Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SharingWizardOn" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $727                       = New-Object System.Windows.Forms.Button
    $727.FlatStyle             = 'Flat'
    $727.Text                  = "Nascondi Checkbox Item"
    $727.width                 = 300
    $727.height                = 30
    $727.Location              = New-Object System.Drawing.Point(10, 530)
    $727.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $727.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $727.Add_Click({ 
            Write-Host "Hiding item selection checkboxes..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect" -Type DWord -Value 0
        Write-host "Completato"
    })
    
    $728                       = New-Object System.Windows.Forms.Button
    $728.FlatStyle             = 'Flat'
    $728.Text                  = "Revert"
    $728.width                 = 100
    $728.height                = 30
    $728.Location              = New-Object System.Drawing.Point(320, 530)
    $728.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $728.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $728.Add_Click({ 
            Write-Host "Showing item selection checkboxes..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect" -Type DWord -Value 1
        Write-host "Completato"
    })

    $729                       = New-Object System.Windows.Forms.Button
    $729.FlatStyle             = 'Flat'
    $729.Text                  = "Nascondi Notifica di Sincronizzazione"
    $729.width                 = 300
    $729.height                = 30
    $729.Location              = New-Object System.Drawing.Point(10, 570)
    $729.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $729.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $729.Add_Click({ 
        Write-Host "Hiding sync provider notifications..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Type DWord -Value 0
        Write-host "Completato"
    })
    
    $730                       = New-Object System.Windows.Forms.Button
    $730.FlatStyle             = 'Flat'
    $730.Text                  = "Revert"
    $730.width                 = 100
    $730.height                = 30
    $730.Location              = New-Object System.Drawing.Point(320, 570)
    $730.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $730.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $730.Add_Click({ 
        Write-Host "Showing sync provider notifications..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Type DWord -Value 1
        Write-host "Completato"
    })

    $731                       = New-Object System.Windows.Forms.Button
    $731.FlatStyle             = 'Flat'
    $731.Text                  = "Nascondi Recenti in Explorer"
    $731.width                 = 300
    $731.height                = 30
    $731.Location              = New-Object System.Drawing.Point(10, 610)
    $731.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $731.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $731.Add_Click({ 
        Write-Host "Hiding recent shortcuts in Explorer..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Type DWord -Value 0
    
        Write-host "Completato"
    })
    
    $732                       = New-Object System.Windows.Forms.Button
    $732.FlatStyle             = 'Flat'
    $732.Text                  = "Revert"
    $732.width                 = 100
    $732.height                = 30
    $732.Location              = New-Object System.Drawing.Point(320, 610)
    $732.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $732.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $732.Add_Click({ 
        Write-Host "Showing recent shortcuts in Explorer..."
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })
    
    $733                       = New-Object System.Windows.Forms.Button
    $733.FlatStyle             = 'Flat'
    $733.Text                  = "Questo PC Predefinito Explorer"
    $733.width                 = 300
    $733.height                = 30
    $733.Location              = New-Object System.Drawing.Point(10, 650)
    $733.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $733.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $733.Add_Click({ 
        Write-Host "Changing default Explorer view to This PC..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1
        Write-host "Completato"
    })
    
    $734                       = New-Object System.Windows.Forms.Button
    $734.FlatStyle             = 'Flat'
    $734.Text                  = "Revert"
    $734.width                 = 100
    $734.height                = 30
    $734.Location              = New-Object System.Drawing.Point(320, 650)
    $734.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $734.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $734.Add_Click({ 
        Write-Host "Changing default Explorer view to Quick Access..."
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $735                       = New-Object System.Windows.Forms.Button
    $735.FlatStyle             = 'Flat'
    $735.Text                  = "Nascondi Accesso Rapido da Pannello laterale"
    $735.width                 = 300
    $735.height                = 30
    $735.Location              = New-Object System.Drawing.Point(10, 690)
    $735.Font                  = New-Object System.Drawing.Font('Consolas',8)
    $735.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $735.Add_Click({ 
        Write-Host "Hiding Quick Access from Explorer navigation pane..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "HubMode" -Type DWord -Value 1
        Write-host "Completato"
    })
    
    $736                       = New-Object System.Windows.Forms.Button
    $736.FlatStyle             = 'Flat'
    $736.Text                  = "Revert"
    $736.width                 = 100
    $736.height                = 30
    $736.Location              = New-Object System.Drawing.Point(320, 690)
    $736.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $736.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $736.Add_Click({ 
        Write-Host "Showing Quick Access in Explorer navigation pane..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "HubMode" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $737                       = New-Object System.Windows.Forms.Button
    $737.FlatStyle             = 'Flat'
    $737.Text                  = "Nascondi Cestino da Desktop"
    $737.width                 = 300
    $737.height                = 30
    $737.Location              = New-Object System.Drawing.Point(10, 730)
    $737.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $737.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $737.Add_Click({ 
        Write-Host "Hiding Recycle Bin shortcut from desktop..."
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Type DWord -Value 1
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Type DWord -Value 1
        Write-host "Completato"
    })
    
    $738                       = New-Object System.Windows.Forms.Button
    $738.FlatStyle             = 'Flat'
    $738.Text                  = "Revert"
    $738.width                 = 100
    $738.height                = 30
    $738.Location              = New-Object System.Drawing.Point(320, 730)
    $738.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $738.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $738.Add_Click({ 
        Write-Host "Showing Recycle Bin shortcut on desktop..."
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $739                       = New-Object System.Windows.Forms.Button
    $739.FlatStyle             = 'Flat'
    $739.Text                  = "Mostra Questo Pc su Desktop"
    $739.width                 = 300
    $739.height                = 30
    $739.Location              = New-Object System.Drawing.Point(10, 770)
    $739.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $739.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $739.Add_Click({ 
        Write-Host "Showing This PC shortcut on desktop..."
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Type DWord -Value 0
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Type DWord -Value 0
        Write-host "Completato"
    })
    
    $740                       = New-Object System.Windows.Forms.Button
    $740.FlatStyle             = 'Flat'
    $740.Text                  = "Revert"
    $740.width                 = 100
    $740.height                = 30
    $740.Location              = New-Object System.Drawing.Point(320, 770)
    $740.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $740.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $740.Add_Click({ 
        Write-Host "Hiding This PC shortcut from desktop..."
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $741                       = New-Object System.Windows.Forms.Button
    $741.FlatStyle             = 'Flat'
    $741.Text                  = "Mostra Cartella Utente su Desktop"
    $741.width                 = 300
    $741.height                = 30
    $741.Location              = New-Object System.Drawing.Point(10, 810)
    $741.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $741.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $741.Add_Click({ 
        Write-Host "Showing User Folder shortcut on desktop..."
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Type DWord -Value 0
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Type DWord -Value 0
        Write-host "Completato"
    })
    
    $742                       = New-Object System.Windows.Forms.Button
    $742.FlatStyle             = 'Flat'
    $742.Text                  = "Revert"
    $742.width                 = 100
    $742.height                = 30
    $742.Location              = New-Object System.Drawing.Point(320, 810)
    $742.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $742.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $742.Add_Click({ 
        Write-Host "Hiding User Folder shortcut from desktop..."
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })

    $743                       = New-Object System.Windows.Forms.Button
    $743.FlatStyle             = 'Flat'
    $743.Text                  = "Mostra Pannello di Controllo su Desktop"
    $743.width                 = 300
    $743.height                = 30
    $743.Location              = New-Object System.Drawing.Point(10, 850)
    $743.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $743.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $743.Add_Click({ 
        Write-Host "Showing Control panel shortcut on desktop..."
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -Type DWord -Value 0
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -Type DWord -Value 0
        Write-host "Completato"
    })
    
    $744                       = New-Object System.Windows.Forms.Button
    $744.FlatStyle             = 'Flat'
    $744.Text                  = "Revert"
    $744.width                 = 100
    $744.height                = 30
    $744.Location              = New-Object System.Drawing.Point(320, 850)
    $744.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $744.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $744.Add_Click({ 
        Write-Host "Hiding Control panel shortcut from desktop..."
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })
    
    $745                       = New-Object System.Windows.Forms.Button
    $745.FlatStyle             = 'Flat'
    $745.Text                  = "Mostra Reti su Desktop"
    $745.width                 = 300
    $745.height                = 30
    $745.Location              = New-Object System.Drawing.Point(10, 890)
    $745.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $745.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $745.Add_Click({ 
        Write-Host "Showing Network shortcut on desktop..."
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" )) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu"  -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Type DWord -Value 0
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" )) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Type DWord -Value 0
        Write-host "Completato"
    })
    
    $746                       = New-Object System.Windows.Forms.Button
    $746.FlatStyle             = 'Flat'
    $746.Text                  = "Revert"
    $746.width                 = 100
    $746.height                = 30
    $746.Location              = New-Object System.Drawing.Point(320, 890)
    $746.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $746.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $746.Add_Click({ 
        Write-Host "Hiding Network shortcut from desktop..."
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -ErrorAction SilentlyContinue
        Write-host "Completato"
    })
    
    $747                       = New-Object System.Windows.Forms.Button
    $747.FlatStyle             = 'Flat'
    $747.Text                  = "Nascondi Tutte le icone da Desktop"
    $747.width                 = 300
    $747.height                = 30
    $747.Location              = New-Object System.Drawing.Point(440, 10)
    $747.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $747.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $747.Add_Click({ 
        Write-Host "Hiding all icons from desktop..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideIcons" -Value 1
        Write-host "Completato"
    })
    
    $748                       = New-Object System.Windows.Forms.Button
    $748.FlatStyle             = 'Flat'
    $748.Text                  = "Revert"
    $748.width                 = 100
    $748.height                = 30
    $748.Location              = New-Object System.Drawing.Point(750, 10)
    $748.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $748.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $748.Add_Click({ 
        Write-Host "Showing all icons on desktop..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideIcons" -Value 0
        Write-host "Completato"
    })

    $749                       = New-Object System.Windows.Forms.Button
    $749.FlatStyle             = 'Flat'
    $749.Text                  = "Mostra Build Number e Versione"
    $749.width                 = 300
    $749.height                = 30
    $749.Location              = New-Object System.Drawing.Point(440, 50)
    $749.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $749.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $749.Add_Click({ 
        Write-Host "Showing Windows build number on desktop..."
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "PaintDesktopVersion" -Type DWord -Value 1
        Write-host "Completato"
    })
    
    $750                       = New-Object System.Windows.Forms.Button
    $750.FlatStyle             = 'Flat'
    $750.Text                  = "Revert"
    $750.width                 = 100
    $750.height                = 30
    $750.Location              = New-Object System.Drawing.Point(750, 50)
    $750.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $750.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $750.Add_Click({ 
        Write-Host "Hiding Windows build number from desktop..."
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "PaintDesktopVersion" -Type DWord -Value 0    
        Write-host "Completato"
    })
    
    $751                       = New-Object System.Windows.Forms.Button
    $751.FlatStyle             = 'Flat'
    $751.Text                  = "Nascondi Desktop da Questo PC"
    $751.width                 = 300
    $751.height                = 30
    $751.Location              = New-Object System.Drawing.Point(440, 90)
    $751.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $751.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $751.Add_Click({ 
        Write-Host "Hiding Desktop icon from This PC..."
        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" -Recurse -ErrorAction SilentlyContinue
        Write-host "Completato"
    })
    
    $752                       = New-Object System.Windows.Forms.Button
    $752.FlatStyle             = 'Flat'
    $752.Text                  = "Revert"
    $752.width                 = 100
    $752.height                = 30
    $752.Location              = New-Object System.Drawing.Point(750, 90)
    $752.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $752.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $752.Add_Click({ 
        Write-Host "Showing Desktop icon in This PC..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" | Out-Null
        }
        Write-host "Completato"
    })

    $753                       = New-Object System.Windows.Forms.Button
    $753.FlatStyle             = 'Flat'
    $753.Text                  = "Nascondi Desktop da Pannello Laterale"
    $753.width                 = 300
    $753.height                = 30
    $753.Location              = New-Object System.Drawing.Point(440, 130)
    $753.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $753.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $753.Add_Click({ 
        Write-Host "Hiding Desktop icon from Explorer namespace..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    
        Write-host "Completato"
    })
    
    $754                       = New-Object System.Windows.Forms.Button
    $754.FlatStyle             = 'Flat'
    $754.Text                  = "Revert"
    $754.width                 = 100
    $754.height                = 30
    $754.Location              = New-Object System.Drawing.Point(750, 130)
    $754.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $754.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $754.Add_Click({ 
        Write-Host "Showing Desktop icon in Explorer namespace..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
        Write-host "Completato"
    })

    $755                       = New-Object System.Windows.Forms.Button
    $755.FlatStyle             = 'Flat'
    $755.Text                  = "Nascondi Documenti da Questo PC"
    $755.width                 = 300
    $755.height                = 30
    $755.Location              = New-Object System.Drawing.Point(440, 170)
    $755.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $755.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $755.Add_Click({ 
        Write-Host "Hiding Documents icon from This PC..."
        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" -Recurse -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })
    
    $756                       = New-Object System.Windows.Forms.Button
    $756.FlatStyle             = 'Flat'
    $756.Text                  = "Revert"
    $756.width                 = 100
    $756.height                = 30
    $756.Location              = New-Object System.Drawing.Point(750, 170)
    $756.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $756.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $756.Add_Click({ 
        Write-Host "Showing Documents icon in This PC..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" | Out-Null
        }
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" | Out-Null
        }
        Write-host "Completato"
    })
    
    $757                       = New-Object System.Windows.Forms.Button
    $757.FlatStyle             = 'Flat'
    $757.Text                  = "Nascondi Documenti da Pannello Laterale"
    $757.width                 = 300
    $757.height                = 30
    $757.Location              = New-Object System.Drawing.Point(440, 210)
    $757.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $757.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $757.Add_Click({ 
        Write-Host "Hiding Documents icon from Explorer namespace..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    
        Write-host "Completato"
    })
    
    $758                       = New-Object System.Windows.Forms.Button
    $758.FlatStyle             = 'Flat'
    $758.Text                  = "Revert"
    $758.width                 = 100
    $758.height                = 30
    $758.Location              = New-Object System.Drawing.Point(750, 210)
    $758.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $758.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $758.Add_Click({ 
        Write-Host "Showing Documents icon in Explorer namespace..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    
        Write-host "Completato"
    })

    $759                       = New-Object System.Windows.Forms.Button
    $759.FlatStyle             = 'Flat'
    $759.Text                  = "Nascondi Downloads da Questo PC"
    $759.width                 = 300
    $759.height                = 30
    $759.Location              = New-Object System.Drawing.Point(440, 250)
    $759.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $759.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $759.Add_Click({ 
        Write-Host "Hiding Downloads icon from This PC..."
        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" -Recurse -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })
    
    $760                       = New-Object System.Windows.Forms.Button
    $760.FlatStyle             = 'Flat'
    $760.Text                  = "Revert"
    $760.width                 = 100
    $760.height                = 30
    $760.Location              = New-Object System.Drawing.Point(750, 250)
    $760.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $760.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $760.Add_Click({ 
        Write-Host "Showing Downloads icon in This PC..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" | Out-Null
        }
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" | Out-Null
        }
        Write-host "Completato"
    })

    $761                       = New-Object System.Windows.Forms.Button
    $761.FlatStyle             = 'Flat'
    $761.Text                  = "Nascondi Downloads da Pannello Laterale"
    $761.width                 = 300
    $761.height                = 30
    $761.Location              = New-Object System.Drawing.Point(440, 290)
    $761.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $761.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $761.Add_Click({ 
        Write-Host "Hiding Downloads icon from Explorer namespace..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    
        Write-host "Completato"
    })
    
    $762                       = New-Object System.Windows.Forms.Button
    $762.FlatStyle             = 'Flat'
    $762.Text                  = "Revert"
    $762.width                 = 100
    $762.height                = 30
    $762.Location              = New-Object System.Drawing.Point(750, 290)
    $762.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $762.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $762.Add_Click({ 
        Write-Host "Showing Downloads icon in Explorer namespace..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    
        Write-host "Completato"
    })

    $763                       = New-Object System.Windows.Forms.Button
    $763.FlatStyle             = 'Flat'
    $763.Text                  = "Nascondi Musica da Questo PC"
    $763.width                 = 300
    $763.height                = 30
    $763.Location              = New-Object System.Drawing.Point(440, 330)
    $763.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $763.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $763.Add_Click({ 
        Write-Host "Hiding Music icon from This PC..."
        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" -Recurse -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })
    
    $764                       = New-Object System.Windows.Forms.Button
    $764.FlatStyle             = 'Flat'
    $764.Text                  = "Revert"
    $764.width                 = 100
    $764.height                = 30
    $764.Location              = New-Object System.Drawing.Point(750, 330)
    $764.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $764.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $764.Add_Click({ 
        Write-Host "Showing Music icon in This PC..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" | Out-Null
        }
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" | Out-Null
        }
        Write-host "Completato"
    })

    $765                       = New-Object System.Windows.Forms.Button
    $765.FlatStyle             = 'Flat'
    $765.Text                  = "Nascondi Musica da Pannello Laterale"
    $765.width                 = 300
    $765.height                = 30
    $765.Location              = New-Object System.Drawing.Point(440, 370)
    $765.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $765.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $765.Add_Click({ 
        Write-Host "Hiding Music icon from Explorer namespace..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    
        Write-host "Completato"
    })
    
    $766                       = New-Object System.Windows.Forms.Button
    $766.FlatStyle             = 'Flat'
    $766.Text                  = "Revert"
    $766.width                 = 100
    $766.height                = 30
    $766.Location              = New-Object System.Drawing.Point(750, 370)
    $766.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $766.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $766.Add_Click({ 
        Write-Host "Showing Music icon in Explorer namespace..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    
        Write-host "Completato"
    })

    $767                       = New-Object System.Windows.Forms.Button
    $767.FlatStyle             = 'Flat'
    $767.Text                  = "Nascondi Immagini da Questo PC"
    $767.width                 = 300
    $767.height                = 30
    $767.Location              = New-Object System.Drawing.Point(440, 410)
    $767.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $767.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $767.Add_Click({ 
        Write-Host "Hiding Pictures icon from This PC..."
        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" -Recurse -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })
    
    $768                       = New-Object System.Windows.Forms.Button
    $768.FlatStyle             = 'Flat'
    $768.Text                  = "Revert"
    $768.width                 = 100
    $768.height                = 30
    $768.Location              = New-Object System.Drawing.Point(750, 410)
    $768.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $768.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $768.Add_Click({ 
        Write-Host "Showing Pictures icon in This PC..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" | Out-Null
        }
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" | Out-Null
        }
        Write-host "Completato"
    })

    $769                       = New-Object System.Windows.Forms.Button
    $769.FlatStyle             = 'Flat'
    $769.Text                  = "Nascondi Immagini da Pannello laterale"
    $769.width                 = 300
    $769.height                = 30
    $769.Location              = New-Object System.Drawing.Point(440, 450)
    $769.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $769.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $769.Add_Click({ 
        Write-Host "Hiding Pictures icon from Explorer namespace..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
        Write-host "Completato"
    })
    
    $770                       = New-Object System.Windows.Forms.Button
    $770.FlatStyle             = 'Flat'
    $770.Text                  = "Revert"
    $770.width                 = 100
    $770.height                = 30
    $770.Location              = New-Object System.Drawing.Point(750, 450)
    $770.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $770.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $770.Add_Click({ 
        Write-Host "Showing Pictures icon in Explorer namespace..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
        Write-host "Completato"
    })

    $771                       = New-Object System.Windows.Forms.Button
    $771.FlatStyle             = 'Flat'
    $771.Text                  = "Nascondi Video da Questo PC"
    $771.width                 = 300
    $771.height                = 30
    $771.Location              = New-Object System.Drawing.Point(440, 490)
    $771.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $771.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $771.Add_Click({ 
        Write-Host "Hiding Videos icon from This PC..."
        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" -Recurse -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })
    
    $772                       = New-Object System.Windows.Forms.Button
    $772.FlatStyle             = 'Flat'
    $772.Text                  = "Revert"
    $772.width                 = 100
    $772.height                = 30
    $772.Location              = New-Object System.Drawing.Point(750, 490)
    $772.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $772.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $772.Add_Click({ 
        Write-Host "Showing Videos icon in This PC..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" | Out-Null
        }
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" | Out-Null
        }
        Write-host "Completato"
    })
    
    $773                       = New-Object System.Windows.Forms.Button
    $773.FlatStyle             = 'Flat'
    $773.Text                  = "Nascondi Video da Pannello Laterale"
    $773.width                 = 300
    $773.height                = 30
    $773.Location              = New-Object System.Drawing.Point(440, 530)
    $773.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $773.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $773.Add_Click({ 
        Write-Host "Hiding Videos icon from Explorer namespace..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    
        Write-host "Completato"
    })
    
    $774                       = New-Object System.Windows.Forms.Button
    $774.FlatStyle             = 'Flat'
    $774.Text                  = "Revert"
    $774.width                 = 100
    $774.height                = 30
    $774.Location              = New-Object System.Drawing.Point(750, 530)
    $774.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $774.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $774.Add_Click({ 
        Write-Host "Showing Videos icon in Explorer namespace..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    
        Write-host "Completato"
    })

    $775                       = New-Object System.Windows.Forms.Button
    $775.FlatStyle             = 'Flat'
    $775.Text                  = "Nascondi Oggetti 3D da Questo PC"
    $775.width                 = 300
    $775.height                = 30
    $775.Location              = New-Object System.Drawing.Point(440, 570)
    $775.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $775.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $775.Add_Click({ 
        Write-Host "Hiding 3D Objects icon from This PC..."
        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })
    
    $776                       = New-Object System.Windows.Forms.Button
    $776.FlatStyle             = 'Flat'
    $776.Text                  = "Revert"
    $776.width                 = 100
    $776.height                = 30
    $776.Location              = New-Object System.Drawing.Point(750, 570)
    $776.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $776.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $776.Add_Click({ 
        Write-Host "Showing 3D Objects icon in This PC..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" | Out-Null
        }
        Write-host "Completato"
    })

    $777                       = New-Object System.Windows.Forms.Button
    $777.FlatStyle             = 'Flat'
    $777.Text                  = "Nascondi Oggetti 3D da Pannello Laterale"
    $777.width                 = 300
    $777.height                = 30
    $777.Location              = New-Object System.Drawing.Point(440, 610)
    $777.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $777.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $777.Add_Click({ 
        Write-Host "Hiding 3D Objects icon from Explorer namespace..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
        If (!(Test-Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag")) {
            New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    
        Write-host "Completato"
    })
    
    $778                       = New-Object System.Windows.Forms.Button
    $778.FlatStyle             = 'Flat'
    $778.Text                  = "Revert"
    $778.width                 = 100
    $778.height                = 30
    $778.Location              = New-Object System.Drawing.Point(750, 610)
    $778.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $778.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $778.Add_Click({ 
        Write-Host "Showing 3D Objects icon in Explorer namespace..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Name "ThisPCPolicy" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Name "ThisPCPolicy" -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })

    $779                       = New-Object System.Windows.Forms.Button
    $779.FlatStyle             = 'Flat'
    $779.Text                  = "Nascondi Reti da Pannello Laterale"
    $779.width                 = 300
    $779.height                = 30
    $779.Location              = New-Object System.Drawing.Point(440, 650)
    $779.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $779.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $779.Add_Click({ 
        Write-Host "Hiding Network icon from Explorer namespace..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\NonEnum" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Type DWord -Value 1
    
        Write-host "Completato"
    })
    
    $780                       = New-Object System.Windows.Forms.Button
    $780.FlatStyle             = 'Flat'
    $780.Text                  = "Revert"
    $780.width                 = 100
    $780.height                = 30
    $780.Location              = New-Object System.Drawing.Point(750, 650)
    $780.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $780.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $780.Add_Click({ 
        Write-Host "Showing Network icon in Explorer namespace..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\NonEnum" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })
    
    $781                       = New-Object System.Windows.Forms.Button
    $781.FlatStyle             = 'Flat'
    $781.Text                  = "Nascondi 'Includi in Libreria' da Context Menu"
    $781.width                 = 300
    $781.height                = 30
    $781.Location              = New-Object System.Drawing.Point(440, 690)
    $781.Font                  = New-Object System.Drawing.Font('Consolas',8)
    $781.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $781.Add_Click({ 
        Write-Host "Hiding 'Include in library' context menu item..."
        If (!(Test-Path "HKCR:")) {
            New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
        }
        Remove-Item -Path "HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location" -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })
    
    $782                       = New-Object System.Windows.Forms.Button
    $782.FlatStyle             = 'Flat'
    $782.Text                  = "Revert"
    $782.width                 = 100
    $782.height                = 30
    $782.Location              = New-Object System.Drawing.Point(750, 690)
    $782.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $782.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $782.Add_Click({ 
        Write-Host "Showing 'Include in library' context menu item..."
        If (!(Test-Path "HKCR:")) {
            New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
        }
        New-Item -Path "HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location" -ErrorAction SilentlyContinue | Out-Null
        Set-ItemProperty -Path "HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location" -Name "(Default)" -Type String -Value "{3dad6c5d-2167-4cae-9914-f99e41c12cfa}"
    
        Write-host "Completato"
    })

    $783                       = New-Object System.Windows.Forms.Button
    $783.FlatStyle             = 'Flat'
    $783.Text                  = "Nascondi 'Dai Accesso a' da Context Menu"
    $783.width                 = 300
    $783.height                = 30
    $783.Location              = New-Object System.Drawing.Point(440, 730)
    $783.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $783.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $783.Add_Click({ 
        Write-Host "Hiding 'Give access to' context menu item..."
        If (!(Test-Path "HKCR:")) {
            New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
        }
        Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
        Remove-Item -Path "HKCR:\Directory\Background\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
        Remove-Item -Path "HKCR:\Directory\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
        Remove-Item -Path "HKCR:\Drive\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })
    
    $784                       = New-Object System.Windows.Forms.Button
    $784.FlatStyle             = 'Flat'
    $784.Text                  = "Revert"
    $784.width                 = 100
    $784.height                = 30
    $784.Location              = New-Object System.Drawing.Point(750, 730)
    $784.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $784.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $784.Add_Click({ 
        Write-Host "Showing 'Give access to' context menu item..."
        If (!(Test-Path "HKCR:")) {
            New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
        }
        New-Item -Path "HKCR:\*\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue | Out-Null
        Set-ItemProperty -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\Sharing" -Name "(Default)" -Type String -Value "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"
        New-Item -Path "HKCR:\Directory\Background\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shellex\ContextMenuHandlers\Sharing" -Name "(Default)" -Type String -Value "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"
        New-Item -Path "HKCR:\Directory\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\shellex\ContextMenuHandlers\Sharing" -Name "(Default)" -Type String -Value "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"
        New-Item -Path "HKCR:\Drive\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue | Out-Null
        Set-ItemProperty -Path "HKCR:\Drive\shellex\ContextMenuHandlers\Sharing" -Name "(Default)" -Type String -Value "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"
    
        Write-host "Completato"
    })

    $785                       = New-Object System.Windows.Forms.Button
    $785.FlatStyle             = 'Flat'
    $785.Text                  = "Nascondi 'Condividi' da Context Menu"
    $785.width                 = 300
    $785.height                = 30
    $785.Location              = New-Object System.Drawing.Point(440, 770)
    $785.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $785.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $785.Add_Click({ 
        Write-Host "Hiding 'Share' context menu item..."
        If (!(Test-Path "HKCR:")) {
            New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
        }
        Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\ModernSharing" -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })
    
    $786                       = New-Object System.Windows.Forms.Button
    $786.FlatStyle             = 'Flat'
    $786.Text                  = "Revert"
    $786.width                 = 100
    $786.height                = 30
    $786.Location              = New-Object System.Drawing.Point(750, 770)
    $786.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $786.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $786.Add_Click({ 
        Write-Host "Showing 'Share' context menu item..."
        If (!(Test-Path "HKCR:")) {
            New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
        }
        New-Item -Path "HKCR:\*\shellex\ContextMenuHandlers\ModernSharing" -ErrorAction SilentlyContinue | Out-Null
        Set-ItemProperty -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\ModernSharing" -Name "(Default)" -Type String -Value "{e2bf9676-5f8f-435c-97eb-11607a5bedf7}"
    
        Write-host "Completato"
    })

    $787                       = New-Object System.Windows.Forms.Button
    $787.FlatStyle             = 'Flat'
    $787.Text                  = "Disattiva Thumbnails"
    $787.width                 = 300
    $787.height                = 30
    $787.Location              = New-Object System.Drawing.Point(440, 810)
    $787.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $787.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $787.Add_Click({ 
        Write-Host "Disabling thumbnails..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "IconsOnly" -Type DWord -Value 1
    
        Write-host "Completato"
    })
    
    $788                       = New-Object System.Windows.Forms.Button
    $788.FlatStyle             = 'Flat'
    $788.Text                  = "Revert"
    $788.width                 = 100
    $788.height                = 30
    $788.Location              = New-Object System.Drawing.Point(750, 810)
    $788.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $788.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $788.Add_Click({ 
        Write-Host "Enabling thumbnails..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "IconsOnly" -Type DWord -Value 0
    
        Write-host "Completato"
    })

    $789                       = New-Object System.Windows.Forms.Button
    $789.FlatStyle             = 'Flat'
    $789.Text                  = "Disattiva Creazione Cache Thumbnail"
    $789.width                 = 300
    $789.height                = 30
    $789.Location              = New-Object System.Drawing.Point(440, 850)
    $789.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $789.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $789.Add_Click({ 
        Write-Host "Disabling creation of thumbnail cache files..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisableThumbnailCache" -Type DWord -Value 1
    
        Write-host "Completato"
    })
    
    $790                       = New-Object System.Windows.Forms.Button
    $790.FlatStyle             = 'Flat'
    $790.Text                  = "Revert"
    $790.width                 = 100
    $790.height                = 30
    $790.Location              = New-Object System.Drawing.Point(750, 850)
    $790.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $790.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $790.Add_Click({ 
        Write-Host "Enabling creation of thumbnail cache files..."
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisableThumbnailCache" -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })

    $791                       = New-Object System.Windows.Forms.Button
    $791.FlatStyle             = 'Flat'
    $791.Text                  = "Disattiva Creazione di Thumbs.db in Reti"
    $791.width                 = 300
    $791.height                = 30
    $791.Location              = New-Object System.Drawing.Point(440, 890)
    $791.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $791.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $791.Add_Click({ 
        Write-Host "Disabling creation of Thumbs.db on network folders..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisableThumbsDBOnNetworkFolders" -Type DWord -Value 1
    
        Write-host "Completato"
    })
    
    $792                       = New-Object System.Windows.Forms.Button
    $792.FlatStyle             = 'Flat'
    $792.Text                  = "Revert"
    $792.width                 = 100
    $792.height                = 30
    $792.Location              = New-Object System.Drawing.Point(750, 890)
    $792.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $792.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $792.Add_Click({ 
        Write-Host "Enabling creation of Thumbs.db on network folders..."
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisableThumbsDBOnNetworkFolders" -ErrorAction SilentlyContinue
    
        Write-host "Completato"
    })

    $7CustomizeForm.controls.AddRange(@($71,$72,$73,$74,$75,$76,$77,$78,$79,$710,$711,$712,$713,$714,$715,$716,$717,$718,$719,$720,$721,$722,$723,$724,$725,$726,$727,$728,$729,$730,$731,$732,$733,$734,$735,$736,$737,$738,$739,$740,$741,$742,$743,$744,$745,$746,$747,$748,$749,$750,$751,$752,$753,$754,$755,$756,$757,$758,$759,$760,$761,$762,$763,$764,$765,$766,$767,$768,$769,$770,$771,$772,$773,$774,$775,$776,$777,$778,$779,$780,$781,$782,$783,$784,$785,$786,$787,$788,$789,$790,$791,$792))

            Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }
    
    [void]$7CustomizeForm.ShowDialog()

})

###########################
### END TWEAKS EXPLORER ###
###########################

#################
### REPAIR PC ###
#################

$Button8.Add_Click({
    $8CustomizeForm                  = New-Object System.Windows.Forms.Form
    $8CustomizeForm.ClientSize       = New-Object System.Drawing.Point(320,370)
    $8CustomizeForm.StartPosition    = 'CenterScreen'
    $8CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $8CustomizeForm.MinimizeBox      = $false
    $8CustomizeForm.MaximizeBox      = $true
    $8CustomizeForm.ShowIcon         = $false
    $8CustomizeForm.Text             = "Repair PC"
    $8CustomizeForm.TopMost          = $false
    $8CustomizeForm.AutoScroll       = $true
    $8CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

    $81                       = New-Object System.Windows.Forms.Button
    $81.FlatStyle             = 'Flat'
    $81.Text                  = "Verifica Licenza Windows"
    $81.width                 = 300
    $81.height                = 30
    $81.Location              = New-Object System.Drawing.Point(10, 10)
    $81.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $81.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $81.Add_Click({
        Start-Process -FilePath "C:\Windows\System32\cmd.exe" -verb runas -ArgumentList {/k slmgr /dli}

        Write-host "Completato"
    })
    
    $82                       = New-Object System.Windows.Forms.Button
    $82.FlatStyle             = 'Flat'
    $82.Text                  = "Verifica Licenza Office"
    $82.width                 = 300
    $82.height                = 30
    $82.Location              = New-Object System.Drawing.Point(10, 50)
    $82.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $82.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $82.Add_Click({ 
        Start-Process -FilePath "C:\Windows\System32\cmd.exe" -verb runas -ArgumentList {/k cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /dstatus}
        Write-host "Completato"
    })

    $83                       = New-Object System.Windows.Forms.Button
    $83.FlatStyle             = 'Flat'
    $83.Text                  = "Battery Report"
    $83.width                 = 300
    $83.height                = 30
    $83.Location              = New-Object System.Drawing.Point(10, 90)
    $83.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $83.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $83.Add_Click({ 
        powercfg /batteryreport /output "C:\battery-report.html"
        Write-host "Troverai il tuo Battery-Report in C:\"
    })
    
    $84                       = New-Object System.Windows.Forms.Button
    $84.FlatStyle             = 'Flat'
    $84.Text                  = "Esporta Driver"
    $84.width                 = 300
    $84.height                = 30
    $84.Location              = New-Object System.Drawing.Point(10, 130)
    $84.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $84.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $84.Add_Click({ 
        New-Item -Path 'C:\Drivers' -ItemType Directory
        DISM.exe /Online /Export-Driver /Destination:C:\Drivers
        Write-host "Troverai i Tuoi Driver nella cartella C:\Drivers"
    })

    $85                       = New-Object System.Windows.Forms.Button
    $85.FlatStyle             = 'Flat'
    $85.Text                  = "Reset Connessione"
    $85.width                 = 300
    $85.height                = 30
    $85.Location              = New-Object System.Drawing.Point(10, 170)
    $85.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $85.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $85.Add_Click({ 
        netsh winsock reset
        netsh int ip reset
        ipconfig /release
        ipconfig /renew
        ipconfig /flushdns
        ipconfig /release6
        ipconfig /renew6 *Ethernet*
        ipconfig /renew *Ethernet*
        netsh advfirewall reset
        Write-host "Completato"
    })
    
    $86                       = New-Object System.Windows.Forms.Button
    $86.FlatStyle             = 'Flat'
    $86.Text                  = "Reset Windows Store"
    $86.width                 = 300
    $86.height                = 30
    $86.Location              = New-Object System.Drawing.Point(10, 210)
    $86.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $86.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $86.Add_Click({ 
        Start-Process wsreset -NoNewWindow
        Write-host "Completato"
    })
    
    $87                       = New-Object System.Windows.Forms.Button
    $87.FlatStyle             = 'Flat'
    $87.Text                  = "Dism"
    $87.width                 = 300
    $87.height                = 30
    $87.Location              = New-Object System.Drawing.Point(10, 250)
    $87.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $87.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $87.Add_Click({ 
        Start-Process -FilePath "C:\Windows\System32\cmd.exe" -verb runas -ArgumentList {/k dism.exe /online /cleanup-image /restorehealth} 
            Write-host "Completato"
    })
    
    $88                       = New-Object System.Windows.Forms.Button
    $88.FlatStyle             = 'Flat'
    $88.Text                  = "SFC"
    $88.width                 = 300
    $88.height                = 30
    $88.Location              = New-Object System.Drawing.Point(10, 290)
    $88.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $88.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $88.Add_Click({ 
        Start-Process -FilePath "C:\Windows\System32\cmd.exe" -verb runas -ArgumentList {/k sfc /scannow}   
        Write-host "Completato"
    })

    $89                       = New-Object System.Windows.Forms.Button
    $89.FlatStyle             = 'Flat'
    $89.Text                  = "My Choices"
    $89.width                 = 150
    $89.height                = 30
    $89.Location              = New-Object System.Drawing.Point(10, 330)
    $89.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $89.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
     
    $89.Add_Click({ 
        $ErrorActionPreference = 'SilentlyContinue'
        Function DebloatBlacklist {
            Write-Host "Rimozione Bloatware..."
            Get-AppxPackage | Where-Object Name -cmatch $global:BloatwareRegex | Remove-AppxPackage
            Get-AppxProvisionedPackage -Online | Where-Object DisplayName -cmatch $global:BloatwareRegex | Remove-AppxProvisionedPackage -Online
            Get-AppxPackage -AllUsers | Where-Object Name -cmatch $global:BloatwareRegex | Remove-AppxPackage
        }
        DebloatBlacklist
            Function CheckDMWService {
        
            Param([switch]$Debloat)
        
            If (Get-Service dmwappushservice | Where-Object { $_.StartType -eq "Disabled" }) {
                Set-Service dmwappushservice -StartupType Automatic
            }
        
            If (Get-Service dmwappushservice | Where-Object { $_.Status -eq "Stopped" }) {
                Start-Service dmwappushservice
            } 
        }
        
        Function CheckInstallService {
        
            If (Get-Service InstallService | Where-Object { $_.Status -eq "Stopped" }) {  
                Start-Service InstallService
                Set-Service InstallService -StartupType Automatic 
            }
        }
        Write-Host "Rimozione in Corso"
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Type DWord -Value 1
        Stop-Process -Name "OneDrive" -ErrorAction SilentlyContinue
        Start-Sleep -s 2
        $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
        If (!(Test-Path $onedrive)) {
            $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
        }
        Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
        Start-Sleep -s 2
        Remove-Item -Path "$env:USERPROFILE\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse -ErrorAction SilentlyContinue
        If (!(Test-Path "HKCR:")) {
            New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
        }
        Remove-Item -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue

        Write-Host "Uninstalling Work Folders Client..."
        Disable-WindowsOptionalFeature -Online -FeatureName "WorkFolders-Client" -NoRestart -WarningAction SilentlyContinue | Out-Null
        
        Write-Host "Uninstalling Microsoft Print to PDF..."
        Disable-WindowsOptionalFeature -Online -FeatureName "Printing-PrintToPDFServices-Features" -NoRestart -WarningAction SilentlyContinue | Out-Null
        
        Write-Host "Uninstalling Microsoft XPS Document Writer..."
        Disable-WindowsOptionalFeature -Online -FeatureName "Printing-XPSServices-Features" -NoRestart -WarningAction SilentlyContinue | Out-Null
        
        Write-Host "Removing Default Fax Printer..."
        Remove-Printer -Name "Fax" -ErrorAction SilentlyContinue
        
        Write-Host "Uninstalling Math Recognizer..."
        Get-WindowsCapability -Online | Where-Object { $_.Name -like "MathRecognizer*" } | Remove-WindowsCapability -Online | Out-Null
        
        #Disable Logitech Gaming service
        Stop-Service "LogiRegistryService"
        Set-Service "LogiRegistryService" -StartupType Disabled
        
        #Disable Visual Studio Telemetry
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\VSCommon\14.0\SQM" -Name "OptIn" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\VSCommon\15.0\SQM" -Name "OptIn" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\VSCommon\16.0\SQM" -Name "OptIn" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\VSCommon\14.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\VSCommon\15.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\VSCommon\16.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\VSCommon\14.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\VSCommon\15.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\VSCommon\16.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\VisualStudio\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\VisualStudio\Telemetry" -Name TurnOffSwitch -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\VisualStudio\Feedback" -Name "DisableFeedbackDialog" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\VisualStudio\Feedback" -Name "DisableEmailInput" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\VisualStudio\Feedback" -Name "DisableScreenshotCapture" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\VisualStudio\Telemetry" -Name "TurnOffSwitch" -Type "DWORD" -Value 1 -Force
        Stop-Service "VSStandardCollectorService150"
        Set-Service "VSStandardCollectorService150" -StartupType Disabled
        
        #Disable Office Telemetry
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Name "DisableTelemetry" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Name "DisableTelemetry" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Name "VerboseLogging" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Name "VerboseLogging" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" -Name "EnableCalendarLogging" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" -Name "EnableCalendarLogging" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Word\Options" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Word\Options" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Word\Options" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Word\Options" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Name "EnableUpload" -Type "DWORD" -Value 0 -Force
        New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Name "EnableLogging" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Name "EnableUpload" -Type "DWORD" -Value 0 -Force
        #Disable Office Telemetry Agent
        schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /DISABLE
        schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack2016" /DISABLE
        schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /DISABLE
        schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn2016" /DISABLE
        #Disable Office Subscription Heartbeat
        schtasks /change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /DISABLE
        schtasks /change /TN "Microsoft\Office\Office 16 Subscription Heartbeat" /DISABLE
        #Disable Office feedback
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" -Name "Enabled" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" -Name "Enabled" -Type "DWORD" -Value 0 -Force
        #Disable Office Customer Experience Improvement Program
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common" -Force
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common" -Name "QMEnable" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" -Name "QMEnable" -Type "DWORD" -Value 0 -Force
        
        #Disable Mozilla Firefox Telemetry
        Set-ItemProperty -Path "HKLM:\Software\Policies\Mozilla\Firefox" -Name "DisableTelemetry" -Type "DWORD" -Value 1 -Force
        #Disable default browser agent reporting policy
        Set-ItemProperty -Path "HKLM:\Software\Policies\Mozilla\Firefox" -Name "DisableDefaultBrowserAgent" -Type "DWORD" -Value 1 -Force
        #Disable default browser agent reporting services
        schtasks.exe /change /disable /tn "\Mozilla\Firefox Default Browser Agent 308046B0AF4A39CB"
        schtasks.exe /change /disable /tn "\Mozilla\Firefox Default Browser Agent D2CEEC440E2074BD"
        
        #Disable Media Player Telemetry
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\MediaPlayer\Preferences" -Name "UsageTracking" -Type "DWORD" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\WindowsMediaPlayer" -Name "PreventCDDVDMetadataRetrieval" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\WindowsMediaPlayer" -Name "PreventMusicFileMetadataRetrieval" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\WindowsMediaPlayer" -Name "PreventRadioPresetsRetrieval" -Type "DWORD" -Value 1 -Force
        Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\WMDRM" -Name "DisableOnline" -Type "DWORD" -Value 1 -Force
        Set-Service WMPNetworkSvc -StartupType Disabled
        
        Write-Host "Disable synchronisation of settings"
        # These only apply if you log on using Microsoft account
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "BackupPolicy" 0x3c
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "DeviceMetadataUploaded" 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "PriorLogons" 1
        $groups = @(
            "Accessibility"
            "AppSync"
            "BrowserSettings"
            "Credentials"
            "DesktopTheme"
            "Language"
            "PackageState"
            "Personalization"
            "StartLayout"
            "Windows"
        )
        foreach ($group in $groups) {
            New-FolderForced -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\$group"
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\$group" "Enabled" 0
        }        
        Write-Host "Disabling driver offering through Windows Update..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Type DWord -Value 1
        Write-Host "Disabling Windows Update automatic restart..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
        Write-Host "Disabling driver offering through Windows Update..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "SearchOrderConfig" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Type DWord -Value 1
        Write-Host "Disabling Windows Update automatic restart..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe" -Name "Debugger" -Type String -Value "cmd.exe"
        Write-Host "Disable 'Updates are available' message"
        takeown /F "$env:WinDIR\System32\MusNotification.exe"
        icacls "$env:WinDIR\System32\MusNotification.exe" /deny "$($EveryOne):(X)"
        takeown /F "$env:WinDIR\System32\MusNotificationUx.exe"
        icacls "$env:WinDIR\System32\MusNotificationUx.exe" /deny "$($EveryOne):(X)"
        Write-Host "- Disabling Apps Suggestions..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableThirdPartySuggestions" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT" -Name "DontOfferThroughWUAU" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows" -Name "CEIPEnable" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "AITEnable" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableUAR" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" -Name "Start" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" -Name "Start" -Type DWord -Value 0  
        Write-Host "- Disabling 'WiFi Sense: HotSpot Sharing'..."
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "value" -Type DWord -Value 0
        Write-Host "- Disabling 'WiFi Sense: Shared HotSpot Auto-Connect'..."
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "value" -Type DWord -Value 0
        Write-Host "Showing full directory path in Explorer title bar..."
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Type DWord -Value 1
        Write-Host "Showing known file extensions..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0       
        Write-Host "Showing hidden files..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Type DWord -Value 1
        
        Write-Host "Showing folder merge conflicts..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideMergeConflicts" -Type DWord -Value 0
        Write-Host "Disabling navigation pane expanding to current folder..."
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneExpandToCurrentFolder" -ErrorAction SilentlyContinue
        Write-Host "Disabling Sharing Wizard..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SharingWizardOn" -Type DWord -Value 0
        Write-Host "Hiding recent shortcuts in Explorer..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Type DWord -Value 0
        Write-Host "Changing default Explorer view to This PC..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1
        Write-Host "Hiding Quick Access from Explorer navigation pane..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "HubMode" -Type DWord -Value 1
        Write-Host "Hiding Recycle Bin shortcut from desktop..."
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Type DWord -Value 1
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Type DWord -Value 1
        Write-Host "Hiding 3D Objects icon from This PC..."
        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -ErrorAction SilentlyContinue
        Write-Host "Hiding 3D Objects icon from Explorer namespace..."
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
        If (!(Test-Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag")) {
            New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
        Write-Host "Hiding 'Include in library' context menu item..."
        If (!(Test-Path "HKCR:")) {
            New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
        }
        Remove-Item -Path "HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location" -ErrorAction SilentlyContinue
        Write-Host "Hiding 'Give access to' context menu item..."
        If (!(Test-Path "HKCR:")) {
            New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
        }
        Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
        Remove-Item -Path "HKCR:\Directory\Background\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
        Remove-Item -Path "HKCR:\Directory\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
        Remove-Item -Path "HKCR:\Drive\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
        Write-Host "Hiding 'Share' context menu item..."
        If (!(Test-Path "HKCR:")) {
            New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
        }
        Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\ModernSharing" -ErrorAction SilentlyContinue
        Write-Host "O&O Shutup"
        Import-Module BitsTransfer      choco install shutup10 -y
        Start-BitsTransfer -Source "https://raw.githubusercontent.com/Iblis94/Paki/main/ooshutup10.cfg" -Destination ooshutup10.cfg      OOSU10 ooshutup10.cfg /quiet
        Start-BitsTransfer -Source "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -Destination OOSU10.exe    
        ./OOSU10.exe ooshutup10.cfg /quiet
        Write-Host "Disattivando Accesso Lista Lingue"
        Set-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Type DWord -Value 1  
        Write-Host "Disattivando Applicazioni Suggerite"
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-314559Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
        Write-Host "Disattivando Telemetria"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
        Write-Host "Disattivando Cronologia Attivita'"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
        Write-Host "Disattivando Tracking di Posizione"
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Deny"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value 0
        Write-Host "Disattivando Report Errori"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
        Write-Host "Disattivando Servizio di Tracking Diagnostica"
        Stop-Service "DiagTrack" -WarningAction SilentlyContinue
        Set-Service "DiagTrack" -StartupType Disabled
        Write-Host "Disattivando WAP Push Service"
        Stop-Service "dmwappushservice" -WarningAction SilentlyContinue
        Set-Service "dmwappushservice" -StartupType Disabled
        Write-Host "Disattivando Assistenza Remota"
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Type DWord -Value 0
        Write-Host "Disattivando Controllo Archiviazione"
        Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Recurse -ErrorAction SilentlyContinue
        Write-Host "Disattivando Superfetch"
        Stop-Service "SysMain" -WarningAction SilentlyContinue
        Set-Service "SysMain" -StartupType Disabled
        
        Write-Host "Disattivando Auto Manteinance"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "MaintenanceDisabled" -Type dword -Value 1
        Write-Host "Disattivando Reserved Storage"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" -Name "ShippedWithReserves" -Type dword -Value 0
        Write-Host "Disattivando AeroShake"
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisallowShaking" -Type dword -Value 1
        Write-Host "Disattivando Paint3D"
        $Paint3Dstuff = @(
                "HKCR:\SystemFileAssociations\.3mf\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.bmp\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.fbx\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.gif\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.jfif\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.jpe\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.jpeg\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.jpg\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.png\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.tif\Shell\3D Edit"
            "HKCR:\SystemFileAssociations\.tiff\Shell\3D Edit"
            )
            #Rename reg key to remove it, so it's revertible
            foreach ($Paint3D in $Paint3Dstuff) {
                If (Test-Path $Paint3D) {
                $rmPaint3D = $Paint3D + "_"
                Set-Item $Paint3D $rmPaint3D
            }
            }
            Write-Host "Disattivando Ripristino di Sistema"
            Disable-ComputerRestore -Drive "$env:SYSTEMDRIVE"
            Write-Host "Disattivando Deframmentazione Programmata"
            Disable-ScheduledTask -TaskName "Microsoft\Windows\Defrag\ScheduledDefrag" | Out-Null
            Write-Host "Disattivando Condivisione Connessione Internet"
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections" -Name "NC_ShowSharedAccessUI" -Type DWord -Value 0       
            Write-Host "Disattivando 'Aggiunti di Recenti' da Start"
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Type DWord -Value 1
            Write-Host "Disattivando Piu' Usati da Start"
            If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
                New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoStartMenuMFUprogramsList" -Type DWord -Value 1
            Write-Host "Disabling Background application access..."
            Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach {
                Set-ItemProperty -Path $_.PsPath -Name "Disabled" -Type DWord -Value 1
                Set-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -Type DWord -Value 1
            }
            Write-Host "Disabling Bing Search in Start Menu..."
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name ShellFeedsTaskbarViewMode -Type DWord -Value 2
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1    
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 0
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Type DWord -Value 1
            Write-Host "Stopping and disabling Windows Search indexing service..."
            Stop-Service "WSearch" -WarningAction SilentlyContinue
            Set-Service "WSearch" -StartupType Disabled
            Write-Host "Hiding Taskbar Search icon / box..."
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0
            $ErrorActionPreference = 'SilentlyContinue'
            $Bandwidth = "HKLM:\SOFTWARE\Policies\Microsoft\Psched"
            New-Item -Path $Bandwidth -ItemType Directory -Force
            Set-ItemProperty -Path $Bandwidth -Name "NonBestEffortLimit" -Type DWord -Value 0
            Write-Host "Disabling Cortana..."
            If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings")) {
                New-Item -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
            If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization")) {
                New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
            If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {
                New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0
            Write-Host "Enabling Dark Mode"
            Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
            Write-Host "Disabling automatic Maps updates..."
            Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0
            Write-Host "Disabling Feedback..."
            If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
                New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
            Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
            Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
            Write-Host "Disabling Tailored Experiences..."
            If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
                New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
            Write-Host "Disabling Advertising ID..."
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1
            
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -Type DWord -Value 0
            Write-Host "Disabling Wi-Fi Sense..."
            If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
                New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 0
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 0
            If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config")) {
                New-Item -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "AutoConnectAllowedOEM" -Type Dword -Value 0
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "WiFISenseAllowed" -Type Dword -Value 0
            Write-Host "Disattivando Adobe Flash"
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer" -Name "DisableFlashInIE" -Type DWord -Value 1
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons" -Name "FlashPlayerEnabled" -Type DWord -Value 0
            Write-Host "Disattivando IE Primo Accesso"
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Type DWord -Value 1
            Write-Host "Attivando NTFS con piu' di 260 Caratteri"
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Type DWord -Value 1
            Write-Host "Disattivando CloudStore se Presente"
            $CloudStore = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore'
            If (Test-Path $CloudStore) {
                Stop-Process Explorer.exe -Force
                Remove-Item $CloudStore -Recurse -Force
                Start-Process Explorer.exe -Wait
            }
            Write-Host "Disabling Xbox features..."
            Get-AppxPackage "Microsoft.XboxApp" | Remove-AppxPackage
            Get-AppxPackage "Microsoft.XboxIdentityProvider" | Remove-AppxPackage -ErrorAction SilentlyContinue
            Get-AppxPackage "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxPackage
            Get-AppxPackage "Microsoft.XboxGameOverlay" | Remove-AppxPackage
            Get-AppxPackage "Microsoft.Xbox.TCUI" | Remove-AppxPackage
            Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 0
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -Type DWord -Value 0
            Write-Host "Disattivando Alcune Chiavi di Registro"
            $ErrorActionPreference = 'SilentlyContinue'
            $Keys = @(
            
            New-PSDrive  HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
            #Remove Background Tasks
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            
            #Windows File
            "HKCR:\Extensions\ContractId\Windows.File\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            
            #Registry keys to delete if they aren't uninstalled by RemoveAppXPackage/RemoveAppXProvisionedPackage
            "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
            "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            
            #Scheduled Tasks to delete
            "HKCR:\Extensions\ContractId\Windows.PreInstalledConfigTask\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
            
            #Windows Protocol Keys
            "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
               
            #Windows Share Target
            "HKCR:\Extensions\ContractId\Windows.ShareTarget\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            )
            Write-Host "Attivando Ottimizzazione Schermo Intero"
            Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Type DWord -Value 0
            Remove-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehavior" -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Type DWord -Value 0
            Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Type DWord -Value 0
            Write-Host "Modifica: BIOS in UTC Time"
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 1
            Write-Host "Modifica: Task Manager Mostra Dettagli"
            $taskmgr = Start-Process -WindowStyle Hidden -FilePath taskmgr.exe -PassThru
            Do {
                Start-Sleep -Milliseconds 100
                $preferences = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -ErrorAction SilentlyContinue
            } Until ($preferences)
            Stop-Process $taskmgr
            $preferences.Preferences[28] = 0
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -Type Binary -Value $preferences.Preferences
            Write-Host "Modifica: Operazioni File Mostra Dettagli"
            If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager")) {
                New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" | Out-Null
            }
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1
            Write-Host "Disattivando Controllo PDF di Edge"
            $NoPDF = "HKCR:\.pdf"
            $NoProgids = "HKCR:\.pdf\OpenWithProgids"
            $NoWithList = "HKCR:\.pdf\OpenWithList" 
            If (!(Get-ItemProperty $NoPDF  NoOpenWith)) {
                New-ItemProperty $NoPDF NoOpenWith 
            }        
            If (!(Get-ItemProperty $NoPDF  NoStaticDefaultVerb)) {
                New-ItemProperty $NoPDF  NoStaticDefaultVerb 
            }        
            If (!(Get-ItemProperty $NoProgids  NoOpenWith)) {
                New-ItemProperty $NoProgids  NoOpenWith 
            }        
            If (!(Get-ItemProperty $NoProgids  NoStaticDefaultVerb)) {
                New-ItemProperty $NoProgids  NoStaticDefaultVerb 
            }        
            If (!(Get-ItemProperty $NoWithList  NoOpenWith)) {
                New-ItemProperty $NoWithList  NoOpenWith
            }        
            If (!(Get-ItemProperty $NoWithList  NoStaticDefaultVerb)) {
                New-ItemProperty $NoWithList  NoStaticDefaultVerb 
            }
                
            #Appends an underscore '_' to the Registry key for Edge
            $Edge = "HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_"
            If (Test-Path $Edge) {
                Set-Item $Edge AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_ 
            } 
            Write-Host "Modifica: Nascondendo Icona Task da Start"
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
            Write-Host "Modifica: Nascondendo Icona People da Start"
            If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
                New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" | Out-Null
            }
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0
            Write-Host "Installando Powerplan"
            powercfg -duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a
            powercfg -duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e
            powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
            powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
            Write-Host "Modifica: Taskbar Piu' Trasparente"
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "UseOLEDTaskbarTransparency" -Type dword -Value 1
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Dwm" -Name "ForceEffectMode" -Type dword -Value 1
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Type DWord -Value 20
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value 4194304
            fsutil behavior set DisableLastAccess 1
            fsutil behavior set EncryptPagingFile 0
            Write-Host "Modifica: Pannello di Controllo Icone Grandi"
            If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel")) {
                New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" | Out-Null
            }
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "StartupPage" -Type DWord -Value 1
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "AllItemsIconView" -Type DWord -Value 0
            Write-Host "Disabling Sticky keys prompt..."
            Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "506"
            
            Write-Host "Disabling Remote Desktop..."
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Type DWord -Value 1
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Type DWord -Value 1
            Disable-NetFirewallRule -Name "RemoteDesktop*"
            Write-Host "Disabling search for app in store for unknown extensions..."
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoUseStoreOpenWith" -Type DWord -Value 1
            Write-Host "Disabling 'How do you want to open this file?' prompt..."
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoNewAppAlert" -Type DWord -Value 1
            Write-Host "Disabling recent files lists..."
            If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
                New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsHistory" -Type DWord -Value 1
            Write-Host "Enabling clearing of recent files on exit..."
            If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
                New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "ClearRecentDocsOnExit" -Type DWord -Value 1
            Write-Host "Disabling SmartScreen Filter..."
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -Type DWord -Value 0
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Force | Out-Null
            }        
            Write-Host "Disabling nightly wake-up for Automatic Maintenance..."
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "WakeUp" -Type DWord -Value 0
            Write-Host "Disabling Windows Update automatic downloads..."
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -Type DWord -Value 2
            }
            Write-Host "Disabling updates for other Microsoft products..."
            If ((New-Object -ComObject Microsoft.Update.ServiceManager).Services | Where-Object { $_.ServiceID -eq "7971f918-a847-4430-9279-4a52d1efe18d"}) {
                (New-Object -ComObject Microsoft.Update.ServiceManager).RemoveService("7971f918-a847-4430-9279-4a52d1efe18d") | Out-Null
            }
            Write-Host "Disabling Malicious Software Removal Tool offering..."
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT" | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT" -Name "DontOfferThroughWUAU" -Type DWord -Value 1
            Write-Host "Restricting Windows Update P2P optimization to local network..."
            If ([System.Environment]::OSVersion.Version.Build -eq 10240) {
                # Method used in 1507
                If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")) {
                    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" | Out-Null
                }
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 1
            } ElseIf ([System.Environment]::OSVersion.Version.Build -le 14393) {
                # Method used in 1511 and 1607
                If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization")) {
                    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" | Out-Null
                }
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Type DWord -Value 1
            } Else {
                # Method used since 1703
                Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -ErrorAction SilentlyContinue
            }
            Write-Host "Disabling Controlled Folder Access..."
            Set-MpPreference -EnableControlledFolderAccess Disabled -ErrorAction SilentlyContinue
            Write-Host "Disabling Core Isolation Memory Integrity..."
            Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name "Enabled" -ErrorAction SilentlyContinue        
            Write-Host "Disabling Windows Defender Application Guard..."
            Disable-WindowsOptionalFeature -online -FeatureName "Windows-Defender-ApplicationGuard" -NoRestart -WarningAction SilentlyContinue | Out-Null
            Write-Host "Hiding Account Protection warning..."
            If (!(Test-Path "HKCU:\Software\Microsoft\Windows Security Health\State")) {
                New-Item -Path "HKCU:\Software\Microsoft\Windows Security Health\State" -Force | Out-Null
            }
            Set-ItemProperty "HKCU:\Software\Microsoft\Windows Security Health\State" -Name "AccountProtection_MicrosoftAccount_Disconnected" -Type DWord -Value 1
            Write-Host "Disabling blocking of downloaded files..."
            If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments")) {
                New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" | Out-Null
            }
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -Type DWord -Value 1
            Write-Host "Enabling Windows Script Host..."
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Script Host\Settings" -Name "Enabled" -ErrorAction SilentlyContinue
            Write-Host "Disabling .NET strong cryptography..."
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -ErrorAction SilentlyContinue
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -ErrorAction SilentlyContinue
            Write-Host "Disabling Meltdown (CVE-2017-5754) compatibility flag..."
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat" -Name "cadca5fe-87d3-4b96-b7fb-a231484277cc" -ErrorAction SilentlyContinue
            Write-Host "Lowering UAC level..."
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Type DWord -Value 0
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Type DWord -Value 0
            Write-Host "Enabling sharing mapped drives between users..."
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -Type DWord -Value 1
            Write-Host "Enabling implicit administrative shares..."
            Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "AutoShareWks" -ErrorAction SilentlyContinue
            Write-Host "Enabling SMB Server..."
            Set-SmbServerConfiguration -EnableSMB2Protocol $true -Force
            Write-Host "Disabling LLMNR..."
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -Type DWord -Value 0
            Write-Host "Setting current network profile to private..."
            Set-NetConnectionProfile -NetworkCategory Private
            Write-Host "Setting unknown networks profile to private..."
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24" -Name "Category" -Type DWord -Value 1
            Write-Host "Disabling automatic installation of network devices..."
            If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private")) {
                New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private" -Name "AutoSetup" -Type DWord -Value 0
            Write-Host "Enabling Firewall..."
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile" -Name "EnableFirewall" -ErrorAction SilentlyContinue
            Write-Host "Disabling Windows Defender..."
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Type DWord -Value 1
            If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
                Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsDefender" -ErrorAction SilentlyContinue
            } ElseIf ([System.Environment]::OSVersion.Version.Build -ge 15063) {
                Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -ErrorAction SilentlyContinue
            }
            Write-Host "Disabling Windows Defender Cloud..."
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Name "SpynetReporting" -Type DWord -Value 0
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Name "SubmitSamplesConsent" -Type DWord -Value 2
            Write-Host "Enabling F8 boot menu options..."
            bcdedit /set `{current`} bootmenupolicy Legacy | Out-Null
            Write-Host "Disabling NetBIOS over TCP/IP..."
            Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces\Tcpip*" -Name "NetbiosOptions" -Type DWord -Value 2
            Write-Host "Disabling Internet Connection Sharing..."
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections" -Name "NC_ShowSharedAccessUI" -Type DWord -Value 0
            Write-Host "Hiding Windows Defender SysTray icon..."
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" -Force | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" -Name "HideSystray" -Type DWord -Value 1
            If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
                Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsDefender" -ErrorAction SilentlyContinue
            } ElseIf ([System.Environment]::OSVersion.Version.Build -ge 15063) {
                Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -ErrorAction SilentlyContinue
            }
            Write-Host "Disabling Windows Defender Services"
            Takeown-Registry("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend")
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend" "Start" 4
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend" "AutorunsDisabled" 3
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WdNisSvc" "Start" 4
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WdNisSvc" "AutorunsDisabled" 3
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Sense" "Start" 4
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Sense" "AutorunsDisabled" 3
            Write-Host "Disattivando Vecchia Icona Volume"
            New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer -Value “”
            New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAVolume" -Type DWord -Value 1
        Write-host "Completato"    

    })

    $811                       = New-Object System.Windows.Forms.Button
    $811.FlatStyle             = 'Flat'
    $811.Text                  = "No FastBoot"
    $811.width                 = 150
    $811.height                = 30
    $811.Location              = New-Object System.Drawing.Point(160, 330)
    $811.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $811.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")
    
    $811.Add_Click({ 
        Write-Host "Disattivando Ibernazione"
        Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernateEnabled" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type DWord -Value 0
        powercfg /HIBERNATE OFF 2>&1 | Out-Null
        Write-Host "Disabling Fast Startup..."
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Type DWord -Value 0
        Write-host "Completato"
    })

    $8CustomizeForm.controls.AddRange(@($81,$82,$83,$84,$85,$86,$87,$88,$89,$810,$811))

            Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }
    
    [void]$8CustomizeForm.ShowDialog()

})

#####################
### END REPAIR PC ###
#####################

#################
##### GUIDE #####
#################

$Button9.Add_Click({
    $9CustomizeForm                  = New-Object System.Windows.Forms.Form
    $9CustomizeForm.ClientSize       = New-Object System.Drawing.Point(1920,1080)
    $9CustomizeForm.StartPosition    = 'CenterScreen'
    $9CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $9CustomizeForm.MinimizeBox      = $false
    $9CustomizeForm.MaximizeBox      = $true
    $9CustomizeForm.ShowIcon         = $false
    $9CustomizeForm.Text             = "Guida"
    $9CustomizeForm.TopMost          = $false
    $9CustomizeForm.AutoScroll       = $true
    $9CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

    $91                     = New-Object system.Windows.Forms.PictureBox
    $91.width               = 1920
    $91.height              = 1080
    $91.location            = New-Object System.Drawing.Point(0,0)
    $91.imageLocation       = "https://raw.githubusercontent.com/Iblis94/Paki/main/Bloatware.png"
    $91.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom

    $9CustomizeForm.controls.AddRange(@($91))

            Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }
    
    [void]$9CustomizeForm.ShowDialog()

})

$Button10.Add_Click({
    $10CustomizeForm                  = New-Object System.Windows.Forms.Form
    $10CustomizeForm.ClientSize       = New-Object System.Drawing.Point(1920,1080)
    $10CustomizeForm.StartPosition    = 'CenterScreen'
    $10CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $10CustomizeForm.MinimizeBox      = $false
    $10CustomizeForm.MaximizeBox      = $true
    $10CustomizeForm.ShowIcon         = $false
    $10CustomizeForm.Text             = "Guida"
    $10CustomizeForm.TopMost          = $false
    $10CustomizeForm.AutoScroll       = $true
    $10CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

    $101                     = New-Object system.Windows.Forms.PictureBox
    $101.width               = 1920
    $101.height              = 1080
    $101.location            = New-Object System.Drawing.Point(0,0)
    $101.imageLocation       = "https://raw.githubusercontent.com/Iblis94/Paki/main/Software.png"
    $101.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom

    $10CustomizeForm.controls.AddRange(@($101))

            Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }
    
    [void]$10CustomizeForm.ShowDialog()

})

$Button11.Add_Click({
    $11CustomizeForm                  = New-Object System.Windows.Forms.Form
    $11CustomizeForm.ClientSize       = New-Object System.Drawing.Point(1920,1080)
    $11CustomizeForm.StartPosition    = 'CenterScreen'
    $11CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $11CustomizeForm.MinimizeBox      = $false
    $11CustomizeForm.MaximizeBox      = $true
    $11CustomizeForm.ShowIcon         = $false
    $11CustomizeForm.Text             = "Guida"
    $11CustomizeForm.TopMost          = $false
    $11CustomizeForm.AutoScroll       = $true
    $11CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

    $111                     = New-Object system.Windows.Forms.PictureBox
    $111.width               = 1920
    $111.height              = 1080
    $111.location            = New-Object System.Drawing.Point(0,0)
    $111.imageLocation       = "https://raw.githubusercontent.com/Iblis94/Paki/main/Tweaks%20Privacy1.png"
    $111.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom

    $11CustomizeForm.controls.AddRange(@($111))

            Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }
    
    [void]$11CustomizeForm.ShowDialog()

})

$Button12.Add_Click({
    $12CustomizeForm                  = New-Object System.Windows.Forms.Form
    $12CustomizeForm.ClientSize       = New-Object System.Drawing.Point(1920,1080)
    $12CustomizeForm.StartPosition    = 'CenterScreen'
    $12CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $12CustomizeForm.MinimizeBox      = $false
    $12CustomizeForm.MaximizeBox      = $true
    $12CustomizeForm.ShowIcon         = $false
    $12CustomizeForm.Text             = "Guida"
    $12CustomizeForm.TopMost          = $false
    $12CustomizeForm.AutoScroll       = $true
    $12CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

    $121                     = New-Object system.Windows.Forms.PictureBox
    $121.width               = 1920
    $121.height              = 1080
    $121.location            = New-Object System.Drawing.Point(0,0)
    $121.imageLocation       = "https://raw.githubusercontent.com/Iblis94/Paki/main/Tweaks%20Update1.png"
    $121.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom

    $12CustomizeForm.controls.AddRange(@($121))

            Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }
    
    [void]$12CustomizeForm.ShowDialog()

})

$Button13.Add_Click({
    $13CustomizeForm                  = New-Object System.Windows.Forms.Form
    $13CustomizeForm.ClientSize       = New-Object System.Drawing.Point(1920,1080)
    $13CustomizeForm.StartPosition    = 'CenterScreen'
    $13CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $13CustomizeForm.MinimizeBox      = $false
    $13CustomizeForm.MaximizeBox      = $true
    $13CustomizeForm.ShowIcon         = $false
    $13CustomizeForm.Text             = "Guida"
    $13CustomizeForm.TopMost          = $false
    $13CustomizeForm.AutoScroll       = $true
    $13CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

    $131                     = New-Object system.Windows.Forms.PictureBox
    $131.width               = 1920
    $131.height              = 1080
    $131.location            = New-Object System.Drawing.Point(0,0)
    $131.imageLocation       = "https://raw.githubusercontent.com/Iblis94/Paki/main/Tweaks%20Security.png"
    $131.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom

    $13CustomizeForm.controls.AddRange(@($131))

            Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }
    
    [void]$13CustomizeForm.ShowDialog()

})

$Button14.Add_Click({
    $14CustomizeForm                  = New-Object System.Windows.Forms.Form
    $14CustomizeForm.ClientSize       = New-Object System.Drawing.Point(1920,1080)
    $14CustomizeForm.StartPosition    = 'CenterScreen'
    $14CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $14CustomizeForm.MinimizeBox      = $false
    $14CustomizeForm.MaximizeBox      = $true
    $14CustomizeForm.ShowIcon         = $false
    $14CustomizeForm.Text             = "Guida"
    $14CustomizeForm.TopMost          = $false
    $14CustomizeForm.AutoScroll       = $true
    $14CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

    $141                     = New-Object system.Windows.Forms.PictureBox
    $141.width               = 1920
    $141.height              = 1080
    $141.location            = New-Object System.Drawing.Point(0,0)
    $141.imageLocation       = "https://raw.githubusercontent.com/Iblis94/Paki/main/Tweaks%20Applicazioni.png"
    $141.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom

    $14CustomizeForm.controls.AddRange(@($141))

            Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }
    
    [void]$14CustomizeForm.ShowDialog()

})

$Button15.Add_Click({
    $15CustomizeForm                  = New-Object System.Windows.Forms.Form
    $15CustomizeForm.ClientSize       = New-Object System.Drawing.Point(1920,1080)
    $15CustomizeForm.StartPosition    = 'CenterScreen'
    $15CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $15CustomizeForm.MinimizeBox      = $false
    $15CustomizeForm.MaximizeBox      = $true
    $15CustomizeForm.ShowIcon         = $false
    $15CustomizeForm.Text             = "Guida"
    $15CustomizeForm.TopMost          = $false
    $15CustomizeForm.AutoScroll       = $true
    $15CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

    $151                     = New-Object system.Windows.Forms.PictureBox
    $151.width               = 1920
    $151.height              = 1080
    $151.location            = New-Object System.Drawing.Point(0,0)
    $151.imageLocation       = "https://raw.githubusercontent.com/Iblis94/Paki/main/Tweaks%20Explorer.png"
    $151.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom

    $15CustomizeForm.controls.AddRange(@($151))

            Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }
    
    [void]$15CustomizeForm.ShowDialog()

})

$Button16.Add_Click({
    $16CustomizeForm                  = New-Object System.Windows.Forms.Form
    $16CustomizeForm.ClientSize       = New-Object System.Drawing.Point(1920,1080)
    $16CustomizeForm.StartPosition    = 'CenterScreen'
    $16CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $16CustomizeForm.MinimizeBox      = $false
    $16CustomizeForm.MaximizeBox      = $true
    $16CustomizeForm.ShowIcon         = $false
    $16CustomizeForm.Text             = "Guida"
    $16CustomizeForm.TopMost          = $false
    $16CustomizeForm.AutoScroll       = $true
    $16CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#1f272e")

    $161                     = New-Object system.Windows.Forms.PictureBox
    $161.width               = 1920
    $161.height              = 1080
    $161.location            = New-Object System.Drawing.Point(0,0)
    $161.imageLocation       = "https://raw.githubusercontent.com/Iblis94/Paki/main/Repair%20PC.png"
    $161.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom

    $16CustomizeForm.controls.AddRange(@($161))

            Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }
    
    [void]$16CustomizeForm.ShowDialog()

})

#####################
##### END GUIDE #####
#####################


[void]$Form.ShowDialog()
