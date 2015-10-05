BASE=$(shell pwd)
PUBLIC=public
THEME=$(BASE)/themes/hyde
WEB=./public/*

deploy:
	sh deploy.sh

cu:
	rsync -vrL --delete $(WEB) fanz@lion.cs.cornell.edu:/home/WIN/fanz/MyWeb

