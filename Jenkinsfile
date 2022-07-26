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
        stage('Aprovacao do deploy') {
            steps {
                script {
                    timeout(time: 10, unit: 'MINUTES') {
                        input(id: "Deploy Gate", message: "Fazer o deploy em produção?", ok: 'Deploy')
                    }
                }
            }
        }
        stage('Deploy da aplicacao') {
            steps {
                script {
                    try {
                        ansiblePlaybook credentialsId: 'private-key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'hosts-app.yml', playbook: 'playbook-app-prod.yml' 
                    } catch (Exception e) {
                        slackSend (color: 'error', message: "[ FALHA ] Falha no deploy em http://34.211.224.42/ em ${currentBuild.duration}s", tokenCredentialId: 'slack-token')
                        currentBuild.result = 'ABORTED'
                    }                       
                }                                                    
            }
        }
        stage('Notificacao no Slack') {
            steps {
                slackSend (color: 'good', message: '[ Sucesso ] Desploy com sucesso, disponivel em: http://34.211.224.42/ ', tokenCredentialId: 'slack-token')
            }
        }    
    }
}