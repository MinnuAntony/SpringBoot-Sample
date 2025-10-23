@Library('my-shared-library') _

pipeline{

    agent any

    parameters{

        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
        string(name: 'ImageName', description: "name of the docker build", defaultValue: 'javaapp')
        string(name: 'ImageTag', description: "tag of the docker build", defaultValue: 'v1')
        string(name: 'DockerHubUser', description: "docker hub username", defaultValue: 'minnuantony')
    }

    stages{
         
        stage('Git Checkout'){
                    when { expression {  params.action == 'create' } }
            steps{
            gitCheckout(
                branch: "main",
                url: "https://github.com/MinnuAntony/SpringBoot-Sample"
            )
            }
        }
         stage('Unit Test maven'){
         
         when { expression {  params.action == 'create' } }

            steps{
               script{
                   
                   mvnTest()
               }
            }
        }
         stage('Integration Test maven'){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                   
                   mvnIntegrationTest()
               }
            }
        }

        stage('Static code analysis: Sonarqube'){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                   
                   def SonarQubecredentialsId = 'sonar-api-new4'
                   staticCodeAnalysis(SonarQubecredentialsId)
               }
            }
        }

        stage('Quality Gate Status Check : Sonarqube'){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                   
                   def SonarQubecredentialsId = 'sonar-api-new4'
                   qualityGateStatus(SonarQubecredentialsId)
               }
            }
        }
        stage('Maven Build : maven'){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                   
                   mvnBuild()
               }
            }
        }

        stage('Docker Build'){
            when { expression { params.action == 'create' } }
            steps{
                script{
                    def imageName = params.ImageName
                    def imageTag = params.ImageTag
                    def dockerHubUser = params.DockerHubUser
                    dockerBuild(imageName, imageTag, dockerHubUser)
                }
            }
        }

        stage('Docker Image Scan - Trivy'){
            when { expression { params.action == 'create' } }
            steps{
                script{
                    def imageName = params.ImageName
                    def imageTag = params.ImageTag
                    def dockerHubUser = params.DockerHubUser
                    dockerImageScan(imageName, imageTag, dockerHubUser)
                }
            }
        }
        stage('Docker Image Push'){
            when { expression { params.action == 'create' } }
            steps{
                script{
                    def imageName = params.ImageName
                    def imageTag = params.ImageTag
                    def dockerHubUser = params.DockerHubUser
                    dockerImagePush(imageName, imageTag, dockerHubUser)
                }
            }
        }

        stage('Docker Image Cleanup'){
            when { expression { params.action == 'create' } }
            steps{
                script{
                    def imageName = params.ImageName
                    def imageTag = params.ImageTag
                    def dockerHubUser = params.DockerHubUser
                    dockerImageClean(imageName, imageTag, dockerHubUser)
                }
            }
        }
          
    }
}