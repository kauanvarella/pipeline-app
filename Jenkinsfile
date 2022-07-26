pipeline {
    agent { dockerfile true }
    stages {
        stage('Notificacao no Slack iniciando novo Deploy') {
            steps {
                slackSend (color: 'warning', message: '[ Em andamento ] Novo deploy iniciado em: http://34.211.224.42/', tokenCredentialId: 'slack-token')
            }
        }                
        stage('Deploy em homologacao') {
            steps {            
                ansiblePlaybook credentialsId: 'private-key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'hosts-app-homolog.yml', playbook: 'playbook-app.yml'                                    
            }
        }
        stage('Testes automatizados') {
            steps {
                sh 'echo PASSOU NO TESTE 1'
                sh 'echo PASSOU NO TESTE 2'
                sh 'echo PASSOU NO TESTE 3'
            }
        }
        stage('Aprovacao do deploy em producao') {
            steps {
                script {
                    timeout(time: 10, unit: 'MINUTES') {
                        input(id: "Deploy Gate", message: "Fazer o deploy em produção?", ok: 'Deploy')
                    }
                }
            }
        }
        stage('Deploy em producao') {
            steps {
                script {
                    try {
                        ansiblePlaybook credentialsId: 'private-key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'hosts-app-prod.yml', playbook: 'playbook-app.yml' 
                    } catch (e){
                        slackSend (color: 'danger', message: "[ FALHA ] Falha no deploy em: http://34.211.224.42/", tokenCredentialId: 'slack-token')
                        error('Interrompendo a Pipeline')
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