pipeline {
    agent any
    
    tools {
        // Install the Maven version configured as "Maven3" in Jenkins Global Tool Configuration
        maven "Maven-3.9"
    }
    
    environment {
        // Detect OS and set appropriate command
        IS_WINDOWS = "${isUnix() ? 'false' : 'true'}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Get code from GitHub repository
                git branch: 'master',
                    url: 'https://github.com/Dj-pages/simple-java-maven-app.git'
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building the application...'
                script {
                    if (isUnix()) {
                        sh 'mvn clean compile'
                    } else {
                        bat 'mvn clean compile'
                    }
                }
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
                script {
                    if (isUnix()) {
                        sh 'mvn test'
                    } else {
                        bat 'mvn test'
                    }
                }
            }
            post {
                always {
                    // Publish JUnit test results
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        
        stage('Package') {
            steps {
                echo 'Packaging the application...'
                script {
                    if (isUnix()) {
                        sh 'mvn package -DskipTests'
                    } else {
                        bat 'mvn package -DskipTests'
                    }
                }
            }
        }
        
        stage('Archive Artifacts') {
            steps {
                echo 'Archiving artifacts...'
                // Archive the built artifacts
                archiveArtifacts artifacts: 'target/*.jar', 
                                 fingerprint: true
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                script {
                    if (isUnix()) {
                        sh '''
                            echo "Application built successfully!"
                            echo "JAR file location: target/*.jar"
                        '''
                    } else {
                        bat '''
                            echo Application built successfully!
                            echo JAR file location: target/*.jar
                        '''
                    }
                }
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline execution failed!'
        }
        always {
            // Clean workspace after build
            cleanWs()
        }
    }
}