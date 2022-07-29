pipeline {
    agent any

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
                build job: 'capstone-deploy', parameters: [string(name: 'artifactVersion', value:'test')], wait: false
            }
        }
    }
}
