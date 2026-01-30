ThisBuild / version := "1.0"
ThisBuild / scalaVersion := "2.12.21"
ThisBuild / organization := ""

val spinalVersion = "1.13.0"
val spinalCore = "com.github.spinalhdl" %% "spinalhdl-core" % spinalVersion
val spinalLib = "com.github.spinalhdl" %% "spinalhdl-lib" % spinalVersion
val spinalIdslPlugin = compilerPlugin("com.github.spinalhdl" %% "spinalhdl-idsl-plugin" % spinalVersion)

lazy val fpga = (project in file("."))
  .settings(
    Compile / scalaSource := baseDirectory.value,
    libraryDependencies ++= Seq(spinalCore, spinalLib, spinalIdslPlugin),
  )

fork := true
