FROM ruby:2.7.4

ENV TZ=Asia/Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN wget "http://jaist.dl.sourceforge.jp/mix-mplus-ipa/59021/migmix-2p-20130617.zip"
RUN unzip migmix-2p-20130617.zip
RUN mkdir -p /usr/share/fonts/japanese/TrueType/
RUN mv -i migmix-2p-20130617/*ttf /usr/share/fonts/japanese/TrueType/
RUN ls /usr/share/fonts/japanese/TrueType/
RUN fc-cache -fv
RUN fc-list | grep Mig

RUN apt-get update && \
    apt-get install -y nodejs yarn xvfb
RUN wget "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz"
RUN tar xvJf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN cp wkhtmltox/bin/wkhtmlto* /usr/local/bin/

ENV NODE_ENV=production

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN mkdir /step-travel

WORKDIR /step-travel
COPY . /step-travel
RUN gem install bundler -v 2.1.4

RUN bundle install --jobs=4 --retry=3 --path vendor/bundle --clean
ENTRYPOINT ["entrypoint.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
