# 1. Check if .env file exists
if [ -e .env ]; then
    source .env
else 
    echo "Please set up your .env file before starting your enviornment."
    exit 1
fi

# 2. Make Directories if not exists
mkdir -p echo ${PROXY_DATA_LOCATION}/portainer
mkdir -p echo ${PROXY_DATA_LOCATION}/sites-enabled
mkdir -p echo ${PROXY_DATA_LOCATION}/snippets
mkdir -p echo ${PROXY_DATA_LOCATION}/letsencrypt

# 2. Substitute env vars in config files and copy to
export ${CERT1_SERVER_NAME}
envsubst \${CERT1_SERVER_NAME}<./nginx-server-portainer.conf
cp -f ./nginx-server-portainer.conf echo ${PROXY_DATA_LOCATION}/sites-enabled


# 3. Start services
docker-compose -f stack.yaml up -d
