# Sune Kaae, 8/2/12.
# Step definitions for screenshots
# Uses the default syntax from the Step Definition Compendium (https://github.com/moredip/Frank/wiki/Step-Definition-compendium)
# If Oliver Fürniß's excellent "iOS-Simulator Cropper" tool is available, then use it
#   http://www.curioustimes.de/iphonesimulatorcropper/
# This tool gives you two advantages:
# - the screenshot will only include the Simulator's screen; not the full screen of the machine running it
# - the screenshot is captured properly, even if the Simulator is not in the foreground
# If the tool is not found, the standard behavior of the original step definition logic will be user
# ie, these steps are backwards compatible and does not break even if the tool is not available
# The step includes a thumbnail of the screenshot in the report (assuming you're doing --format html).
#   (It's just done with a "puts" command, nothing smart like hooking into the formatting options of cucumber)


# This is the same regex/phrasing as the original step from the compendium
Then /^I save a screenshot with prefix (\w+)$/ do |prefix|
 # contruct filename based on the prefix and a timestamp (in millis to avoid overwriting screenshots taken close to each other)
 filenameWithRelativePath = "#{prefix}_#{DateTime.now.strftime('%Q')}.png"

 # use iOS-Simulator Cropper if it's available, and use the standard screencapture if it's not available
 if (isCropperAvailable) then
  screenShotWithCropper(filenameWithRelativePath)
 else
  screenshotWithScreencapture(filenameWithRelativePath)
 end
 
 sleep 1 # wait a second to give screenshot time to finish.
 
 # add thumbnail of screenshot to the standard cucumber report as an HTML <img> element, with <a> link to full size
 showImageInReport(filenameWithRelativePath)
end

# return true/false depending on whether the cropper tool is available for use
def isCropperAvailable
  # Suggest to include a .zip'ed version of the .app dir in your SCM, eg "iOS-Simulator Cropper.app.zip"
  # then use build system / rake to do the unzip
  # Or, download the .zip from a trusted/reliable location, and include in build process
  File.directory? "iOS-Simulator Cropper.app"
end

# do a screenshot capture with the standard Mac screencapture command
def screenshotWithScreencapture filename
 %x[screencapture #{filename}]
end

# do a screenshot capture with the cropper tool
def screenShotWithCropper filename
  cmd = "./iOS-Simulator\\ Cropper.app/Contents/MacOS/iOS-Simulator\\ Cropper -f #{filename}"
  value = system( cmd )
end

# add thumbnail to output/html-report
def showImageInReport imageFileName
  image = "<img src=\"#{imageFileName}\" width=\"50\">"
  hyperlink = "<a href=\"#{imageFileName}\">#{image}</a>"
  puts hyperlink
end
