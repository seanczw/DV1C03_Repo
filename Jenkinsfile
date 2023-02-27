pipeline {


 environment {
    registry = "sczw/22051107_webimage"
    dockerImage = ""
    
  }


    agent any
  
    stages {
        
     stage('Stage 1_22051107') {
          steps {
                echo "S1_22051107 : Environment Preparation Completed"
         	}
        } 
        
        
        stage('Stage 2_22051107') {
            steps {
                script {
                  dockerImage = docker.build registry + ":$BUILD_NUMBER"
                
                   }
		    
		sh "docker-compose down  "
  	  	sh "docker-compose up -d  "
		 

                 echo "S2_22051107 : Web Server Creation Completed"
            }
        }
        stage('Stage Parallel') {
                parallel {
                stage('Stage 3_22051107') {
                    steps {

                        echo "S3_22051107 : API Test Completed"
                    }
                }
                stage('Stage 4_22051107') {
                    steps {

                        echo "S4_22051107 : DAST Security Test Completed"
                    }
                }
               } 
        
        }
        stage('Stage 5_22051107') {
            input {
                message "Do you want to release the work?"
                ok "Yes"
            }
	    
	       environment {
               registryCredential = 'dockerhublogin'
             }
            
              steps {
                 echo "Yes Selected"
		 
		     script {
               docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
               dockerImage.push("latest")
             
                }
		
		 echo "Work Released - 22051107"
            } 
		 
                }
        }
        stage('Stage 6_22051107') {
     
             
            steps {
         
	       sh "docker-compose down  "
		echo "Stage 6 - 22051107 - Stop docker container"
              
            }
        }
        
            stage('Stage 7_22051107') {
         	 steps {
                script {
                    kubernetesDeploy(configs: "myweb.yaml", kubeconfigId: "mykubeconfig")
                    }
        		  echo "Stage 7 - 22051107 Creating deployment to kubernetes"
      	 	}  
       	}

    }   
    
}
