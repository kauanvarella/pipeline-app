pipeline {
    agent { dockerfile true }
    stages {       
        stage('Deploy em homologacao') {
            steps {
                sh 'chmod 600 ssh-prod-meuapp.pem'                
                ansiblePlaybook credentialsId: 'private-key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'hosts.yml', playbook: 'playbook-homolog.yml'                                    
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
                ansiblePlaybook credentialsId: 'private-key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'hosts.yml', playbook: 'playbook-prod.yml'                                    
            }
        }    
    }
}