![React Todo App](./banner.png)

# React Todo App.

## Steps to Run the Project

### 1. Create an EC2 Instance
- Launch an Ubuntu-based EC2 instance.
- Open the following ports in your security group:
  - Port 22 (SSH)
  - Port 8080 (Jenkins)
  - Port 80 (React App)

### 2. Install Docker on EC2
- Update packages:  
  `sudo apt update`
- Install Docker:  
  `sudo apt install docker.io -y`
- Enable and start Docker:  
  `sudo systemctl enable docker`  
  `sudo systemctl start docker`

### 3. Install Jenkins on EC2
- Add Jenkins key:  
  `curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc`
- Add Jenkins repository:  
  `echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list`
- Update packages:  
  `sudo apt update`
- Install Jenkins:  
  `sudo apt install jenkins -y`
- Enable and start Jenkins:  
  `sudo systemctl enable jenkins`  
  `sudo systemctl start jenkins`

### 4. Access Jenkins Web UI
- Open a browser at:  
  `http://<EC2_PUBLIC_IP>:8080`
- Retrieve the initial admin password:  
  `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`

### 5. Configure GitHub Integration in Jenkins
- Generate a GitHub Personal Access Token (classic).
- In Jenkins, go to **Manage Jenkins → Manage Credentials** and add the token as a Secret Text.
- Create a new Pipeline job in Jenkins using "Pipeline script from SCM" with your GitHub repo URL.
- In the job configuration, under **Build Triggers**, enable:  
  `GitHub hook trigger for GITScm polling`
- add the github url of the repo 
- save and build pipeline


### 6. Test the Deployment
- Verify that Jenkins build a pipeline and deploys the Docker container.
- Open your browser at:  
  `http://<EC2_PUBLIC_IP>:80`  
  to view the running React Todo App.