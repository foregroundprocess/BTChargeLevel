#This script returns Bluetooth device battery charge level and writes it to Windows registry
#Change the value below to a name of your device exactly as it is called in the Bluetooth system settings
$BTDeviceFriendlyName = "EDIFIER WH950NB"

$Shell = New-Object -ComObject "WScript.Shell"
$BTHDevices = Get-PnpDevice -FriendlyName "*$($BTDeviceFriendlyName)*"

if ($BTHDevices) {
    $BatteryLevels = foreach ($Device in $BTHDevices) {
        $BatteryProperty = Get-PnpDeviceProperty -InstanceId $Device.InstanceId -KeyName '{104EA319-6EE2-4701-BD47-8DDBF425BBE5} 2' |
            Where-Object { $_.Type -ne 'Empty' } |
            Select-Object -ExpandProperty Data

        if ($BatteryProperty) {
            $BatteryProperty
        }
    }

    if ($BatteryLevels) {
        if (!(Test-Path HKCU:\Software\ForegroundProcess\BTChargeLevel)) {
            New-Item -Path HKCU:\Software\ForegroundProcess\BTChargeLevel -Force
        }
        Set-ItemProperty -Path HKCU:\Software\ForegroundProcess\BTChargeLevel -Name BTChargeLevel -Value $BatteryLevels
    }
}
