pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'kranthi6166'
        DOCKER_IMAGE = 'indie_gems_portal'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Naveen1-6/Indie_Gems_Portal.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                        docker build -t ${DOCKER_HUB_USER}/${DOCKER_IMAGE}:${DOCKER_TAG} .
                    """
                }
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials', // Jenkins stored credentials
                    usernameVariable: 'USERNAME',
                    passwordVariable: 'PASSWORD'
                )]) {
                    sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push ${DOCKER_HUB_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
        }

        stage('Deploy to Docker Swarm') {
            steps {
                script {
                    sh """
                        docker service update --image ${DOCKER_HUB_USER}/${DOCKER_IMAGE}:${DOCKER_TAG} indie_gems_service || \
                        docker service create --name indie_gems_service -p 8080:8080 ${DOCKER_HUB_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
        }
    }

~
~
~
~
~

