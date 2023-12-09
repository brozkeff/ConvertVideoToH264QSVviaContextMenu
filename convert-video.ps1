Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Write-Host "Launching FFmpeg settings dialog..."

$form = New-Object System.Windows.Forms.Form
$form.Text = 'FFmpeg Settings'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'


$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,120)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please select the output format and quality (higher Q is worse):'
$form.Controls.Add($label)

$comboBoxFormat = New-Object System.Windows.Forms.ComboBox
$comboBoxFormat.Location = New-Object System.Drawing.Point(10,40)
$comboBoxFormat.Size = New-Object System.Drawing.Size(260,21)
$comboBoxFormat.Items.Add('mp4')
$comboBoxFormat.Items.Add('mkv')
$comboBoxFormat.SelectedIndex = 0  #Default is mp4
$form.Controls.Add($comboBoxFormat)

$comboBoxQuality = New-Object System.Windows.Forms.ComboBox
$comboBoxQuality.Location = New-Object System.Drawing.Point(10,70)
$comboBoxQuality.Size = New-Object System.Drawing.Size(260,21)
20..31 | ForEach-Object { $comboBoxQuality.Items.Add($_) } # Q from 20 to 31
$comboBoxQuality.SelectedIndex = 9 # Default quality 29
$form.Controls.Add($comboBoxQuality)

$comboBoxSpeed = New-Object System.Windows.Forms.ComboBox
$comboBoxSpeed.Location = New-Object System.Drawing.Point(10,100)
$comboBoxSpeed.Size = New-Object System.Drawing.Size(260,21)
# Add speed settings here. Example:
$comboBoxSpeed.Items.Add('veryfast')
$comboBoxSpeed.Items.Add('fast')  # Default
$comboBoxSpeed.Items.Add('medium')
$comboBoxSpeed.Items.Add('slow')
# Add other options as needed
$comboBoxSpeed.SelectedIndex = 1 # Default is fast
$form.Controls.Add($comboBoxSpeed)

$form.Topmost = $true

Write-Host "Ready for user input."

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $format = $comboBoxFormat.SelectedItem
    $quality = $comboBoxQuality.SelectedItem
    $speed = $comboBoxSpeed.SelectedItem

    Write-Host "Format selected: $format"
    Write-Host "Quality selected: $quality"
    Write-Host "Speed selected: $speed"

    $inputFile = $args[0]
    $inputName = [System.IO.Path]::GetFileNameWithoutExtension($inputFile)
    $outputFile = "$inputName.$format"

    if (Test-Path $outputFile)
    {
        $outputFile = "$inputName-h264.$format"
    }

    $ffmpegCmd = "ffmpeg -i `"$inputFile`" -c:v h264_qsv -preset:v $speed -q:v $quality -c:a aac -strict experimental -q:a 1 `"$outputFile`""
    Write-Host "Executing FFmpeg command: $ffmpegCmd"
    Invoke-Expression $ffmpegCmd
}