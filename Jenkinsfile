#!groovy

node {
    def deployable_branches = ["master"]
    if (deployable_branches.contains(env.BRANCH_NAME)) {
        env.DOCKER_USE_HUB = 1
    }

    stage('Checkout') {
        checkout scm
    }

    stage('Publish docker image') {
        withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerbot',
                          usernameVariable: 'DOCKER_USERNAME',
                          passwordVariable: 'DOCKER_PASSWORD']]) {
            wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm']) {
                sh './build.sh'
            }
        }
    }
}
