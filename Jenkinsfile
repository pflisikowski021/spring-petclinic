pipeline {
    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: "5"))
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
            }
        }
    }
}
