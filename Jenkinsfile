properties([parameters([choice(choices: 'master\nfeature-1\nfeature-2', description: 'Select Branch to build', name: 'branch')])])

node{
    stage('Scm Checkout'){
        echo "Pulling changes from the branch ${params.branch}"
        git url: 'https://github.com/gopigl/RBI1', branch: "${params.branch}"
    }
    
   stage('Compile-Package'){
      // Get maven home path
      def mvnHome =  tool name: 'maven-3', type: 'maven'   
      sh "${mvnHome}/bin/mvn clean package"
   }
   
   stage('SonarQube Analysis') {
        def mvnHome =  tool name: 'maven-3', type: 'maven'
        withSonarQubeEnv('Sonar') { 
          sh "${mvnHome}/bin/mvn sonar:sonar"
        }
    }
   stage("Quality gate") {
            steps {
                waitForQualityGate abortPipeline: true
            }
   }
   
  
   stage('Deploy to Tomcat'){
      
      sshagent(['tomcat-dev']) {
         sh 'scp -o StrictHostKeyChecking=no target/*.war ubuntu@54.226.255.47:/etc/tomcat8/'
      }
   }
   
   

}
