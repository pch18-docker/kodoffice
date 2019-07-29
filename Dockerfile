FROM pch18/kodoffice:raw
MAINTAINER pch18.cn

RUN apt-get -y install unzip \
    && wget -O /officeData.zip https://static.kodcloud.com/kod/source/onlyoffice/officeData.zip \
    && unzip -o -q /officeData.zip -d /onlyoffice \
    && mv /onlyoffice/officeData/web /var/www/onlyoffice/Data/ \
    && chmod -R 777 /var/www/onlyoffice/Data \
    && rm -rf /officeData.zip /onlyoffice \
    && apt-get -y remove unzip \
    && echo 'tail -f /dev/null'>>/app/onlyoffice/run-document-server.sh
    
VOLUME ["/var/www/onlyoffice/Data"]
HEALTHCHECK --interval=5s --timeout=3s CMD curl -fs http://localhost/web/check/?check=officeServer | grep -e ^\"true\"$ || exit 1
