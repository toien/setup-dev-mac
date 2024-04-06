
# Java
export JAVA_8_HOME='/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home'
export JAVA_11_HOME='/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home'
export JAVA_17_HOME='/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home'

# switch java version functions, by change env
java8() {
    export JAVA_HOME=$JAVA_8_HOME
    export PATH=$(echo -n $PATH | sed -E 's/[0-9]+\.jdk/8.jdk/g')
}

java11() {
    export JAVA_HOME=$JAVA_11_HOME
    export PATH=$(echo -n $PATH | sed -E 's/[0-9]+\.jdk/11.jdk/g')
}

java17() {
    export JAVA_HOME=$JAVA_17_HOME
    export PATH=$(echo -n $PATH | sed -E 's/[0-9]+\.jdk/17.jdk/g')
}

# default java8
export JAVA_HOME=$JAVA_8_HOME
export PATH=$JAVA_HOME/bin:$PATH

# Gradle
export GRADLE_HOME=$HOME/opt/gradle-7.6.2
export GRADLE_USER_HOME=$HOME/.gradle
export GRADLE_OPTS='-Xms256m -Xmx1048m'
export PATH=$GRADLE_HOME/bin:$PATH

# Maven
export M2_HOME=$HOME/opt/apache-maven-3.9.1
export MAVEN_OPTS="-Xms256m -Xmx1048m"
export PATH=$M2_HOME/bin:$PATH

# Scala
export COURSIER_REPOSITORIES="https://maven.aliyun.com/nexus/content/repositories/central/|central|sonatype:releases|jitpack"
# >>> coursier install directory >>>
export PATH="$PATH:$HOME/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<

# Go
# 配置 GOPROXY 环境变量
# export GOPROXY=https://proxy.golang.com.cn,direct
# 还可以设置不走 proxy 的私有仓库或组，多个用逗号相隔（可选）
# export GOPRIVATE=gitlab.huanfueu.com,github.com/my/private

# FNM
export FNM_NODE_DIST_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/

# Yarnpkg
export PATH="$PATH:$HOME/.yarn/bin"

# ossutil
export PATH=$HOME/opt/ossutil-v1.7.15-mac-arm64:$PATH

# Android sdk
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_HOME/emulator:$PATH

# Go
export PATH=$HOME/go/bin:$PATH

# Flutter
export PATH=$HOME/opt/flutter/bin:$PATH

# gcloud
export PATH=$HOME/opt/google-cloud-sdk/bin:$PATH
export CLOUDSDK_PYTHON=$HOME/.pyenv/versions/3.9.16/bin/python3
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# hadoop
export HADOOP_HOME=$HOME/opt/hadoop-3.3.6
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

export HADOOP_CONFIG_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_CLASSPATH=`$HADOOP_HOME/bin/hadoop classpath`

export YARN_CONFIG_DIR=$HADOOP_HOME/etc/hadoop

# hive
export HIVE_HOME=$HOME/opt/apache-hive-2.3.9-bin
export PATH=$HIVE_HOME/bin:$PATH

export HIVE_CONFIG_DIR=$HIVE_HOME/conf

# spark
export SPARK_HOME=$HOME/opt/spark-3.5.0-bin-hadoop3
export PATH=$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH

export PYSPARK_DRIVER_PYTHON=$HOME/.pyenv/versions/pyspark/bin/python
export PYSPARK_PYTHON=$HOME/.pyenv/versions/pyspark/bin/python
