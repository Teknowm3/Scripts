# History Time Stamp Bash Code Instalation

## Setup

### Please run this code as the highest privileged user. You can review the history of the users within your authority.
	
	sudo su
	Please enter your root password.
 

### Clone the repository or copy the script file:

	git clone https://github.com/your-repo-name/shell-history-processor.git
	cd shell-history-processor


### Grant execution permissions to the script:

	chmod +x script.sh


### Run the script:

	sudo ./script.sh


## Example Output

	History for user: cihan (.zsh_history)
	2024-12-18 12:24:07 cihan ls -la
	2024-12-18 12:25:12 cihan cat file.txt

	History for user: root (.bash_history)
	2024-12-18 12:30:05 root apt update
	2024-12-18 12:31:10 root reboot
	

### If a file cannot be read:
	
	Cannot read history file for user: bob (.bash_history)
	

# Disclaimer

**This script is intended for educational purposes or system administration tasks. Ensure proper authorization before accessing or modifying user history files on any system.**
