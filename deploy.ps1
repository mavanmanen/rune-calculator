yarn run build
Set-Location .\dist
git init
git add -A
git commit -m 'deploy'
git push -f git@github.com:mavanmanen/rune-calculator.git master:gh-pages