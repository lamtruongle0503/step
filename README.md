# README

This README would normally document whatever steps are necessary to get the
application up and running.

### Rule github
- Task type: `task | fix | improvement | hotfix`
- Branch name `task-type/date/username-task_name`
  - Ex: `task/20220221/hoangth-api_sign_up`

### Ruby v2.7.4
```sh
$ brew upgrade rbenv ruby-build
$ rbenv install 2.7.4
$ rbenv global 2.7.4
```

### Node v14.19.0
```sh
$ brew install nvm
$ mkdir ~/.nvm
----------
*Add following line to your profile. (.profile or .zshrc or .zprofile)
  # NVM
  export NVM_DIR=~/.nvm
  source $(brew --prefix nvm)/nvm.sh
----------
source ~/.zshrc
$ nvm install 14
```

### Yarn install
```
$ npm install -g yarn
$ yarn install
```

### Setup

```sh
$ cp .env.sample .env
$ bundle install --path vendor/bundle
$ bundle exec rails db:create db:migrate db:seed
```

### Start Sever

```sh
$ bundle exec rails s
$ bin/webpack-dev-server
```
