import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.1.0") // Pastikan versi sesuai
        classpath("com.google.gms:google-services:4.3.10") // Plugin Google Services
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Konfigurasi ulang lokasi folder build agar lebih terorganisir
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build")
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.map { it.dir(project.name) }
    project.layout.buildDirectory.set(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// Task untuk membersihkan build directory
tasks.register("clean", Delete::class) {
    delete(rootProject.layout.buildDirectory)
}
