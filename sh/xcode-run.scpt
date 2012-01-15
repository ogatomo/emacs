on run argv
	tell application "Xcode"
		activate
		open item 1 of argv
		tell application "System Events"
			key code 15 using {command down}
		end tell
	end tell
end run