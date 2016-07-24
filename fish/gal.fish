set --universal fish_user_paths $fish_user_paths ./node_modules/.bin

function dock
	if count argv > /dev/null
		set WHERE $argv[1]
	else
		set WHERE "default"
	end
  eval (docker-machine env $WHERE)
end

function vim
  nvim $argv
end

function home_dns
  networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4
end

function reset_dns
  networksetup -setdnsservers Wi-Fi empty
end

function mkcd
  mkdir $argv
  cd $argv
end

function preview
  qlmanage -p $argv ^ /dev/null > /dev/null
end

function swarm
	env DOCKER_HOST=(swarm_host) docker $argv
end

function swarm_host
	echo (echo $DOCKER_HOST | cut -s -d":" -f1,2):3376
end

function npmdeps_imported
  grep -or "from '\([^.]\+'\)" $argv | cut -d ':' -f 2 | uniq | sed "s .*'\([^']*\)' \1 g" | uniq
end

function npmdeps
  node -e "
    var p = require('./package.json');
    var devdeps = Object.keys(p.devDependencies);
    var alldeps = Object.keys(p.dependencies);
    var deps = alldeps.concat(devdeps).join('\n');
    console.log(deps);
  " | uniq
end

function dokku
	ssh -t dokku@dokku.hagever.com -- $argv
end
