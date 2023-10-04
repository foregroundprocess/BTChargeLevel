Set objShell = CreateObject ("Wscript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
strParentFolder = objFSO.GetParentFolderName(WScript.ScriptFullName)
strPSPath = objFSO.BuildPath(strParentFolder, "BTChargeLevel.ps1")
objShell.Run ("powershell -windowstyle hidden -executionpolicy bypass -noninteractive "&strPSPath),0