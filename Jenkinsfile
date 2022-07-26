pipeline {
    agent { dockerfile true }
    stages {       
        stage('Deploy em homologacao') {
            steps {            
                ansiblePlaybook credentialsId: 'private-key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'hosts-app.yml', playbook: 'playbook-app-homolog.yml'                                    
            }
        }
        stage('Testes automatizados') {
            steps {
                sh 'echo PASSOU NO TESTE 1'
                sh 'echo PASSOU NO TESTE 2'
                sh 'echo PASSOU NO TESTE 3'
            }
        }
        // stage('Aprovacao do deploy') {
        //     steps {
              
        //     }
        // }
        stage('Deploy da aplicacao') {
            steps {            
                ansiblePlaybook credentialsId: 'private-key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'hosts-app.yml', playbook: 'playbook-app-prod.yml'                                    
            }
        }
        // stage('Notificacao no Slack') {
        //     steps {
              
        //     }
        // }    
    }
}