#!/bin/bash
LEGACY_SDK_VERSION=1.0.0
DOWNLOAD_PATH=https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-legacy-wrapper/${LEGACY_SDK_VERSION}/ios-jumio-mobile-legacy-wrapper-${LEGACY_SDK_VERSION}.zip
CHECKOUT_DIR="${PROJECT_DIR}/LEGACY_DOWNLOAD"
FRAMEWORKS_DIR="${PROJECT_DIR}/Frameworks"

if [ -d "${FRAMEWORKS_DIR}/JumioLegacyWrapper.xcframework" ]; then
	echo "Jumio Legacy frameworks already available (see ${FRAMEWORKS_DIR})"
else
	curl --connect-timeout 5 -o "$PROJECT_DIR/frameworks.zip" --fail "${DOWNLOAD_PATH}"

	if [ -f "$PROJECT_DIR/frameworks.zip" ]; then
		unzip "$PROJECT_DIR/frameworks.zip" -d "${CHECKOUT_DIR}"
		rm -f "$PROJECT_DIR/frameworks.zip"
		
        mkdir "$FRAMEWORKS_DIR"
		cp -a "${CHECKOUT_DIR}/." "${FRAMEWORKS_DIR}"
		rm -rf "${CHECKOUT_DIR}"
	else
		echo "error: Unable to retrieve latest Jumio Mobile Legacy SDK ${JUMIO_SDK_VERSION} for iOS"
		exit 1
	fi
fi

JUMIO_SDK_VERSION=4.9.1
DOWNLOAD_PATH=https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/${JUMIO_SDK_VERSION}/ios-jumio-mobile-sdk-${JUMIO_SDK_VERSION}.zip
CHECKOUT_DIR="${PROJECT_DIR}/JUMIO_DOWNLOAD"
FRAMEWORKS_DIR="${PROJECT_DIR}/Frameworks"

if [ -d "${FRAMEWORKS_DIR}/Jumio.xcframework" ]; then
    echo "Jumio frameworks already available (see ${FRAMEWORKS_DIR})"
else
    curl --connect-timeout 5 -o "$PROJECT_DIR/frameworks.zip" --fail "${DOWNLOAD_PATH}"

    if [ -f "$PROJECT_DIR/frameworks.zip" ]; then
        unzip "$PROJECT_DIR/frameworks.zip" -d "${CHECKOUT_DIR}"
        rm -f "$PROJECT_DIR/frameworks.zip"
        
        cp -a "${CHECKOUT_DIR}/." "${FRAMEWORKS_DIR}"
        cp -a "${CHECKOUT_DIR}/Jumio/." "${FRAMEWORKS_DIR}"
        rm -rf "${CHECKOUT_DIR}"
        rm -rf "${FRAMEWORKS_DIR}/Jumio"
        rm -rf "${FRAMEWORKS_DIR}/JumioSlim"
    else
        echo "error: Unable to retrieve latest Jumio Mobile SDK ${JUMIO_SDK_VERSION} for iOS"
        exit 1
    fi
fi
