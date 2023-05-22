Last login: Sat Jun 15 08:18:52 2019 from 2408:8207:183d:5700:f4a3:8d13:ee3b:22a3
root@vultr:~# sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/Jigsaw-Code/outline-server/master/src/server_manager/install_scripts/install_server.sh)"
> Verifying that Docker is installed .......... NOT INSTALLED
> Would you like to install Docker? This will run 'curl -sS https://get.docker.com/ | sh'. [Y/n] Y
> Installing Docker ........................... OK
> Verifying Docker installation................ OK
> Verifying that Docker daemon is running ..... OK
> Creating persistent state dir ............... OK
> Generating secret key ....................... OK
> Generating TLS certificate .................. OK
> Generating SHA-256 certificate fingerprint .. OK
> Writing config .............................. OK
> Starting Shadowbox .......................... OK
> Starting Watchtower ......................... OK
> Waiting for Outline server to be healthy .... OK
> Creating first user ......................... OK
> Adding API URL to config .................... OK
> Checking host firewall ...................... OK

CONGRATULATIONS! Your Outline server is up and running.

To manage your Outline server, please copy the following line (including curly
brackets) into Step 2 of the Outline Manager interface:

{"apiUrl":"https://66.42.38.51:34509/mBANZn8uI93WJ2X2GmqRkw","certSha256":"D188117F620D6764FD8281FB7EF64ADAD664FA8FADB01E72CC5A6BAEB97ED5B5"}

If you have connection problems, it may be that your router or cloud provider
blocks inbound connections, even though your machine seems to allow them.

Make sure to open the following ports on your firewall, router or cloud provider:
- Management port 34509, for TCP
- Access key port 7287, for TCP and UDP
