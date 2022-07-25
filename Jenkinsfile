pipeline {
    agent { dockerfile true }
    stages {       
        stage('Deploy da aplicacao') {
            steps {
                sh 'chmod 600 ssh-prod-meuapp.pem'                
                ansiblePlaybook credentialsId: 'private-key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'hosts.yml', playbook: 'playbook.yml'                                    
            }
        }
        // stage('Teste2') {
        //     steps {
              
        //     }
        // }
        // Subir no ambiente de homolog, testar e depois subir para prod    
    }
}