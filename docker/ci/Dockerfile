FROM ruby:2.6

# Add Gemfile
ADD Gemfile /

RUN apt-get update
RUN apt-get install -y ruby-full libaugeas-dev

# Configure to ever install a ruby gem docs then
# Install the relevant gems and cleanup after
RUN printf "gem: --no-rdoc --no-ri" >> /etc/gemrc && \
    gem install bundler

# Enable Unicode
ENV LANG C.UTF-8

# Now do the bundle install. I Split this off to minimize differences between 3 and 4
RUN bundler install --clean --system --gemfile /Gemfile

#Don't like that is sets clean in global config
RUN bundle config --delete clean

RUN apt-get update
RUN apt-get install default-jre default-jdk -y

RUN wget http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/sonar-runner-dist-2.4.zip && \
    unzip sonar-runner-dist-2.4.zip -d /opt/sonar-runner && \
    chmod +x /opt/sonar-runner/sonar-runner-2.4/bin/sonar-runner && \
    rm -rf sonar-runner-dist-2.4.zip

ENV PATH $PATH:/opt/sonar-runner/sonar-runner-2.4/bin
ENV SONAR_RUNNER_HOME /opt/sonar-runner/sonar-runner-2.4

RUN env

RUN java -version
RUN sonar-runner -v
