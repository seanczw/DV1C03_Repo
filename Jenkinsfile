pipeline {


 environment {
    dockerimagename = "sczw/22051107_webimage"
    dockerImage = ""
    DOCKER_LOGIN = credentials('dockerhublogin')
    
  }


    agent {
        node {
            label 'master'
        }
    }
  
    stages {
        
     stage('Stage 1_22051107') {
          steps {
                echo "S1_22051107 : Environment Preparation Completed"
         	}
        } 
        
        
        stage('Stage 2_22051107') {
            steps {
                script {
                  dockerImage = docker.build dockerimagename 
                
                   }
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
	    
	       
            
              steps {
                 echo "Yes Selected"
		 
		     script {
               docker.withRegistry( 'https://registry.hub.docker.com', DOCKER_LOGIN ) {
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
		   container('kubectl') {
			
			withCredentials([file(credentialsId: 'config6', variable: 'KUBECONFIG')])
			{
			 
			 
			 try
 			 {               
   				    sh "kubectl delete -n default deployment 22051107-svr"
				    sh  "kubectl delete -n default service apache"
		                    sh "kubectl create -f deployment.yaml"
				    echo "Down previous deployment and continue with new deployment . . ."
                   	  }
                 	   catch (Exception e) {
			 		 sh "kubectl create -f deployment.yaml"	 
					 echo "No deployment has been done before , continue to deploy . . ."
		   	  }   
			 
			 
    			
			 
			 
			 
			 
			 
			}
		}	
        		  echo "Stage 7 - 22051107 Creating deployment to kubernetes"
      	 	}  
       	}

    }   
    post {
    	always {
	
		script {
		
              		sh "docker-compose down  "
			 	
                }
	}
    }
}
