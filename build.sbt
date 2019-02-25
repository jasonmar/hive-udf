/*
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

name := "udf"

version := "0.1.0"

scalaVersion := "2.11.11"

val exPentaho = ExclusionRule(organization="org.pentaho", name="pentaho-aggdesigner-algorithm")
val exLog4j = ExclusionRule(organization="log4j", name="log4j")
val exLog4jEx = ExclusionRule(organization="log4j", name="apache-log4j-extras")

libraryDependencies += "org.apache.hive" % "hive-serde" % "2.3.4" % "provided" excludeAll(exPentaho, exLog4j, exLog4jEx)

libraryDependencies += "org.apache.hive" % "hive-exec" % "2.3.4" % "provided" excludeAll(exPentaho, exLog4j, exLog4jEx)
