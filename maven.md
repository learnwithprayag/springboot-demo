# Maven Build Tool – Short Note

**Apache Maven** is a **Java-based build automation and project management tool**. It simplifies **building, packaging, testing, and deploying Java applications**. Maven uses a **Project Object Model (POM)** file (`pom.xml`) to define project structure, dependencies, plugins, and build configuration.

---

## Key Concepts

| Term           | Description                                                                                                             |
| -------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **POM**        | Project Object Model XML file (`pom.xml`) containing project metadata, dependencies, and build instructions             |
| **Dependency** | External libraries required by the project                                                                              |
| **Repository** | Central place to store dependencies (local `.m2/repository`, remote repositories like Maven Central or GitHub Packages) |
| **Plugin**     | Maven extension for tasks like compiling, testing, packaging, deploying                                                 |
| **Goal**       | A specific task provided by a plugin (e.g., `compile`, `test`, `package`)                                               |

---

## Maven Build Life Cycle

Maven has **3 built-in life cycles**:

### A. **Default (Build) Life Cycle**

Used to **build and deploy the project**. Main phases:

| Phase      | Description                                                                                   |
| ---------- | --------------------------------------------------------------------------------------------- |
| `validate` | Check if project is correct and all necessary info is available                               |
| `compile`  | Compile the source code (`src/main/java`)                                                     |
| `test`     | Run unit tests (`src/test/java`) using **Surefire plugin**                                    |
| `package`  | Package compiled code into a JAR/WAR (`target/*.jar`)                                         |
| `verify`   | Run checks on results of integration tests to ensure quality                                  |
| `install`  | Install the packaged artifact into **local Maven repository** (`~/.m2/repository`)            |
| `deploy`   | Copy the final artifact to a **remote repository** for sharing with other developers/projects |

> **Example:** `mvn clean deploy` → cleans, builds, tests, packages, installs locally, and pushes to remote repo.

---

### B. **Clean Life Cycle**

Used to **clean project artifacts**.

| Phase        | Description                                    |
| ------------ | ---------------------------------------------- |
| `pre-clean`  | Pre-cleaning tasks                             |
| `clean`      | Remove `target/` directory and previous builds |
| `post-clean` | Post-cleaning tasks                            |

> **Example:** `mvn clean` → deletes `target/` folder.

---

### C. **Site Life Cycle**

Used to **generate project documentation**.

| Phase         | Description                                       |
| ------------- | ------------------------------------------------- |
| `pre-site`    | Tasks before generating site                      |
| `site`        | Generate site/documentation using project reports |
| `post-site`   | Post-site generation tasks                        |
| `site-deploy` | Publish generated site to remote server           |

> **Example:** `mvn site` → creates HTML documentation for the project.

---

## Common Maven Commands

| Command                  | Description                                     |
| ------------------------ | ----------------------------------------------- |
| `mvn compile`            | Compile source code                             |
| `mvn test`               | Run unit tests                                  |
| `mvn package`            | Build JAR/WAR                                   |
| `mvn install`            | Install artifact in local repository            |
| `mvn deploy`             | Deploy artifact to remote repository            |
| `mvn clean`              | Delete previous build artifacts                 |
| `mvn clean install`      | Clean + build + install locally                 |
| `mvn clean deploy`       | Full build + deploy to remote repo              |
| `mvn dependency:tree`    | Show project dependency tree                    |
| `mvn help:effective-pom` | Display the final POM with all inherited values |
| `mvn site`               | Generate project documentation                  |

---

## Summary

1. Maven uses **`pom.xml`** as the **project blueprint**.
2. It handles **dependencies, builds, tests, packaging, and deployment**.
3. Life cycles organize build process into **phases** (clean, default, site).
4. Commands are invoked via **`mvn <phase/goal>`**.

> Maven makes Java project builds **repeatable, consistent, and shareable**, which is essential for **DevOps pipelines**.


