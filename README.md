# sql-times  

This repo has code for a blog post about aggregating time series (aka *downsampling*) with SQL. Link to the blog post:   
https://canovasjm.netlify.app/2022/09/18/downsample-time-series-in-sql/  

## To reproduce the example:  

1. Clone the repo: `git clone https://github.com/canovasjm/sql-times.git`  

2. Open a terminal and `cd` into the cloned repo  

3. Type: `docker-compose up -d`  

4. Open your web browser and in the navigation bar type: `http://localhost:8080`  

5. Log into pgAdmin with the following credentials (you can specify different credentials in the `docker-compose.yaml` file):   
    user: `admin@admin.com`  
    password: `root`  

![image](https://user-images.githubusercontent.com/19241669/191152172-d6b608d4-fdaa-4aa5-be20-24e339d4f907.png)

6. Create a server

![image](https://user-images.githubusercontent.com/19241669/191152571-65e7caf3-fe22-4ed3-be30-6acf5b3abeb7.png)

7. Log into Postgres SQL with the following credentials (you can specify different credentials in the `docker-compose.yaml` file):  
    POSTGRES_USER: `root`  
    POSTGRES_PASSWORD: `root`   
    POSTGRES_DB=`sql_times`

![image](https://user-images.githubusercontent.com/19241669/191152810-548583f0-29eb-4d62-8c9f-b0e437ec031d.png)  

![image](https://user-images.githubusercontent.com/19241669/191153021-7399fa6e-997b-41f3-b2ff-7369b2ebcd61.png)


8. Click the button to open the query editor and follow the arrows to find your tables:  
![image](https://user-images.githubusercontent.com/19241669/191153848-1b9c622e-f6c5-44c0-a1af-bcc07fef0345.png)

9. Once you have finished, go back to the terminal and type `docker-compose down`     

## A word of caution 
In the `docker-compose.yaml` file and in steps 5) and 7) we are hardcoding credentials. Even though this is not a good practice, and we should avoid it by all means, here we are dealing with an example and make up data.
