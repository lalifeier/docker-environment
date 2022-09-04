#!/bin/sh

# node
# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

cat >> ~/.zshrc <<EOF
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOF

nvm install --lts
# nvm alias default node

# go
# gvm
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

cat >> ~/.zshrc <<EOF
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

export GO111MODULE="on"
export GOPROXY=https://goproxy.cn,direct
export GOPRIVATE=
# 关闭校验Go依赖包的哈希值
export GOSUMDB=off
EOF

gvm listall

gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.18.5
# go env -w GOPROXY=https://goproxy.cn,direct

gvm use go1.18.5 --default

# python
# pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

cat >> ~/.zshrc <<EOF
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOF

# poerty
# sudo apt install python3-pip
curl -sSL https://install.python-poetry.org | python3 -

cat >> ~/.zshrc <<EOF
export PATH="$HOME/.local/bin:$PATH"
EOF

# java
# sdkman
curl -s "https://get.sdkman.io" | bash

cat >> ~/.zshrc <<EOF
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
EOF

sdk list java
sdk install java 8.0.265-open
sdk default java 8.0.265-open

# sdk install java 11.0.12-open

# maven
# https://developer.aliyun.com/mvn/guide
sdk install maven
# ~/.m2/settings.xml
vim ~/.sdkman/candidates/maven/3.8.6/conf/settings.xml
#在<mirrors></mirrors>标签中添加 mirror 子节点
# <mirror>
#   <id>nexus-aliyun</id>
#   <mirrorOf>*</mirrorOf>
#   <name>Nexus aliyun</name>
#   <url>http://maven.aliyun.com/nexus/content/groups/public</url>
# </mirror>
<mirror>
  <id>aliyunmaven</id>
  <mirrorOf>*</mirrorOf>
  <name>阿里云公共仓库</name>
  <url>https://maven.aliyun.com/repository/public</url>
</mirror>

# gradle
sdk install gradle
# ~/.gradle/init.gradle
vim ~/.sdkman/candidates/gradle/7.5.1/init.d/init.gradle
allprojects{
    repositories {
        def ALIYUN_CENTRAL_URL = 'https://maven.aliyun.com/repository/central'
        def ALIYUN_JCENTER_URL = 'https://maven.aliyun.com/repository/public'
        def ALIYUN_GOOGLE_URL = 'https://maven.aliyun.com/repository/google'
        def ALIYUN_GRADLE_PLUGIN_URL = 'https://maven.aliyun.com/repository/gradle-plugin'
        def ALIYUN_SPRING_URL = 'https://maven.aliyun.com/repository/spring'
        def ALIYUN_SPRING_PLUGIN_URL = 'https://maven.aliyun.com/repository/spring-plugin'
        def ALIYUN_GRAILS_CORE_URL = 'https://maven.aliyun.com/repository/grails-core'
        def ALIYUN_APACHE_SNAPSHOT_URL = 'https://maven.aliyun.com/repository/apache-snapshots'

        all { ArtifactRepository repo ->
            if(repo instanceof MavenArtifactRepository){
                def url = repo.url.toString()
                if (url.startsWith('https://repo1.maven.org/maven2')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_CENTRAL_URL."
                    remove repo
                }
                if (url.startsWith('https://jcenter.bintray.com/')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_JCENTER_URL."
                    remove repo
                }
            }
        }
        maven {
            url ALIYUN_CENTRAL_URL
            url ALIYUN_JCENTER_URL
            url ALIYUN_GOOGLE_URL
            url ALIYUN_GRADLE_PLUGIN_URL
            url ALIYUN_SPRING_URL
            url ALIYUN_SPRING_PLUGIN_URL
            url ALIYUN_GRAILS_CORE_URL
            url ALIYUN_APACHE_SNAPSHOT_URL
        }
    }
}

# build.gradle
allprojects {
  repositories {
    maven {
      url 'https://maven.aliyun.com/repository/public/'
    }
    mavenLocal()
    mavenCentral()
  }
}


sdk install tomcat
# sdk install springboot

# sdk flush candidates
# sdk env init

# jenv
# git clone https://github.com/jenv/jenv.git ~/.jenv
# cat >> ~/.zshrc <<EOF
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"
# EOF

# php
# phpbrew
curl -L -O https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar
chmod +x phpbrew.phar

# Move the file to some directory within your $PATH
sudo mv phpbrew.phar /usr/local/bin/phpbrew

cat >> ~/.zshrc <<EOF
[[ -e $HOME/.phpbrew/bashrc ]] && source $HOME/.phpbrew/bashrc
EOF

phpbrew install 5.6 +default +fpm +mysql +gd
phpbrew list
phpbrew switch 5.6

# Android SDK
cat >> ~/.zshrc <<EOF
export ANDROID_HOME=/opt/android-sdk-linux
export ANDROID_SDK_ROOT=$ANDROID_HOME

export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/platforms:$PATH"
EOF


ANDROID_SDK_TOOLS_VERSION 8512546

# sdkmanager --list
# android list sdk --all
# android list sdk --extended --proxy-host mirrors.neusoft.edu.cn --proxy-port 80 -s
ANDROID_VERSION=30
ANDROID_BUILD_TOOLS_VERSION="30.0.3"
ANDROID_ARCHITECTURE="x86_64"

mkdir -p $HOME/.android
touch $HOME/.android/repositories.cfg
wget -q https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS_VERSION}_latest.zip -O android-sdk-tools.zip
sudo mkdir -p ${ANDROID_HOME}/cmdline-tools/
sudo unzip -q android-sdk-tools.zip -d ${ANDROID_HOME}/cmdline-tools/
sudo mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest
# sudo chown $USER: $ANDROID_HOME -R
rm android-sdk-tools.zip
yes | sdkmanager --licenses
yes | sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}"
yes | sdkmanager "platforms;android-${ANDROID_VERSION}"
yes | sdkmanager platform-tools
yes | sdkmanager emulator
yes | sdkmanager "system-images;android-${ANDROID_VERSION};google_apis_playstore;${ANDROID_ARCHITECTURE}"

# flutter
# fvm
cat >> ~/.zshrc <<EOF
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PATH="$HOME/.pub-cache/bin:$HOME/fvm/default/bin:$PATH"

# alias flutter="fvm flutter"
# alias dart="fvm dart"
EOF

wget https://github.com/fluttertools/fvm/releases/download/2.4.1/fvm-2.4.1-linux-x64.tar.gz

# install
brew tap leoafarias/fvm
brew install fvm

# uninstall
brew uninstall fvm
brew untap leoafarias/fvm

# fvm install 3.3.0
fvm install stable
fvm global stable

flutter config --no-analytics --enable-web
flutter precache
yes | flutter doctor --android-licenses
flutter doctor
flutter emulators --create
flutter update-packages

vim ~/fvm/versions/stable/packages/flutter_tools/gradle/flutter.gradle
buildscript {
    repositories {
        // google()
        // mavenCentral()
        maven { url 'https://maven.aliyun.com/nexus/content/repositories/google' }
        maven { url 'https://maven.aliyun.com/nexus/content/groups/public' }
    }
    dependencies {
        /* When bumping, also update ndkVersion above. */
        classpath 'com.android.tools.build:gradle:4.1.0'
    }
}
