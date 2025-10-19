@Library('my-shared-library') _

pipeline {

    agent any

    parameters {
        choice(
            name: 'action',
            choices: 'create\ndelete',
            description: 'Choose create/destroy'
        )
    }

    stages {

        stage('Git Checkout') {
            when { expression { params.action == 'create' } } // ✅ inside stage
            steps {
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


        stage('Integration Test maven') {
            when { expression { params.action == 'create' } } // ✅ inside stage
            steps {
                script {
                    mvnIntegrationTest()
                }
            }
        }
    }
}


    
        