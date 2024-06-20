Try {


# Define the download URL and the destination
$ssmsUrl = "https://aka.ms/ssmsfullsetup"
$destination = "$env:TEMP\ssms_installer.exe"

# Download SSMS installer
Invoke-WebRequest -Uri $ssmsUrl -OutFile $destination

# Install SSMS silently
Start-Process -FilePath $destination -ArgumentList "/S" -Wait


# Define the download URL and the destination
$ssmsUrl = "https://aka.ms/ssmsfullsetup"
$destination = "$env:TEMP\ssms_installer.exe"

# Download SSMS installer
Invoke-RestMethod -Uri $ssmsUrl -OutFile $destination

# Install SSMS silently
Start-Process -FilePath $destination -ArgumentList "/S" -Wait



# Create C# Code to Download SSMS installer
Add-Type -TypeDefinition @"
    using System.IO;
    using System.Net.Http;

    public static class Downloader {
        public static void DownloadInstaller() {
            //Define the download URL and the destination
            string ssmsUrl  = "https://aka.ms/ssmsfullsetup";
            string destination = Path.Join(Path.GetTempPath(), "ssms_installer.exe");

            using (var client = new HttpClient())
            {
                using (var s = client.GetStreamAsync(ssmsUrl ))
                {
                    using (var fs = new FileStream(destination, FileMode.OpenOrCreate))
                    {
                        s.Result.CopyTo(fs);
                    }
                }
            }
        }
    }
"@
[Downloader]::DownloadInstaller()

# Install SSMS silently
Start-Process -FilePath "$env:TEMP\ssms_installer.exe" -ArgumentList "/S" -Wait



  } catch {
    Write-Error -Message $_.Exception
    throw $_.Exception
}
