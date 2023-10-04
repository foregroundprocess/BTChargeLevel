# BTChargeLevel

## Description

This is a [Rainmeter](https://www.rainmeter.net) skin for displaying your Bluetooth device’s charge level. In Windows, you can usually see the value only in Bluetooth settings, which is not convenient.

The skin works ONLY with the Powershell script, which gets the device’s charge level and stores it in the system registry. The skin, in turn, reads the value from the registry and displays it on the desktop.

You must schedule the Powershell script with Task Scheduler for repeated execution, let’s say every 30 minutes.

## Installation

- Create a subfolder in Rainmeter skins folder (usually *%USERPROFILE%\Documents\Rainmeter\Skins*) and put the skin file *BTCharge.ini* into it.
- Create somewhere on your PC a folder for the scripts and put both *BTChargeLevel.ps1* and *BTChargeLevel.vbs* into it. It is better to avoid using spaces in folder's path.
- Create a new task in Task Scheduler. Set the trigger to run the task every 30-60 minutes. More frequent runs are not required unless your device discharges very quickly. I suggest scheduling the *BTChargeLevel.vbs* script, as running the Powershell script will make its window visible for a few seconds, which can be highly annoying. The *BTChargeLevel.vbs* script runs the *BTChargeLevel.ps1* in a hidden window.
- Enable the skin BTChargeLevel in Rainmeter.

## Configuration

- Edit the *BTChargeLevel.ps1* file and change the value of the variable `$BTDeviceFriendlyName` to the exact name of your Bluetooth device as it is shown in the Bluetooth settings.
- Edit the *BTCharge.ini* file and change skin settings according to your needs. You can change the label of the charge level indicator by changing the line `Text=BT: %1%`. Replace BT: with the text you need. Don’t forget to change the width of the widget in case it is too short for your text. By default, it is 50 pixels: `W=50`
