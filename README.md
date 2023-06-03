# managedChrome (macOS Only)
Script to automatically download, config, and package the latest stable version of Google Chrome for easy deployment and remote cloud management on macOS devices.

## Just clone, config, and run
### Clone
To clone the GitHub repository to your local machine, run the following command in Terminal.
```bash
git clone https://github.com/nwfem/managedChrome.git
```

### Config
Modify the `CloudManagementEnrollmentToken` value in the `com.google.Chrome.plist` file. You can find information about Enrollment Tokens [here](https://support.google.com/chrome/a/answer/9301891?hl=en). (Other policies can be added here, however it is usually ideal to [set policies via Cloud Management](https://support.google.com/chrome/a/answer/9301892?hl=en&ref_topic=9301744&sjid=5408719157466370766-NA).
```bash
nano managedChrome/com.google.Chrome.plist
```

### Run
Run the script.
```bash
./managedChrome/run.sh
```
This will automatically download the latest stable version of Google Chrome and add it, along with your .plist file, to a package archive, ready to be installed on your user's systems. The script will also print the application version and SHA-256 hash for use with MDM deployments or pakage managers.

### Locate .pkg file
The final .pkg file can be found at the path `managedchrome/googlechrome.pkg`.
