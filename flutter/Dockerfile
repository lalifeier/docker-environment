# https://github.com/matsp/docker-flutter

FROM ubuntu:22.04

USER root

# https://docs.fastlane.tools/getting-started/ios/setup/#set-up-environment-variables
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Android SDK
ENV ANDROID_HOME=/opt/android-sdk-linux
ENV ANDROID_SDK_ROOT=$ANDROID_HOME \
    PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/emulator:${ANDROID_HOME}/platforms

# https://developer.android.com/studio/#command-tools
ENV ANDROID_SDK_TOOLS_VERSION 8512546

# sdkmanager --list
ENV ANDROID_VERSION=30
ENV ANDROID_BUILD_TOOLS_VERSION="30.0.3"
ENV ANDROID_ARCHITECTURE="x86_64"

RUN set -o xtrace \
    && cd /opt \
    && apt-get update \
    && apt-get install -y openjdk-11-jdk \
    && apt-get install -y sudo wget zip unzip git openssh-client curl bc software-properties-common build-essential ruby-full ruby-bundler libstdc++6 libpulse0 libglu1-mesa locales lcov libsqlite3-0 --no-install-recommends \
    # for x86 emulators
    && apt-get install -y libxtst6 libnss3-dev libnspr4 libxss1 libasound2 libatk-bridge2.0-0 libgtk-3-0 libgdk-pixbuf2.0-0 \
    && rm -rf /var/lib/apt/lists/* \
    && sh -c 'echo "en_US.UTF-8 UTF-8" > /etc/locale.gen' \
    && locale-gen \
    && update-locale LANG=en_US.UTF-8 \
    && mkdir -p $HOME/.android \
    && touch $HOME/.android/repositories.cfg \
    && wget -q https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS_VERSION}_latest.zip -O android-sdk-tools.zip \
    && mkdir -p ${ANDROID_HOME}/cmdline-tools/ \
    && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME}/cmdline-tools/ \
    && mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest \
    && rm android-sdk-tools.zip \
    && yes | sdkmanager --licenses \
    && sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    && sdkmanager "platforms;android-${ANDROID_VERSION}" \
    && sdkmanager platform-tools \
    && sdkmanager emulator \
    && sdkmanager "system-images;android-${ANDROID_VERSION};google_apis_playstore;${ANDROID_ARCHITECTURE}"
    # && wget -O /usr/bin/android-wait-for-emulator https://raw.githubusercontent.com/travis-ci/travis-cookbooks/master/community-cookbooks/android-sdk/files/default/android-wait-for-emulator \
    # && chmod +x /usr/bin/android-wait-for-emulator \

# Flutter
ARG flutter_version=stable

ENV FLUTTER_HOME=/usr/local/flutter \
    FLUTTER_VERSION=$flutter_version
ENV FLUTTER_ROOT=$FLUTTER_HOME

ENV PUB_HOSTED_URL=https://pub.flutter-io.cn \
    FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

ENV FLUTTER_WEB_PORT=8090
ENV FLUTTER_DEBUG_PORT=42000
ENV FLUTTER_EMULATOR_NAME=flutter_emulator

RUN mkdir -p ${FLUTTER_HOME} \
    && git clone --depth 1 --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME} \
    && flutter config --no-analytics --enable-web \
    && flutter precache \
    && yes | flutter doctor --android-licenses \
    && flutter doctor \
    && flutter emulators --create \
    && flutter update-packages

# COPY entrypoint.sh /usr/local/bin/
# COPY chown.sh /usr/local/bin/
COPY flutter-android-emulator.sh /usr/local/bin/flutter-android-emulator
COPY flutter-web.sh /usr/local/bin/flutter-web
# ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
