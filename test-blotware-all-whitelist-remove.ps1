$whitelistapps = @(
    # Whitelist apps
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.Office.OneNote"
    "Microsoft.WindowsAlarms"
    "Microsoft.WindowsCalculator"
    "Microsoft.WindowsCamera"
    "microsoft.windowscommunicationsapps"
	"Microsoft.NET.Native.Framework.2.2"
	"Microsoft.NET.Native.Framework.2.0"
	"Microsoft.NET.Native.Runtime.2.2"
	"Microsoft.NET.Native.Runtime.2.0"
	"Microsoft.UI.Xaml.2.7"
	"Microsoft.UI.Xaml.2.0"
	"Microsoft.WindowsAppRuntime.1.3"
	"Microsoft.NET.Native.Framework.1.7"
	"MicrosoftWindows.Client.Core"
	"Microsoft.LockApp"
	"Microsoft.ECApp"
	"Microsoft.Windows.ContentDeliveryManager"
	"Microsoft.Windows.Search"
	"Microsoft.Windows.OOBENetworkCaptivePortal"    
	"Microsoft.Windows.SecHealthUI"
	"Microsoft.WindowsAppRuntime.CBS"
	"Microsoft.VCLibs.140.00.UWPDesktop"
	"Microsoft.VCLibs.120.00.UWPDesktop"
	"Microsoft.VCLibs.110.00.UWPDesktop"
	"Microsoft.DirectXRuntime"
	"Microsoft.XboxGameOverlay"
	"Microsoft.XboxGamingOverlay"
	"Microsoft.GamingApp"
	"Microsoft.GamingServices"
	"Microsoft.XboxIdentityProvider"
	"Microsoft.Xbox.TCUI"
	"Microsoft.AccountsControl"
	"Microsoft.WindowsStore"
	"Microsoft.StorePurchaseApp"
	"Microsoft.VP9VideoExtensions"
	"Microsoft.RawImageExtension"
	"Microsoft.HEIFImageExtension"
	"Microsoft.HEIFImageExtension"
	"Microsoft.WebMediaExtensions"
	"RealtekSemiconductorCorp.RealtekAudioControl"
	"Microsoft.MicrosoftEdge"
	"Microsoft.MicrosoftEdge.Stable"
	"MicrosoftWindows.Client.FileExp"
	"NVIDIACorp.NVIDIAControlPanel"
    "AppUp.IntelGraphicsExperience"
    "Microsoft.Paint"
    "Microsoft.Messaging"
	"Microsoft.AsyncTextService"
	"Microsoft.CredDialogHost"
	"Microsoft.Win32WebViewHost"
	"Microsoft.MicrosoftEdgeDevToolsClient"
	"Microsoft.Windows.OOBENetworkConnectionFlow"
	"Microsoft.Windows.PeopleExperienceHost"
	"Microsoft.Windows.PinningConfirmationDialog"
	"Microsoft.Windows.SecondaryTileExperience"
	"Microsoft.Windows.SecureAssessmentBrowser"
	"Microsoft.Windows.ShellExperienceHost"
	"Microsoft.Windows.StartMenuExperienceHost"
	"Microsoft.Windows.XGpuEjectDialog"
	"Microsoft.XboxGameCallableUI"
	"MicrosoftWindows.UndockedDevKit"
	"NcsiUwpApp"
	"Windows.CBSPreview"
	"Windows.MiracastView"
	"Windows.ContactSupport"
	"Windows.PrintDialog"
	"c5e2524a-ea46-4f67-841f-6a9465d9d515"
	"windows.immersivecontrolpanel"
    "NotepadPlusPlus"
)

$RemoveAppPkgs = (Get-AppxPackage -AllUsers).Name
'TotalApps: ' + $RemoveAppPkgs.Count
'TotalWhiteListedApps: ' + $whitelistapps.Count
'TotalBlackListeedApps: ' + ($RemoveAppPkgs.Count - $apps.Count)

$ErrorActionPreference= "SilentlyContinue";

pause
ForEach($TargetApp in $RemoveAppPkgs)
{
    If($whitelistapps -notcontains $TargetApp)
    {
        "Trying to remove $TargetApp"

        Get-AppxPackage -Name $TargetApp -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue

        Get-AppXProvisionedPackage -Online |
            Where-Object DisplayName -EQ $TargetApp |
            Remove-AppxProvisionedPackage -Online | Out-Null
    }
}