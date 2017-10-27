# kamailio-base
A basic deployment of the kamailio sip server.

Comes pre-configured with a mysql database.  The database has been setup to allow running of kamdbctl without having to enter any mysql passwords.
Accounts do not need to be setup. They are created dynamically. No authentication for the accounts is required.

Usage:
To use this image you must first build the image, then run the container.

Build the Image:
    ./buildImage <host_ip_address>

    where <host_ip_address> is the IP address of the host running the Kamailio server.

Run the Container:
    ./runContainer


