## Daftar Isi
- [About](#About)
- [Notes](#ImportantNotes)
- [Usage](#Usage)
- [Contribute](#Kontribusi)

## About
Script For Hardening Linux Server,Fresh Install on Bash Script.

Hardening a Linux server involves several steps to enhance its security and protect it from potential attacks. Below is a basic script that covers some essential hardening techniques, including setting up a firewall, disabling unused services, and implementing user privilege management. This script is intended for educational purposes and should be tested in a safe environment before deploying it on a production server.

## Important Notes:

Backup: Always back up your server before making significant changes.
Testing: Test the script in a non-production environment first to ensure it works as expected.
Customization: Modify the script according to your specific needs, such as changing the SSH port or adding/removing services.
Security Policies: Ensure that your security policies comply with your organization's requirements.
Monitoring: Consider implementing additional monitoring and logging solutions for ongoing security.

## Usage
Execution:
Download, use the script file (e.g., hardening.sh), make it executable, and then execute it with root privileges:

chmod +x harden_linux.sh
sudo ./harden_linux.sh

## Kontribusi
1. Fork repository ini.
2. Buat branch baru untuk fitur Anda (`git checkout -b feature-fix`).
3. Commit perubahan Anda (`git commit -am 'Add new feature'`).
4. Push ke branch (`git push origin feature-fix`).
5. Buat Pull Request.


![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![License](https://img.shields.io/badge/license-MIT-blue)
