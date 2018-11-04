all: spidev_test max7219

bin/spidev_test: src/spidev_test.c
	gcc -O2 -Wall -o bin/spidev_test src/spidev_test.c

max7219: bin/max7219

spidev_test: bin/spidev_test

bin/max7219: src/max7219.c
	mkdir -p bin/
	gcc -O2 -Wall -o bin/max7219 src/max7219.c

clean:
	rm -f spidev_test bin/max7219

tests:
	modprobe spicc
	@echo "---==[ spidev 8 bits per word, clock speed = 1Mhz ]==---"
	./spidev_test -D /dev/spidev0.0 -s 1000000 -b 8
	@echo "---==[ spidev 16 bits per word, clock speed = 1Mhz ]==---"
	./spidev_test -D /dev/spidev0.0 -s 1000000 -b 16
	@echo "---==[ spidev 32 bits per word, clock speed = 1Mhz ]==---"
	./spidev_test -D /dev/spidev0.0 -s 1000000 -b 32
	@echo "---==[ spidev 32 bits per word, spi mode = 0 ]==---"
	./spidev_test -D /dev/spidev0.0 -s 1000000 -b 32
	@echo "---==[ spidev 32 bits per word, spi mode = 1 ]==---"
	./spidev_test -D /dev/spidev0.0 -s 1000000 -b 32 -H
	@echo "---==[ spidev 32 bits per word, spi mode = 2 ]==---"
	./spidev_test -D /dev/spidev0.0 -s 1000000 -b 32 -O
	@echo "---==[ spidev 32 bits per word, spi mode = 3 ]==---"
	./spidev_test -D /dev/spidev0.0 -s 1000000 -b 32 -H -O


.PHONY: clean tests
