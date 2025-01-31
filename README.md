System Monitoring Script

This bash script monitors system resources such as disk usage, CPU usage, and memory usage. It generates a report that is saved to a log file and sends email alerts if any resource usage exceeds predefined thresholds, specifically monitoring the root partition for disk usage.
Features:

    Monitors disk, CPU, and memory usage.
    Specifically checks the root partition (/) disk usage.
    Allows customization of thresholds for resource usage.
    Saves system report to a log file.
    Sends email alerts if any threshold is exceeded.

Prerequisites:

    Linux-based operating system (e.g., Ubuntu, CentOS).
    Utilities: df, top, free, ps, mail, bc.
    A configured mail agent (e.g., sendmail, mailx) for email notifications.

Installation:

    Clone this repository or download the script file system_monitor.sh.
    Make the script executable:

    chmod +x system_monitor.sh

Usage:
Basic Command:

Run the script to monitor system usage and save the report to the default log file (system_monitor.log):

./system_monitor.sh

Command-Line Arguments:

    -t <threshold>: Set a usage threshold (default is 80%) for disk, CPU, and memory usage.
    -f <log_file>: Specify the log file to save the report (default is system_monitor.log).

Example Usage:

./system_monitor.sh -t 75 -f custom_log.log

This sets the thresholds for disk, CPU, and memory usage to 75% and saves the report to custom_log.log.
Available Alerts:

    Disk Usage: Specifically checks if the root partition (/) exceeds the threshold and triggers a warning.
    CPU Usage: Warns if the CPU usage exceeds the specified threshold.
    Memory Usage: Warns if memory usage exceeds the specified threshold.

Example of Root Partition Disk Alert:

If the root partition usage exceeds the threshold, the script will generate a warning like:

Warning: Root partition is above 80% usage!

Email Alerts:

If any resource exceeds the threshold, an email will be sent to the address configured in the script (user@example.com).
ystem Monitoring Report - 2025-01-31 07:15:10
======================================
Disk Usage:
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           1.6G  2.3M  1.6G   1% /run
/dev/sda3       406G  136G  250G  36% /
tmpfs           7.8G   30M  7.7G   1% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
/dev/loop1      128K  128K     0 100% /snap/bare/5
/dev/loop0       64M   64M     0 100% /snap/core20/1828
/dev/loop2       64M   64M     0 100% /snap/core20/2434
/dev/loop4       74M   74M     0 100% /snap/core22/1722
/dev/loop5      347M  347M     0 100% /snap/gnome-3-38-2004/119
/dev/loop6      350M  350M     0 100% /snap/gnome-3-38-2004/143
/dev/loop7      506M  506M     0 100% /snap/gnome-42-2204/176
/dev/loop10      13M   13M     0 100% /snap/snap-store/1216
/dev/loop12      45M   45M     0 100% /snap/snapd/23258
/dev/loop9       92M   92M     0 100% /snap/gtk-common-themes/1535
/dev/loop11      46M   46M     0 100% /snap/snap-store/638
/dev/loop8      517M  517M     0 100% /snap/gnome-42-2204/202
/dev/loop13      45M   45M     0 100% /snap/snapd/23545
/dev/nvme0n1p1   96M   32M   65M  33% /boot/efi
tmpfs           1.6G  124K  1.6G   1% /run/user/1000
/dev/loop14      74M   74M     0 100% /snap/core22/1748

Warning: Root partition is above 12% usage!

CPU Usage:
Current CPU Usage: 4.4%


Memory Usage:
Total Memory: 15Gi 
Used Memory: 3.1Gi 
Free Memory: 2.0Gi


Top 5 Memory-Consuming Processes:
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
user      660666  0.5  3.6 1943580 591732 ?      Sl   ينا30   3:05 /usr/lib/virtualbox/VBoxHeadless --comment deploy_locally_default_1738265855400_18974 --startvm 3f3d9d95-11cc-47fb-ba7b-c198acecb507 --vrde config
user      731312  8.5  2.5 3805144 405128 ?      Sl   06:51   1:59 /usr/lib/firefox/firefox -new-window
user        1926  0.6  2.2 4921624 371280 ?      Ssl  ينا25  59:31 /usr/bin/gnome-shell
user      727255  7.7  1.9 1220016260 308076 ?   Sl   06:41   2:35 /usr/share/code/code --type=renderer --crashpad-handler-pid=727224 --enable-crash-reporter=41f85851-3638-4586-883c-d3a959384166,no_channel --user-data-dir=/home/user/.config/Code --standard-schemes=vscode-webview,vscode-file --enable-sandbox --secure-schemes=vscode-webview,vscode-file --cors-schemes=vscode-webview,vscode-file --fetch-schemes=vscode-webview,vscode-file --service-worker-schemes=vscode-webview --code-cache-schemes=vscode-webview,vscode-file --app-path=/usr/share/code/resources/app --enable-sandbox --enable-blink-features=HighlightAPI --disable-blink-features=FontMatchingCTMigration, --lang=en-US --num-raster-threads=4 --enable-main-frame-before-activation --renderer-client-id=4 --time-ticks-at-unix-epoch=-1738066514418952 --launch-time-ticks=231974444722 --shared-files=v8_context_snapshot_data:100 --field-trial-handle=3,i,16868128297848058222,4309026912285101437,262144 --disable-features=CalculateNativeWinOcclusion,SpareRendererForSitePerProcess --variations-seed-version --vscode-window-config=vscode:26cab33c-76cf-4a11-af94-a18282ff5160
user      731549  8.6  1.6 2750368 271124 ?      Sl   06:51   2:00 /usr/lib/firefox/firefox -contentproc -isForBrowser -prefsHandle 0 -prefsLen 36735 -prefMapHandle 1 -prefMapSize 261229 -jsInitHandle 2 -jsInitLen 254356 -parentBuildID 20241230151726 -sandboxReporter 3 -chrootClient 4 -ipcHandle 5 -initialChannelId {1d7abf5b-f47b-4835-a288-50dd392a19e3} -parentPid 731312 -crashReporter 6 -greomni /usr/lib/firefox/omni.ja -appomni /usr/lib/firefox/browser/omni.ja -appDir /usr/lib/firefox/browser 7 tab

