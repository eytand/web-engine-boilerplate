echo instantiating a new repository from the boilerplate:
rm -rvf .git
git init

echo new repository name - '(for example web-queue-server)': 
read repository
echo new repository description
read description

echo please create a new repository in your git account with the name : $repository ,

echo make sure you have ssh public key installed in github
echo make sure repository has been created and press enter to continue 

read

sed -i --backup 's/@NAME@/'${repository}'/g' package.json README.md .env
sed -i --backup 's/@DESC@/'${description}'/g' package.json README.md .env

rm -f package.json--backup README.md--backup .env--backup

echo add your code to a remote branch
git add .
git commit -m "initiate $repository repo"
git remote add origin $GITHUB_ACCOUNT/$repository.git
git push -u origin master

npm install 
npm update web-engine --always-auth=true

echo "rename your directory"
cd . || return
new_dir=${PWD%/*}/$repository
current=$PWD 
echo $new_dir
echo $current

cp -r "$current" "$current"_backup
mv -- "$current" "$new_dir" &&
cd -- "$new_dir"

echo 'DONE... please set up your repo and push the changes.'
echo "Open you repo in a new IDE folder and push the package-lock.json"
echo "your boilerplate has been changed to bolierplate-backup"
