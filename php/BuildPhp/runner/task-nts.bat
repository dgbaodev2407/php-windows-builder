set LDFLAGS="/d2:-AllowCompatibleILVersions" 2>&1
call phpsdk_deps.bat -s staging -u 2>&1
if errorlevel 1 exit 1
call buildconf.bat --force 2>&1
if errorlevel 1 exit 2
call config.nts.bat --help
call config.nts.bat --disable-all --enable-zip --with-readline --enable-cli --enable-opcache --enable-runkit7 --enable-runkit7-super --enable-runkit7-modify 2>&1
if errorlevel 1 exit 3
nmake 2>&1
if errorlevel 1 exit 4
call phpsdk_pgo --init 2>&1
if errorlevel 1 exit 5
call phpsdk_pgo --train --scenario default 2>&1
if errorlevel 1 exit 6
call phpsdk_pgo --train --scenario cache 2>&1
if errorlevel 1 exit 7
nmake clean-pgo 2>&1
if errorlevel 1 exit 8
sed -i "s/enable-pgi/with-pgo/" config.nts.bat 2>&1
if errorlevel 1 exit 9
call config.nts.bat 2>&1
if errorlevel 1 exit 10
nmake && nmake snap 2>&1
if errorlevel 1 exit 11
