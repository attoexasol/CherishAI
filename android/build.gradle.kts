import com.android.build.gradle.LibraryExtension
import org.gradle.api.Action
import org.gradle.api.Project
import org.gradle.api.tasks.compile.JavaCompile
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Align JVM target to 17 and set namespace for plugin subprojects (e.g. share_plus). Register in beforeProject so it runs before any project is evaluated.
gradle.beforeProject(object : Action<Project> {
    override fun execute(proj: Project) {
        if (proj != proj.rootProject && proj.name != "app") {
            proj.afterEvaluate {
                proj.extensions.findByType(LibraryExtension::class.java)?.apply {
                    compileOptions?.apply {
                        sourceCompatibility = JavaVersion.VERSION_17
                        targetCompatibility = JavaVersion.VERSION_17
                    }
                    // Required by AGP 8+ for plugins that don't declare namespace (e.g. share_plus 4.x)
                    if (namespace == null || namespace!!.isEmpty()) {
                        when (proj.name) {
                            "share_plus" -> namespace = "dev.fluttercommunity.plus.share"
                            else -> { /* other plugins set here if needed */ }
                        }
                    }
                }
                proj.tasks.withType<KotlinCompile>().configureEach {
                    compilerOptions.jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
                }
            }
        }
    }
})

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
