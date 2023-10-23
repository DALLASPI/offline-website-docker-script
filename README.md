# offline-website-docker-script
Offline Website Docker Script for Raspberry Pi  A versatile script that automates the process of downloading a website and hosting it offline within a Docker container on a Raspberry Pi. Ideal for ensuring consistent access to web resources without an active internet connection. Tailored for Kali Linux but adaptable for other distributions.

# Offline Website Docker Script 🐳

This script is designed to download a website and make it available offline inside a Docker container on a Raspberry Pi, ensuring that you have access to your favorite web resources at all times, even without an internet connection. This is particularly useful for educational purposes, demonstrations, or simply for browsing your favorite sites offline. 🚀

## Prerequisites 📋

- A Raspberry Pi with Kali Linux installed.
- Internet connection (for initial setup and website download).
- Docker installed on your Raspberry Pi.

## How to Use 🛠️

1. **Download the Script**: Run the following command to download the script to your Raspberry Pi:

   ```bash
   wget https://raw.githubusercontent.com/DALLASPI/offline-website-docker-script/main/setup_offline_website.sh
   ```

2. **Make the Script Executable**: Give execute permissions to the script:

   ```bash
   chmod +x setup_offline_website.sh
   ```

3. **Run the Script**: Use the script to download a website and make it available offline. Replace `http://example.com` with the URL of the website you want to download:

   ```bash
   ./setup_offline_website.sh -u http://example.com -p 8081
   ```

   - `-u`: URL of the website.
   - `-p`: Port number (optional, defaults to 8080).

4. **Access the Website**: Once the script has run successfully, it will provide you with a URL to access the offline website. Open this URL in a web browser to view the site.

## Removal 🗑️

If you wish to remove the offline website and clean up your system, follow these steps:

1. **Stop and Remove the Docker Container**:

   ```bash
   sudo docker stop offline-website-container && sudo docker rm offline-website-container
   ```

2. **Remove the Docker Image**:

   ```bash
   sudo docker rmi offline-website
   ```

3. **Remove the Script and Downloaded Website**:

   ```bash
   rm -rf setup_offline_website.sh website/
   ```

## License 📜

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author 🖋️

- **GitHub**: [DALLASPI](https://github.com/DALLASPI)

Feel free to reach out if you have any questions or suggestions! Enjoy browsing offline! 🎉
