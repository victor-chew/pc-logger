; Copyright 2020 Victor Chew
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
;     http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.

#NoTrayIcon
#include <FileConstants.au3>
#include <HTTP.au3>

; Find the following information from your own Google Form
; Look for "<form action="
Local $FormResponseUrl = "https://docs.google.com/forms/u/0/d/e/1FAIpQLSeikfeU0vxcCOhG5mqKi3Sa-J-_NhItW-ESUYyFYDx8UNK9Nw/formResponse"
; Look for "data-params=" followed by &quot;Username&quot;,null,0,[[<number>
Local $FormUsername = -1
; Look for "data-params=" followed by &quot;Executable&quot;,null,0,[[<number>
Local $FormExecutable = -1
; Look for "data-params=" followed by &quot;Title&quot;,null,0,[[<number>
Local $FormWinTitle = -1

; Main program starts
Local $oldWindow = "<NULL>"
while True
	sleep(60000)
	$title = WinGetTitle("[ACTIVE]")
	If $oldWindow <> $title Then 
		Local $Actwin = WinGetHandle("[active]")
		Local $PidActwin = WinGetProcess($Actwin)
		Local $Processlist = ProcessList()
		$exe = "<NULL>"
		For $i = 1 To $Processlist[0][0]
				If $Processlist[$i][1] = $PidActwin Then $exe = $Processlist[$i][0]
		Next
		_HTTP_Post($FormResponseUrl, _
			URLEncode("entry." & $FormUsername) & "=" & URLEncode(@UserName) & "&" & _
			URLEncode("entry." & $FormExecutable) & "=" & URLEncode($exe) & "&" & _
			URLEncode("entry." & $FormWinTitle) & "=" & URLEncode($title))
	EndIf
WEnd
