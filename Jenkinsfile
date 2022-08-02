pipeline {
    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: "4"))
    }

    stages {
        stage("PreCommit") {
            steps {
                sh "./mvnw clean compile"
                sh "./mvnw test"
            }
        }
        stage("Build") {
            when {
                branch "dev"
            }
            steps {
                sh "./mvnw clean package"
                sh "./mvnw deploy"

                script {
                    version = sh(returnStdout: true, script: './mvnw help:evaluate -Dexpression=project.version -q -DforceStdout')
                }

                build job: 'capstone-deploy', parameters: [string(name: 'artifactVersion', value: version')], wait: false
            }
        }
    }
}
