Differences from BoringSSL and OpenSSL
======================================

Here are the major differences between *ring* and BoringSSL & OpenSSL that
affect building:

* BoringSSL uses CMake and OpenSSL uses make(1). *ring* uses Visual Studio's
  native build system (msbuild) on Windows, and GNU Make otherwise.
* BoringSSL and OpenSSL both support building static or shared libraries.
  *ring* is only supported in static library form.
* *ring*'s static library is named libring.lib on Windows and libring.a on
  other platforms. BoringSSL and OpenSSL use different names.



Building on Linux and Similar Platforms
=======================================

There is no ./configure step.

GNU Make 3.81 or later is required. Perl 5.6.1 or later is also required 
(unless you disable all the assembly language optimizations by building
with ```NO_ASM=1```). *ring* is designed with cross-compilation in mind so it
expects variables ```CC```, ```CXX```, and ```ARCH``` to be passed
to ```make```:

    make -j6 CC=clang-3.7 CXX=clang-3.7++ ARCH=x86

GCC 4.8 and later are supported, as are clang 3.4 and later. Other compilers
will also probably work without too much trouble. Set ```ARCH``` to
either ```x86``` or ```x86_64```. (ARM and MIPS support is just waiting on some
tweaks of the build system and the test infrastructure.) If you are
cross-compiling then you need to have the proper gcc-multilibs and
g++-multilibs packages, or equivalent, installed.

The default build is a debug build (```CMAKE_BUILD_TYPE=DEBUG```). You can
build a release build with:

    make -j6 CC=clang-3.7 CXX=clang-3.7++ ARCH=x86 CMAKE_BUILD_TYPE=RELWITHDEBINFO

Then compile your applications with ```-Iring/include``` (assuming you put *ring*
into the ```ring``` subdirectory of your project) and add ```$(RING_LDFLAGS)```
to LDFLAGS in your linking step. ```RING_LDFLAGS``` expands by default
to ```-pthread -Lbuild/lib/libring.a -lring```. (It should also be easy to
build *ring* so that it doesn't depend on pthreads, but the build system hasn't
been enhanced to fully support that yet.)

Running the tests currently requires Go (https://golang.org/) to be in ```$PATH```:

    make check -j6 CC=clang-3.7 CXX=clang-3.7++ ARCH=x86



Building on Windows
===================

Note that currently the assembly language optimizations are NOT built on
Windows yet, only because the additions to the project files to support doing
so haven't been made yet.

The Windows build requires Visual Studio 2013 or later. Any edition will work.
Open ```ring.sln``` in Visual Studio and choose Build|Build Solution.
Alternatively, from a Visual Studio Native Tools Command Prompt:

    msbuild ring.sln

The built libring.lib will be put into a subdirectory of build/ depending on
which configuration and which platform you choose to build for. For example,
in a 32-bit debug build, the result is ```build\Win32-Debug\lib\libring.lib```.
In your application's project, add *ring*'s ```include/``` subdirectory to the
"Additional Include Directories", add the directory containing ```libring.lib```
to the "Additional Library Directories", and add ```libring.lib``` to the
linker "Additional Dependencies".

On Windows, *ring* can be build in Debug or Release configurations for
platforms Win32 or x64. (It should be easy to add support for the ARM platform
too.) The solution builds correctly using either Visual Studio 2013 or Visual
Studio 2015 without any conversion steps being necessary. The project files are
mostly hand-written and rely heavily on the property sheets in ```mk\*.props```.
All Visual Studio features should work. However, Visual Studio's project property
editor often wrongly shows properties set in the property sheets as being
unset. In general, it is much better to edit the ```*.props``` files by hand
instead of using Visual Studio's GUI to edit the projects.

The tests currently require Go (https://golang.org/). For a 64-bit release
build, run this from within the *ring* subdirectory:

    go run util/all_tests.go --build-dir=build/x64-Release/test/ring
