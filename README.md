# SpringBoot Application Demo

Steps we’ll cover:

* Create a Spring Boot project
* Build a JAR artifact
* Configure Maven for GitHub Packages
* Deploy artifact to GitHub Packages

All commands are **CLI-first**, using `mkdir`, `cat >> EOF`, `export`, etc.

---

## Create the project

```bash
mkdir -p springboot-demo/src/main/java/com/example/demo
mkdir -p springboot-demo/src/main/resources
cd springboot-demo
```

---

## Create `pom.xml`

```bash
cat >> pom.xml <<'EOF'
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <!-- GitHub Packages compatible groupId -->
    <groupId>io.github.learnwithprayag</groupId>
    <artifactId>springboot-demo</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>

    <name>springboot-demo</name>
    <description>Spring Boot app for GitHub Packages</description>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.3.4</version>
        <relativePath/>
    </parent>

    <properties>
        <java.version>17</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    </dependencies>

    <repositories>
        <repository>
            <id>github</id>
            <name>GitHub Packages</name>
            <url>https://maven.pkg.github.com/learnwithprayag/springboot-demo</url>
        </repository>
    </repositories>

    <distributionManagement>
        <repository>
            <id>github</id>
            <name>GitHub Packages</name>
            <url>https://maven.pkg.github.com/learnwithprayag/springboot-demo</url>
        </repository>
    </distributionManagement>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

</project>
EOF
```

---

## Create main Java app

```bash
cat >> src/main/java/com/example/demo/DemoApplication.java <<'EOF'
package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class DemoApplication {

    @GetMapping("/")
    public String home() {
        return "Hello from Spring Boot Maven Demo!";
    }

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }
}
EOF
```

---

## Create application properties

```bash
cat >> src/main/resources/application.properties <<'EOF'
server.port=8080
EOF
```

---

## Configure Maven `settings.xml`

```bash
mkdir -p ~/.m2
cat >> ~/.m2/settings.xml <<'EOF'
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                              https://maven.apache.org/xsd/settings-1.0.0.xsd">

  <servers>
    <server>
      <id>github</id>
      <username>learnwithprayag</username>
      <password>${env.GITHUB_TOKEN}</password>
    </server>
  </servers>

</settings>
EOF
```

---

## Export GitHub Token

Generate a **Personal Access Token** (PAT) from GitHub with scopes:

* `write:packages`, `read:packages`, `repo` (for private repo)

Then:

```bash
export GITHUB_TOKEN=ghp_XXXXXXXXXXXXXXXXXXXX
```

---

## Build & Deploy artifact

```bash
# Clean and package JAR
mvn clean package

# Deploy to GitHub Packages
mvn deploy -s ~/.m2/settings.xml
```

If successful, you’ll see uploads like:

```
Uploading to github: https://maven.pkg.github.com/learnwithprayag/springboot-demo/io/github/learnwithprayag/springboot-demo/1.0.0/springboot-demo-1.0.0.jar
BUILD SUCCESS
```

---

## Verify in GitHub UI

1. Go to your repo → **Packages** tab
2. Your artifact `springboot-demo:1.0.0` should appear

---

## Use artifact in another project

```xml
<dependency>
    <groupId>io.github.learnwithprayag</groupId>
    <artifactId>springboot-demo</artifactId>
    <version>1.0.0</version>
</dependency>
```

And in the `<repositories>` block:

```xml
<repository>
    <id>github</id>
    <name>GitHub Packages</name>
    <url>https://maven.pkg.github.com/learnwithprayag/springboot-demo</url>
</repository>
```

---

## Summary Table

| Step | Description     | Command                                                 |
| ---- | --------------- | ------------------------------------------------------- |
| 1–4  | Create app      | `mkdir`, `cat >> EOF`                                   |
| 5    | Configure Maven | `cat >> ~/.m2/settings.xml`                             |
| 6    | Export token    | `export GITHUB_TOKEN=ghp_XXXXX`                         |
| 7    | Build & deploy  | `mvn clean package && mvn deploy -s ~/.m2/settings.xml` |
| 8    | Verify artifact | GitHub Packages tab                                     |
| 9    | Use artifact    | Add `<dependency>` + `<repository>` in POM              |

---

### How to check the image

1. **Go to your user’s packages page**:

```
https://github.com/users/learnwithprayag/packages
```

Here you’ll see all GHCR images you’ve pushed.

2. **Click the image** to see tags (`1.0.0`, `2.0.0`, etc.) and pull commands.

---

### Important GHCR notes

* Make sure the repository is linked correctly: image name should be:

```
ghcr.io/<USERNAME>/<REPO>:<TAG>
```

* If you push with the correct repo/user namespace, it will appear under your **account packages**, not necessarily under the repo “Packages” tab.
* You can also see it via CLI:

```bash
docker pull ghcr.io/learnwithprayag/springboot-demo:1.0.0
```

If it pulls successfully, the image exists in GHCR.



