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
                    version = version.trim()
                    ipaddr = sh(returnStdout: true, script: 'ifconfig utun3 | awk \'$1 == "inet" {print $2}\'')
                    ipaddr = ipaddr.trim()
                }

                sh "docker build -t capstone-petclinic ."
                sh "docker tag capstone-petclinic ${ipaddr}:9002/capstone-petclinic:${version}"
                sh "docker push ${ipaddr}:9002/capstone-petclinic:${version}"


                build job: 'capstone-deploy', parameters: [string(name: 'artifactVersion', value: version), string(name: 'ipaddr', value: ipaddr)], wait: false
            }
        }
    }
}
