FROM ruby:2.6.2-stretch
COPY . /application
WORKDIR /application

# Install gems
RUN bundle install
ENV RAILS_ENV production
ENV NVM_DIR /usr/local/nvm
RUN mkdir -p /usr/local/nvm
RUN bash -c "apt-get install libssl-dev"
RUN bash -c "apt-get update"
#RUN bash -c "apt-get install -y nodejs-legacy"
#RUN "apt-get install -y yarn"
SHELL ["/bin/bash", "--login", "-c"]

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
#RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.1/install.sh | bash
ENV NODE_VERSION v10
#RUN nvm install 14.0.0
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use --delete-prefix $NODE_VERSION"
ENV NODE_PATH $NVM_DIR/versions/node/$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH
#RUN curl -sL https://deb.nodesource.com/setup_14.x
#RUN /bin/bash -c "apt-get update"
#RUN bash -c "apt-get install -y nodejs"
#RUN /bin/bash -c "apt-get install -y yarn"
#RUN bundle exec rake webpacker:install
RUN npm install -g yarn
RUN /bin/bash -c "yarn add --dev webpack webpack-dev-server"
ENTRYPOINT ["./entrypoint.sh"]
