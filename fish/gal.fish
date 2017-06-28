set --universal fish_user_paths $fish_user_paths ./node_modules/.bin
set -g -x GITLAB_API_ENDPOINT https://gitlab.com/api/v3
set -g -x ANDROID_HOME /usr/local/opt/android-sdk

function __git_last_commit_relative_time
  set then_date (git log -n1 --format="%at" $argv)
  set now_date (date +%s)
  set diff_date (math $now_date-$then_date)

  set diff_minutes (math $diff_date/60%60)
  set diff_hours (math $diff_date/60/60)

  if math "$diff_hours > 0" > /dev/null
    set result $diff_hours"h"
  end

  echo $result$diff_minutes"m"
end

function git_last_commit_relative_time
  if git_is_repo
    __git_last_commit_relative_time $argv
  end
end

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

function r
  rvm use 2.3.1

  function r
    rails $argv
  end
end

function rbc
  bundle check
  bundle install
end

function rdb
  r db:migrate
end

function f
  fg
end

function remind_me
  osascript ~/dotfiles/applescripts/remind_me.scpt "$argv"
end

function rmt
  osascript ~/dotfiles/applescripts/remind_me.scpt "$argv"
end
