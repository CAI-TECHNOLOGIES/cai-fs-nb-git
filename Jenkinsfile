pipeline {
    agent {
        label 'k8agent'
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Clone repository') {
            steps {
                script {
                    container('build-agent') {
                        checkout scm
                    }
                }
            }
        }
        stage('Build docker image') {
            steps {
                script {
                    container('build-agent') {
                        app = docker.build('lib')
                    }
                }
            }
        }
        stage('Store files') {
            steps {
                script {
                    container('build-agent') {
                        app.withRun("-v $PWD/dist:/cai-fs-nb-git/dist"){ c ->
                            sh 'cp -r $PWD/dist /base/builds'
                        }
                    }
                }
            }
        }
    }
}
