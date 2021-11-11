
# Unofficial Raptoreum wallet GUI and daemon for docker

Unofficial [raptoreum](http://www.raptoreum.org/) wallet GUI docker image to be run standalone or inside a browser window using [Xpra](https://www.xpra.org/).

Having the wallet available as docker container has some advantages like:

* Run the wallet GUI on a remote server inside a web browser window.
* Run the wallet GUI locally without installing package dependencies.
* Easier updating when new versions are available.

## Build instructions

We use `docker-compose` to build the images. Clone this repository and then:

    cd docker-raptoreum-wallet
    sudo docker-compose build

This command will build the wallet image.

## How to run the Wallet

The wallet can be run in two ways:

* As a standalone X11 application
* Inside a web browser window using [Xpra](https://www.xpra.org/).

### Standalone wallet

The `docker-compose` file mounts your X11 session's socket (/tmp/.X11-unix) so the container can connect back to your X server. To start the wallet with `docker-compose`:

    sudo docker-compose up

To start the wallet in production mode the the `-d` parameter to the previous
command:

    sudo docker-compose up -d

You can see the container logs with this command:

    sudo docker-compose logs -f

After the container finish starting up the Raptoreum wallet will show up in your
screen

### Web view wallet

This is useful to run the wallet (and leave it running if you want) on a remote server and avoid wasting huge amounts of space locally holding the blockchain copy. I run it on a NAS, which is always on and connected to the Internet.

To run the wallet inside a web browser you need to define the environment variable `ENABLE_WEB_VIEW=yes` on the `docker-compose.yml` file. Then start the wallet with `docker-compose` as before:

    sudo docker-compose up -d

After some minutes the wallet will be available in http://[host]:10000, were host is the server name or IP address of the server running the wallet container.

** Note: For some reason the wallet window appears at the bottom right corner and is hidden behind the virtual keyboard. Close the keyboard from the upper left window and drag the wallet window to the center of the screen.


You can change the port using the environment variable `WEB_VIEW_PORT`.


## Debugging
To enable debug output, set the environment variable `DEBUG=yes`.
