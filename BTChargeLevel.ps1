#This script looks for Bluetooth device battery charge level and connection status and then writes them to Windows registry
#Change the value below to a name of your device exactly as it is called in the Bluetooth system settings
$BTDeviceFriendlyName = "EDIFIER WH950NB"

$BTHDevices = Get-PnpDevice -FriendlyName "*$($BTDeviceFriendlyName)*"
$BTChargeLevel = $null
$IsConnected = $false

if ($BTHDevices) {
    foreach ($Device in $BTHDevices) {
        $BTDeviceProperties = Get-PnpDeviceProperty -InstanceId $Device.InstanceId
        foreach ($BTDeviceProperty in $BTDeviceProperties){
            if (($BTDeviceProperty.KeyName -eq "{104EA319-6EE2-4701-BD47-8DDBF425BBE5} 2") -and ($null -ne $BTDeviceProperty.Data)){
                $BTChargeLevel = $BTDeviceProperty.Data
            }            
        
            if (($BTDeviceProperty.KeyName -eq "{83DA6326-97A6-4088-9453-A1923F573B29} 15") -and ($null -ne $BTDeviceProperty.Data)){
                $IsConnected = $BTDeviceProperty.Data            
            }
        }
    }

    if ($null -ne $IsConnected) {
        if (!(Test-Path HKCU:\Software\ForegroundProcess\BTChargeLevel)) {
            New-Item -Path HKCU:\Software\ForegroundProcess\BTChargeLevel -Force
        }
        Set-ItemProperty -Path HKCU:\Software\ForegroundProcess\BTChargeLevel -Name BTChargeLevel -Value $BTChargeLevel
        Set-ItemProperty -Path HKCU:\Software\ForegroundProcess\BTChargeLevel -Name IsConnected -Value $IsConnected
    }
}
