FROM mcr.microsoft.com/windows:ltsc2019

COPY bin /massgate
COPY config.ini /massgate
COPY my.ini /massgate

# Install necessary dependencies and MySQL 5.7
RUN powershell -Command \
    Invoke-WebRequest -Uri https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.34-winx64.zip -OutFile mysql.zip; \
    Expand-Archive -Path mysql.zip -DestinationPath C:\; \
    Remove-Item -Force mysql.zip; \
    Rename-Item -Path C:\mysql-5.7.34-winx64 -NewName C:\mysql

# Copy MySQL configuration file
COPY my.ini C:\mysql\my.ini

# Add MySQL to PATH
RUN setx /M PATH "%PATH%;C:\mysql\bin"

# Initialize MySQL database
RUN mysqld --initialize-insecure --console

# Run initial mysql
RUN mysql.exe -u root -e "CREATE DATABASE IF NOT EXISTS live; USE live;\
GRANT ALL ON live.* TO 'massgateadmin'@'localhost' IDENTIFIED BY '8fesfsdBOrwe';\
GRANT SELECT ON live.* TO 'massgateclient'@'localhost' IDENTIFIED BY 'po389ef0sS';\
FLUSH PRIVILEGES;"

COPY init.sql /init.sql
RUN mysql.exe -u root -e "source C:\init.sql"
# Set the working directory
WORKDIR /massgate

# Expose MySQL port
#EXPOSE 3306

# Expose any necessary ports for your application
EXPOSE 3001

# Copy the entrypoint script to the container
COPY entrypoint.ps1 /entrypoint.ps1

# Set the entrypoint script to run MySQL and your application
ENTRYPOINT ["powershell", "/entrypoint.ps1"]