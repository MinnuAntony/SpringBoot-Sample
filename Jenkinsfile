@Library('my-shared-library') _

pipeline {

    agent any

    parameters{

        choice(
            name: 'action',
            choices: 'create\ndelete',
            description: 'Choose create/destroy'
        )
    }

    stages{

        when { expression { params.action == 'create' } }
        
        stage('Git Checkout') {

            steps{
                gitCheckout(
                branch: "main",
                url: "https://github.com/MinnuAntony/SpringBoot-Sample"
                )
            }           
        }

        // stage('Unit Test maven'){

        //     when { expression { params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            mvnTest()
        //        }
        //     }
        // }

        stage('Integration Test maven'){

            when { expression { params.action == 'create' } }

            steps{
               script{
                   
                   mvnIntegrationTest()
               }
            }
        }
    }
}
   