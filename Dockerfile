FROM armhf/alpine
LABEL architecture="ARMv7"

# Resin's qemu for cross-compiling support
ADD qemu-arm-static.tar.gz /
ADD spi_devicetree_overlay.dts /opt/spi_acc/

WORKDIR /opt/spi_acc/

RUN apk add --update --no-cache git flex make gcc g++ bison python-dev linux-headers && \
	git clone https://github.com/atenart/dtc && \
	make -C dtc && \
	make -C dtc install PREFIX=/usr && \
	rm -rf dtc && \

	dtc -I dts -O dtb -o spi_devicetree_overlay.dtb spi_devicetree_overlay.dts -@ && \

	git clone https://github.com/adafruit/Adafruit_Python_ADXL345.git && \
	cd Adafruit_Python_ADXL345 && \
	python setup.py install && \
	cd ../ && \

	apk del make gcc g++ flex bison linux-headers

ENTRYPOINT /bin/sh
