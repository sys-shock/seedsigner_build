Read Me
=======

# Important Info:
______

Date modified (Read Me/script): 20211005/20211001

______

>:warning: _Warning_ :warning:
>
>This script is currently in Alpha and experimental, download and use it at your own risk.
>I need some help testing and getting the script to work properly. If you know shell scripting please consider helping out, thank you.

______
# Base Image

## Download and verify Raspbian SDcard image for a Raspberry Pi 

* Download the image from https://www.raspberrypi.com/software/operating-systems :
    ```
    wget https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-05-28/2021-05-07-raspios-buster-armhf-lite.zip
    ```
    SHA256: c5dad159a2775c687e9281b1a0e586f7471690ae28f2f2282c90e7d59f64273c
* Download the signature of the image file:
    ```
    wget https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-05-28/2021-05-07-raspios-buster-armhf-lite.zip.sig
    ```
* Import the Raspberry Pi Downloads Signing Key:
    ```
    curl https://www.raspberrypi.org/raspberrypi_downloads.gpg.key | gpg --import
    ```
* Verify the image:  
    ```
    gpg --verify 2021-05-07-raspios-buster-armhf-lite.zip.sig
    ```
    Look for the `Good signature`:
    ```
    gpg: assuming signed data in '2021-05-07-raspios-buster-armhf-lite.zip'
    gpg: Signature made Fri 28 May 2021 15:00:58 BST
    gpg:                using RSA key 54C3DD610D9D1B4AF82A37758738CD6B956F460C
    gpg: Good signature from "Raspberry Pi Downloads Signing Key" [unknown]
    gpg: WARNING: This key is not certified with a trusted signature!
    gpg:          There is no indication that the signature belongs to the owner.
    Primary key fingerprint: 54C3 DD61 0D9D 1B4A F82A  3775 8738 CD6B 956F 460C
    ```

* Flash the image to an SDcard, can use the [Raspberry Pi Imager](https://www.raspberrypi.org/downloads/)

* put a file called simply: `ssh` to the root of the SDcard.  
Read more on [how to gain ssh access here](https://www.raspberrypi.org/documentation/remote-access/ssh/).
* boot up the RPi 

* connect directly with HDMI monitor and keyboard and activate the wifi with:
    ```
    sudo raspi-config
    ```
    or if using aRaspberry Pi 3 or 4 attach a network cable
    and log in with ssh to:
    ```
    pi@LAN_IP_ADDRESS
    ```
    The default password is: `raspberry`

* Continue to download the `seedsigner_build.sh`:
    ```
    wget https://raw.githubusercontent.com/openoms/seedsigner_build/main/seedsigner_build.sh
    ```

______

`seedsigner_build.sh`

SHA256: f668b620e8048110fb36a121ef22bf6974c79bca5f0dda28cdf54339a151ae48

MD5: 41b5cdcb5e26b0edd5aed7776c31664e

______

Run the script __ONCE__. This script manipulates text in a way that will create multiple of the same entries in text files if run more than once.

You are _Highly_ encouraged to review this script (also compare the SHA256 or MD5 hash) before you run it and compare it to the process descibed by the [SeedSigner](https://github.com/SeedSigner/seedsigner) read me. The two should be fairly comparable. I noted what each function does above the script running.

In order to check the SHA256 or MD5 hash on Linux open a terminal where you downloaded the script and run the command `sha256sum seedsigner_build.sh` or `md5sum seedsigner_build.sh`

If you are on Windows you can pull up a powershell and run the command `certUtil -hashfile <path_to_file> <hash_algo(SHA256/MD5)>`

## How to contribute:

> I am new to this and as such welcome other new contributors.

As a starting point check the bottom of this ReadMe to find the initial issues of the script.
Then after that parse through the script (and any open issues) and do one or both of the following ...

1. Open an issue. Please provide details of the issue you found.

2. Open a pull request. Please detail why you made the changes you did and the benefits (if any) that it brings.

__Goals__ for this script:

1. Get the script to work.

2. Rewrite the script so it can be run more than once and not add un-needed text to config files.

3. Rewrite the script to be more interactive.


## SeedSigner Build Script:
______

This script is intended to emulate every step in the manual build process for the [SeedSigner](https://github.com/SeedSigner/seedsigner) project in a quick and automated way to build from scratch. This script also goes a few steps further than the described process by removing the [Microsoft GPG key and vscode](https://www.reddit.com/r/linux/comments/lbu0t1/microsoft_repo_installed_on_all_raspberry_pis/) from the OS image.
This script also disables the virtual memory as a default. If you want to keep the virtual memory, go into and edit the `seedsigner_build.sh` file and add a comment (#) before the 4 lines after the line `# (Optional) modify system swap config to disable virtual memory.`.
It can also change the user password. This can be turned on by uncommenting (#) the commands to change the password.

Currently the script can change the localization to English (e), French (f), German (g), Italian, (i), Portuguese (European) (pe), Portuguese (Brazilian) (pb), Spanish (Castilian) (sc), Spanish (Mexican) (sm), Spanish (Venezuelan) (sv), Arabic (United Arab Emeriates) (uae), Arabic (Iraq) (ai), Arabic (Saudi Arabian) (asa), Chinese (Hong Kong) (chk), Chinese (Mainland China) (cmc).

>:warning: _Locale_ _Note_ :warning:
>
>I have not tested or tried out any other language setting other than english in the script (still need it to work once), as such more testing is required than what I can personally give to this little project at the moment. Any and all help is appreciated.


:construction: Tested status :construction:

| English (e) | French (f) | German (g) | Italian (i) | Portuguese (European) (pe) | Portuguese (Brazilian) (pb) | Spanish (Castilian) (sc) | Spanish (Mexican) (sm) | Spanish (Venezuelan) (sv) | Arabic (United Arab Emeriates) (uae) | Arabic (Iraq) (ai) | Arabic (Saudi Arabian) (asa) | Chinese (Hong Kong) (chk) | Chinese (Mainland China) (cmc) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| :negative_squared_cross_mark: | :negative_squared_cross_mark: | :negative_squared_cross_mark: | :negative_squared_cross_mark: | :negative_squared_cross_mark: | :negative_squared_cross_mark: | :negative_squared_cross_mark: | :negative_squared_cross_mark: | :negative_squared_cross_mark: | :negative_squared_cross_mark: | :negative_squared_cross_mark: | :negative_squared_cross_mark: | :negative_squared_cross_mark: | :negative_squared_cross_mark: |


### How to get started:
______

Download, verify, and then write the [Raspberry Pi Lite OS](https://www.raspberrypi.org/software/operating-systems/) to a micro SD card. I use [Balena Etcher](https://www.balena.io/etcher/) to write .iso images but you can write the image however you wish. Once you have the SD card with the raspios-lite image on it, mount the SD card to the same computer you downloaded the seedsigner_build.sh script to and do the following. 


> :warning: __Warning__ :warning:
>
> Always verify your downloads by comparing the sha256 hash or by GPG key if available.


#### Steps:
______

1. Take the seedsigner_build.sh file and copy/place it in the `/boot` folder of the SD card you just burned the RPI OS on to.
2. Unmount the SD card and then put it in the RPI that you will be using to build the SeedSigner.
3. Ensure the RPI is connected to the internet and then power the device on.
4. Log in to the RPI under the `user - pi` with the `password - raspberry` (either SSH in or connect a keyboard and moniter to the RPI).
5. Move to the build scripts location with `cd /boot`
6. Make the script able to be executed with `sudo chmod a+x seedsigner_build.sh`
7. Run the script `sudo ./seedsigner_build.sh`

The script should now be running, just watch the terminal for any error messages and for any interaction you may need to do.

##### Known Issues:
______

> The SD card (that the script is ran on) does not boot up when put into the RPI zero 1.3 and powered on.
>
> The script may not be able to find the `.profile` file for setting up the virtual enviroment.
>
> The command `mkvirtualenv` is not found. (possibly related to the .profile problem)
>
> Sometimes the dependencies will not download in one of the five iterations.

