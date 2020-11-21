####################################
####################################
#####   Password-Generator     #####
#####   Author  MaddoxOriginal #####
#####   Version:       1.0     #####
#####   Date:   09.09.2020     #####
####################################
####################################
#
#           GitHub Link
# https://github.com/maddoxoriginal
#
#

#Variables
$counter = 0 #Counter for create password with selected length
$maxrdm = 5  #set maximum random number to 5
$minrdm = 1  #set minimum random number to 1
$version = "Version: 1.0" 

#Settings Window
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$window = New-Object System.Windows.Forms.Form
$window.Text ="Password-Generator"
#$geticon = New-Object system.drawing.icon (".\pg-ps-icon.ico")
#$window.Icon = $geticon
$window.Width = 500
$window.Height = 400

#Label Settings
$labelauthor = New-Object System.Windows.Forms.Label
$labelauthor.Location = New-Object System.Drawing.Size(300,10)
$labelauthor.font = New-Object System.Drawing.Font(7,7)
$labelauthor.Text = "Password-Generator by MaddoxOriginal"
$labelauthor.AutoSize = $True
$window.Controls.Add($labelauthor)

$labellength = New-Object System.Windows.Forms.Label
$labellength.Location = New-Object System.Drawing.Size(10,10)
$labellength.Text = "Choose password length:"
$labellength.AutoSize = $True
$window.Controls.Add($labellength)

$labelversion = New-Object System.Windows.Forms.Label
$labelversion.Location = New-Object System.Drawing.Size(300,25)
$labelversion.font = New-Object System.Drawing.Font(7,7)
$labelversion.Text = $version
$labelversion.AutoSize = $True
$window.Controls.Add($labelversion)

$linkgithub = New-Object System.Windows.Forms.LinkLabel 
$linkgithub.Location = New-Object System.Drawing.Size(434,25) 
$linkgithub.Size = New-Object System.Drawing.Size(150,20) 
$linkgithub.font = New-Object System.Drawing.Font(7,7)
$linkgithub.LinkColor = "blue" 
$linkgithub.ActiveLinkColor = "blue" 
$linkgithub.Text = "GitHub" 
$linkgithub.add_Click({[system.Diagnostics.Process]::start("https://github.com/maddoxoriginal")}) 
$window.Controls.Add($linkgithub) 

$labelinfosc = New-Object System.Windows.Forms.Label
$labelinfosc.Location = New-Object System.Drawing.Size(10,80)
$labelinfosc.Text = "Choose your included special character:"
$labelinfosc.AutoSize = $True
$window.Controls.Add($labelinfosc)

$labelinfosc2 = New-Object System.Windows.Forms.Label
$labelinfosc2.Location = New-Object System.Drawing.Size(10,120)
$labelinfosc2.Text = "Minimum 2 chars required to enable this option!"
$labelinfosc2.AutoSize = $True
$window.Controls.Add($labelinfosc2)

$labelresult = New-Object System.Windows.Forms.Label
$labelresult.Location = New-Object System.Drawing.Size(10,230)
$labelresult.Text = "Your generated password is:"
$labelresult.AutoSize = $True
$window.Controls.Add($labelresult)

#Textfield Settings
$specialcharsbx = New-Object System.Windows.Forms.TextBox
$specialcharsbx.Location = New-Object System.Drawing.Size(10,100)
$specialcharsbx.Size = New-Object System.Drawing.Size(250,500)
$window.Controls.Add($specialcharsbx)

$outputbx = New-Object System.Windows.Forms.TextBox
$outputbx.Location = New-Object System.Drawing.Size(10,250)
$outputbx.Size = New-Object System.Drawing.Size(460,500)
$window.Controls.Add($outputbx)

$lengthbx = New-Object System.Windows.Forms.TextBox
$lengthbx.Location = New-Object System.Drawing.Size(10,30)
$lengthbx.Size = New-Object System.Drawing.Size(50,500)
$lengthbx.Text = "16"
$window.Controls.Add($lengthbx)

#Button Handling
$defaultscbutton = New-Object System.Windows.Forms.Button
$defaultscbutton.Location = New-Object System.Drawing.Size(260,100)
$defaultscbutton.Size = New-Object System.Drawing.Size(215,20)
$defaultscbutton.ForeColor  = "black"
$defaultscbutton.BackColor  = "DarkGray"
$defaultscbutton.Text = "use some defined defaults"
$defaultscbutton.Add_Click({ #Button for setting a string of default special characters
    $specialcharsbx.Text = ")!%?_/(-=&+" #Some special characters that are more or less accepted in passwords
  })
$generatebutton = New-Object System.Windows.Forms.Button
$generatebutton.Location = New-Object System.Drawing.Size(400,300)
$generatebutton.Size = New-Object System.Drawing.Size(75,50)
$generatebutton.ForeColor  = "black"
$generatebutton.BackColor  = "green"
$generatebutton.Text = "generate"
$generatebutton.Add_Click({
   $counter = 0 #Set counter to 0 for new password
   $scvar = $specialcharsbx.Text
   $lengthvar = [int]$lengthbx.Text
   $lenghend  = $lengthvar -1
   $maxrdm = 5  #set maximum random number to 5
   $scarray = $scvar -split '' | Where-Object {$_ -ne ''} #split entries in textfield into single characters
   if ($lengthvar -lt 4) { # Check for password length 
      $password = "Please choose a length greater than 3"
      $counter = $lengthvar #End creating password by setting counter to selected length
   }   
   if ($scvar.Length -lt 2) { # Check for special characters length
      $maxrdm = 4   #Ignore special characters with setting maxrdm to 4
   } 
   
   while($counter  -ne $lengthvar){ #Start creating password
      $option = Get-Random -Minimum 1 -Maximum $maxrdm #Set Random Option

      if ($counter -eq '0') { #first char should not be a special character 
          $option = Get-Random -Minimum 1 -Maximum 4
      }
      if ($counter -eq $lenghend) { #last char should not be a special character 
          $option = Get-Random -Minimum 1 -Maximum 4
      }

      if ($option -eq '1') { #Add higher characters to generated password
          $passwordchar = Get-Random "Z","Y","X","W","V","U","T","S","R","Q","P","O","N","M","L","K","J","I","H","G","F","E","D","C","B","A"
      } elseif ($option -eq '2') { #Add lower characters to generated password
          $passwordchar = Get-Random "z","y","x","w","v","u","t","s","r","q","p","o","n","m","l","k","j","i","h","g","f","e","d","c","b","a"
      } elseif ($option -eq '3') { #Add numbers to generated password
          $passwordchar = Get-Random -Minimum 0 -Maximum 10
      } elseif ($option -eq '4') { #Add special characters to generated password
          $passwordchar = Get-Random -InputObject $scarray -Count 1
      }

      $password += [string]$passwordchar #Add charcters as string to the variable password
      $counter += 1 #Count for password length
   }

   $outputbx.Text = $password  #Print password   
  })
 
#Add buttons
$window.Controls.Add($defaultscbutton)
$window.Controls.Add($generatebutton)

#END
[void]$window.ShowDialog()

# bx= box, sc= special character(s), rdm= random
###EOF###