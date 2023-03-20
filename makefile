#
#     Created by: Justin Stewart
#     Email: stewartm.justin@outlook.com
#

all: c ada fortran

c:
	gcc calce.c -lm -o c

ada:
	gnatmake calce.adb

fortran:
	f95 calce.f95 -o fortran

clean:
	rm calce.o calce.ali c calce fortran