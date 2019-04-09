if [ ! -f package.json ]; then
    echo "!!!!package json does not exist!!!!"
else
    export version=$(jq -r '.version' package.json)
    export name=$(jq -r '.name' package.json)
    cat process.yml >> process-template.yml
    envsubst < process-template.yml > process.yml
    cat process.yml
fi

