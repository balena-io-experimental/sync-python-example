# Warning: This is a test base image, please do not use in production!!
FROM nghiant2710/device-sync:jessie

# Add the apt sources for raspbian
RUN echo "deb http://archive.raspbian.org/raspbian jessie main contrib non-free rpi firmware" >>  /etc/apt/sources.list
RUN apt-key adv --keyserver pgp.mit.edu  --recv-key 0x9165938D90FDDD2E

# Install Python.
RUN apt-get update \
	&& apt-get install -yq python \
	# Remove package lists to free up space
	&& rm -rf /var/lib/apt/lists/*

# These env vars enable sync_mode on all devices.
ENV SYNC_MODE=on
ENV INITSYSTEM=on

# resin-sync will always sync to /usr/src/app, so code needs to be here.
WORKDIR /usr/src/app

# copy current directory into WORKDIR
COPY app/ ./

# run python script when container lands on device
CMD ["python", "main.py"]
