# 1. Check if .env file exists
if [ -e .env ]; then
    source .env
else 
    echo "Please set up your .env file before starting your enviornment."
    exit 1
fi

# 2. Make Directories if not exists
mkdir -p ${PROXY_DATA_LOCATION}/portainer
mkdir -p ${PROXY_DATA_LOCATION}/sites-enabled
mkdir -p ${PROXY_DATA_LOCATION}/snippets
mkdir -p ${PROXY_DATA_LOCATION}/letsencrypt

# 2. Substitute env vars in config files and copy to
envsubst < ./sample.nginx-server-portainer.conf > ./nginx-server-portainer.conf
cp -f ./nginx-server-portainer.conf ${PROXY_DATA_LOCATION}/sites-enabled


# 3. Start services
docker-compose -f stack.yaml up -d
