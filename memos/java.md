## Java

### install(manually)

Amazon Corretto

### multiple versions

`.zshenv`: 

```zsh
# display all envs:
# /usr/libexec/java_home -V

export JAVA_8_HOME='/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home'
export JAVA_17_HOME='/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home'

# switch java version functions, by change env
java8() {
    export JAVA_HOME=$JAVA_8_HOME
    export PATH=$(echo -n $PATH | sed 's/amazon-corretto-17.jdk/amazon-corretto-8.jdk/g')
}

java17() {
    export JAVA_HOME=$JAVA_17_HOME
    export PATH=$(echo -n $PATH | sed 's/amazon-corretto-8.jdk/amazon-corretto-17.jdk/g')
}

# default java8
export JAVA_HOME=$JAVA_8_HOME
export PATH=$JAVA_HOME/bin:$PATH
```

Also, [Coursier](https://get-coursier.io/) offers java version management ablity. It can be installed by Homebrew.

## Maven

### install

### envs

Refer: [](https://maven.apache.org/configure.html)

`.zshenv`: 
```zsh
# maven
export MAVEN_HOME='/Users/sherry/opt/apache-maven-3.9.0'
export MAVEN_OPTS='-Xms256m -Xmx512m -XX:MaxMetaSpaceSize=128m'
export PATH=$MAVEN_HOME'/bin':$PATH
```

### configs

[~/.m2/settings.xml](../assets/settings.xml)

#### plugin

Refresh archetype to local:

```zsh
curl https://repo.maven.apache.org/maven2/archetype-catalog.xml -o ~/.m2/archetype-catalog.xml
```

Refer: [archetype-catalog.html](https://maven.apache.org/archetype/maven-archetype-plugin/specification/archetype-catalog.html)

## Gradle

### install

### envs

`.zshenv`: 

```zsh
# gradle
export GRADLE_HOME='/Users/sherry/opt/gradle-7.6.1'
export GRADLE_USER_HOME='/Users/sherry/.gradle'
export PATH=$GRADLE_HOME'/bin':$PATH
```

### configs

[~/.gradle/init.gradle](../assets/init.gradle)
