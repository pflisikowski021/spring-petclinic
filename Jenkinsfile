pipeline {
    agent any

    stages {
        stage("PreCommit") {
            steps {
                sh "mvn clean compile"
                sh "mvn test"
            }
        }
        stage("Build") {
            when {
                branch "dev"
            }
            steps {
                sh "mvn clean package"
            }
        }
    }
}
