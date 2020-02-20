# Terraform

Terraform is an orchestration tool, which will deploy AMI's into the cloud.

It can use many providers and use different types of images and or provisioning.

In our stack:
- Chef - configuration management
- Packer - creates immutable images of our machines
- Terraform - will setup infrastructure in the code

## testing load balancing
```
sudo apt-get update
cd /var/www/html
sudo mkdir test
cd test
sudo vi index.html
```
copy and paste following code in index.html file
```
<html>
  <head>
      <title> Server 1 </title>  
  </head>
  <body>
        <h1> <center> This is the test for eu-west-1a </center></h1>    
  </body>
</html>
```
save changes with
```
:w :q
```
to start app
```
cd /home/ubuntu/appjs
sudo npm install ejs express mongoose
export DB_HOST=mongodb://${db-ip}:27017/posts
node seeds/seed.js
node app.js
```
