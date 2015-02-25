FROM       ubuntu:14.04

ENV        DEBIAN_FRONTEND noninteractive
ENV        PHANTOM_JS_VERSION 1.9.7-linux-x86_64
ENV        HIGHCHARTS_VERSION 4.1.1

RUN        apt-get -qq update && \
           apt-get -yqq install curl bzip2 libfreetype6 libfontconfig && \
           apt-get -yqq clean

RUN        curl -sSL https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOM_JS_VERSION.tar.bz2 | tar xjC /
RUN        ln -s phantomjs-$PHANTOM_JS_VERSION /phantomjs

RUN        curl -sSL https://github.com/highslide-software/highcharts.com/archive/v$HIGHCHARTS_VERSION.tar.gz | tar xzC /

RUN        ln -s /highcharts.com-$HIGHCHARTS_VERSION/exporting-server/phantomjs /highcharts

WORKDIR    /highcharts

ENTRYPOINT ["/phantomjs/bin/phantomjs"]

CMD        ["highcharts-convert.js", "-port", "8080", "-host", "0.0.0.0"]

EXPOSE     8080