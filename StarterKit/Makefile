
FPC_ROOT := /usr/local/lib/fpc/3.3.1
BINARY := hello
BUNDLE := hello.app
BUNDLE_ID := com.alchemistguild.hello
PROGRAM := hello.pas
OUTPUT := ./output

# Download iOS 8 headers (the latest available at this time)
# https://github.com/genericptr/iOS_8_0
HEADERS := ./iOS_8_0

SDK_IPHONE_SIM := `xcrun --sdk iphonesimulator --show-sdk-path`
SDK_IPHONE_OS := `xcrun --sdk iphoneos --show-sdk-path`


# xcode settings for deployment to device
# https://github.com/ios-control/ios-deploy
XCODE_TARGET_NAME := hello
XCODE_SCHEME := ${XCODE_TARGET_NAME}
XCODE_DEPLOY_PRODUCT := ./xcode/DerivedData/${XCODE_TARGET_NAME}/Build/Products/Debug-iphoneos/${XCODE_TARGET_NAME}.app
XCODE_DEPLOY_OS := 12.0
XCODE_PROJ := ./xcode/${XCODE_TARGET_NAME}.xcodeproj

all: clean iphonesim

clean:
	rm -f ${BINARY}

iphoneos:
	mkdir -p ${OUTPUT}
	${FPC_ROOT}/ppcrossa64 -vbr -dIPHONEALL -Fu${HEADERS} -FU${OUTPUT} -WP${XCODE_DEPLOY_OS} -XR${SDK_IPHONE_OS} ${PROGRAM}
	touch ${XCODE_DEPLOY_PRODUCT}/_CodeSignature
	xcodebuild -project ${XCODE_PROJ} -scheme ${XCODE_SCHEME}

iphonesim:
	mkdir -p ${OUTPUT}
	${FPC_ROOT}/ppcrossx64 -Tiphonesim -vbr -dIPHONEALL -Fu${HEADERS} -FU${OUTPUT} -Ff${SDK_IPHONE_SIM}/System/Library/Frameworks ${PROGRAM}
	# XR/WP is broken now so we need to use -Ff
	# /usr/local/lib/fpc/3.3.1/ppcrossx64 -Tiphonesim -vbr -dIPHONEALL -Fu${HEADERS} -FU${OUTPUT} -WP13.0 -XR${SDK_IPHONE_SIM} ${PROGRAM}
	cp -f ${BINARY} ${BUNDLE}/${BINARY}

launch:
	open -a Simulator.app
	xcrun simctl terminate booted ${BUNDLE_ID}
	xcrun simctl install booted ${BUNDLE}
	xcrun simctl launch booted ${BUNDLE_ID}
	tail -f `xcrun simctl getenv booted SIMULATOR_LOG_ROOT`/system.log

deploy:
	ios-deploy --debug --bundle ${XCODE_DEPLOY_PRODUCT}
