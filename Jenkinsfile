#!/usr/bin/env groovy

pipeline {

    agent {
        kubernetes {
            cloud 'Kube mwdevel'
            label "storm-webdav-puppet-pod-${env.BUILD_NUMBER}"
            containerTemplate {
                name 'storm-webdav-puppet-runner'
                image "italiangrid/docker-rspec-puppet:ci"
                ttyEnabled true
                command 'cat'
            }
        }
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
        timeout(time: 1, unit: 'HOURS')
    }

    parameters {
        string(name: 'SONAR_PROJECT_VERSION', defaultValue: '0.1.0', description: 'Module version')
    }

    triggers { cron('@daily') }

    environment {
        SONAR_PROJECT_KEY = 'enricovianello_storm-pm'
        SONAR_PROJECT_NAME = 'storm-puppet-module'
    }

    stages {
        stage('Run') {
            steps {
                container('storm-webdav-puppet-runner') {
                    script {
                        checkout scm
                        sh 'bundle exec rake test | tee rake.log'
                        sh 'rspec spec/classes/*.rb --format html --out rspec_report.html'
                        sh 'rspec spec/classes/*.rb --format RspecJunitFormatter --out rspec_report.xml'
                        archiveArtifacts 'rspec_report.html,rspec_report.xml,rake.log'
                        junit 'rspec_report.xml'
                        withSonarQubeEnv{
                            def sonar_opts="-Dsonar.host.url=${SONAR_HOST_URL} -Dsonar.login=${SONAR_AUTH_TOKEN}"
                            def project_opts="-Dsonar.projectKey=${env.SONAR_PROJECT_KEY} -Dsonar.projectName='${env.SONAR_PROJECT_NAME}' -Dsonar.projectVersion=${params.SONAR_PROJECT_VERSION} -Dsonar.exclusions=spec/fixtures -Dsonar.sources=storm"
                            sh "sonar-runner ${sonar_opts} ${project_opts}"
                        }
                    }
                }
            }
        }
        stage('result') {
            steps {
                script {
                    currentBuild.result = 'SUCCESS'
                }
            }
        }
    }

    post {
        failure {
            slackSend color: 'danger', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} Failure (<${env.BUILD_URL}|Open>)"
        }
        unstable {
            slackSend color: 'warning', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} Unstable (<${env.BUILD_URL}|Open>)"
        }
        changed {
            script{
                if('SUCCESS'.equals(currentBuild.result)) {
                    slackSend color: 'good', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} Back to normal (<${env.BUILD_URL}|Open>)"
                }
            }
        }
    }
}
