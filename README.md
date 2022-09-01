# sql-times  

This repo has code for a blog post about aggregating time series (aka *downsampling*) with SQL. Link to the blog post: https://canovasjm.netlify.app/2022/09/18/downsample-time-series-in-sql/  

## To reproduce the example:  

1. Clone the repo: `git clone https://github.com/canovasjm/sql-times.git`  

2. Open a terminal and `cd` into the cloned repo  

3. Type: `docker-compose up -d`  

4. Open your web browser and in the navigation bar type: `http://localhost:8080`  

5. Log into pgAdmin with the following credentials (you can specify different credentials in the `docker-compose.yaml` file):  
    user: `admin@admin.com`  
    password: `admin`  

6. Create a server

7. Log into Postgres SQL with the following credentials (you can specify different credentials in the `docker-compose.yaml` file):  
    POSTGRES_USER: `root`  
    POSTGRES_PASSWORD: `root`  

8. Once you have finished, go back to the terminal and type `docker-compose down`     

**A word of caution**: in the `docker-compose.yaml` file and in steps 5) and 7) we are hardcoding credentials. Even though this is not a good practice, and we should avoid it by all means, here we are dealing with an example and make up data.