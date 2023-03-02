# DV1C03_Repo
console log 
```
Started by an SCM change
Obtained 22051107_Jenkinsfile from git https://github.com/seanczw/DV1C03_Repo.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/test
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential githublogin
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/test/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/seanczw/DV1C03_Repo.git # timeout=10
Fetching upstream changes from https://github.com/seanczw/DV1C03_Repo.git
 > git --version # timeout=10
 > git --version # 'git version 2.17.1'
using GIT_ASKPASS to set credentials 
 > git fetch --tags --progress -- https://github.com/seanczw/DV1C03_Repo.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/test^{commit} # timeout=10
Checking out Revision 7451ab714504b82b2536b7dbe5aae2104e554816 (refs/remotes/origin/test)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 7451ab714504b82b2536b7dbe5aae2104e554816 # timeout=10
Commit message: "Update README.md"
 > git rev-list --no-walk 0599fd1e6d548c1facbfd9290d8fd03bc89590a6 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Stage 1_22051107)
[Pipeline] echo
S1_22051107 : Environment Preparation Completed
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Stage 2_22051107)
[Pipeline] script
[Pipeline] {
[Pipeline] isUnix
[Pipeline] withEnv
[Pipeline] {
[Pipeline] sh
+ docker build -t sczw/22051107_webimage:25 .
DEPRECATED: The legacy builder is deprecated and will be removed in a future release.
            Install the buildx component to build images with BuildKit:
            https://docs.docker.com/go/buildx/

Sending build context to Docker daemon  293.4kB

Step 1/6 : From ubuntu:18.04
 ---> 5a214d77f5d7
Step 2/6 : RUN apt update
 ---> Using cache
 ---> 1ca03ed637a0
Step 3/6 : RUN apt-get install -y apache2
 ---> Using cache
 ---> 24c4cffbcdfc
Step 4/6 : RUN apt clean
 ---> Using cache
 ---> dfc51392f308
Step 5/6 : EXPOSE 80
 ---> Using cache
 ---> a1a9cf5ee5ab
Step 6/6 : CMD ["apache2ctl","-D","FOREGROUND"]
 ---> Using cache
 ---> f679b4d26bfc
Successfully built f679b4d26bfc
Successfully tagged sczw/22051107_webimage:25
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // script
[Pipeline] sh
+ docker-compose down
Removing 22051107_Server ... 
[1A[2K
Removing 22051107_Server ... [32mdone[0m
[1BRemoving network test_default
[Pipeline] sh
+ docker-compose up -d
Creating network "test_default" with the default driver
Creating 22051107_Server ... 
Creating 22051107_Server
[1A[2K
Creating 22051107_Server ... [32mdone[0m
[1B
[Pipeline] echo
S2_22051107 : Web Server Creation Completed
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Stage Parallel)
[Pipeline] parallel
[Pipeline] { (Branch: Stage 3_22051107)
[Pipeline] { (Branch: Stage 4_22051107)
[Pipeline] stage
[Pipeline] { (Stage 3_22051107)
[Pipeline] stage
[Pipeline] { (Stage 4_22051107)
[Pipeline] echo
S3_22051107 : API Test Completed
[Pipeline] }
[Pipeline] echo
S4_22051107 : DAST Security Test Completed
[Pipeline] }
[Pipeline] // stage
[Pipeline] // stage
[Pipeline] }
[Pipeline] }
[Pipeline] // parallel
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Stage 5_22051107)
[Pipeline] input
Do you want to release the work?
Yes or Abort
Approved by jadmin
[Pipeline] withEnv
[Pipeline] {
[Pipeline] echo
Yes Selected
[Pipeline] script
[Pipeline] {
[Pipeline] withEnv
[Pipeline] {
[Pipeline] withDockerRegistry
$ docker login -u sczw -p ******** https://registry.hub.docker.com
WARNING! Using --password via the CLI is insecure. Use --password-stdin.
WARNING! Your password will be stored unencrypted in /var/lib/jenkins/workspace/test@tmp/ffb12be7-53bf-40df-95b6-922615d74fa0/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
[Pipeline] {
[Pipeline] isUnix
[Pipeline] withEnv
[Pipeline] {
[Pipeline] sh
+ docker tag sczw/22051107_webimage:25 registry.hub.docker.com/sczw/22051107_webimage:latest
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] isUnix
[Pipeline] withEnv
[Pipeline] {
[Pipeline] sh
+ docker push registry.hub.docker.com/sczw/22051107_webimage:latest
The push refers to repository [registry.hub.docker.com/sczw/22051107_webimage]
15474a7151f4: Preparing
89a86f376272: Preparing
fd694b06fc13: Preparing
824bf068fd3d: Preparing
89a86f376272: Layer already exists
fd694b06fc13: Layer already exists
824bf068fd3d: Layer already exists
15474a7151f4: Layer already exists
latest: digest: sha256:ee3cef7d96bd93dd054fddec63dc32593eb7cbd9b9540c026575598e2c03aaa3 size: 1160
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // withDockerRegistry
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Stage 6_22051107)
[Pipeline] echo
Stage 6 - Work Released - 22051107
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Stage 7_22051107)
[Pipeline] script
[Pipeline] {
[Pipeline] withKubeConfig
[Pipeline] {
[Pipeline] sh
+ kubectl delete -n default deployment 22051107-svr
deployment.apps "22051107-svr" deleted
[Pipeline] sh
+ kubectl delete -n default service apache
service "apache" deleted
[Pipeline] sh
+ kubectl create -f deployment.yaml
deployment.apps/22051107-svr created
service/apache created
[Pipeline] echo
Shut down previous deployment and created new deployment
[Pipeline] }
[kubernetes-cli] kubectl configuration cleaned up
[Pipeline] // withKubeConfig
[Pipeline] }
[Pipeline] // script
[Pipeline] echo
Stage 7 - 22051107 Deployed to kubernetes
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```
