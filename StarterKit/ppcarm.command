SOURCES_BASE="$HOME/Developer/ObjectivePascal/fpc"
SYSTEM_SDK_PATH=`xcrun --show-sdk-path`
IOS_SDK=13.0

set -e

echo "Enter the base FPC version:"
ls /usr/local/lib/fpc
read BASE_FPC_VERSION;

BOOT_STRAP="/usr/local/lib/fpc/${BASE_FPC_VERSION}/ppcx64"

#  Install FPC for iOS Device 64bit ( ppcrossa64 )
cd ${SOURCES_BASE}
sudo make distclean -j 3
rm -rf packages/*/units packages/*/units_bs utils/units
rm -rf utils/*/unitsO
export IOS_SDK=`xcrun --sdk iphoneos --show-sdk-path`
export BIN_BASE=${IOS_SDK}/usr/bin
sudo make FPC=${BOOT_STRAP} OPT="-ap -XR${SYSTEM_SDK_PATH}" CPU_TARGET=aarch64 CROSSOPT="-FD${BIN_BASE} -XR${IOS_SDK}" all
sudo make FPC=${SOURCES_BASE}/compiler/ppcrossa64 OPT="-ap -XR${SYSTEM_SDK_PATH}" CPU_TARGET=aarch64 CROSSOPT="-WP${IOS_SDK} -FD${BIN_BASE} -XR${IOS_SDK} -ap" install CROSSINSTALL=1 

# Install FPC for iOS 64bit Simulator (  ppcrossx64 )
sudo make distclean -j 3
rm -rf packages/*/units packages/*/units_bs utils/units
rm -rf utils/*/units
export IOS_SDK=`xcrun --sdk iphonesimulator --show-sdk-path`
export BIN_BASE=${IOS_SDK}/usr/bin  
sudo make FPC=${BOOT_STRAP} OPT="-ap -XR${SYSTEM_SDK_PATH}" CPU_TARGET=x86_64 OS_TARGET=iphonesim CROSSOPT="-WP${IOS_SDK} -FD${BIN_BASE} -XR${IOS_SDK}" all 
sudo make crossinstall CPU_TARGET=x86_64 OS_TARGET=iphonesim 
