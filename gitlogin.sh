echo "Who are you"
read -p "user.name " username
read -p "user.email " useremail
read -p "Branch to commit " branches
read -p "Times Commit " timecommit
read -p "url push " push

git config --global user.name "${username}"
git config --global user.email ${useremail}

git checkout ${branches}
git add .
git commit -m "${timecommit} Commit"
git push ${push} ${branches} --force