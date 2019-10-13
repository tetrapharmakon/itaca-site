stack run site rebuild
cp -r _site/* ~/tetrapharmakon.github.io/itaca/
cd ~/tetrapharmakon.github.io/
source ~/.rvm/scripts/rvm
jekyll build
git add -A; git commit -m "update itaca"; git push
