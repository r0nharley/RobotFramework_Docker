FROM python:3



#
# Let's make sure we are always having the latest version of pip installed
#
RUN python -m pip install --upgrade pip

#
# Installing the latest robot framework version
#
RUN python3 -m pip install robotframework

#
# Installing selenium2 test library
#
RUN python3 -m pip install robotframework-selenium2library
RUN python3 -m pip install selenium



RUN apt-get update -y

# Dependencies
RUN apt-get install -y  \
       apt-utils \
       build-essential \
       fonts-liberation \
       gconf-service \
       libappindicator1 \
       libasound2 \
       libcurl3 \
       libffi-dev \
       libgconf-2-4 \
       libindicator7 \
       libnspr4 \
       libnss3 \
       libpango1.0-0 \
       libssl-dev \
       libxss1 \
       python-dev \
       python-pip \
       python-pyasn1 \
       python-pyasn1-modules \
       unzip \
       wget \
       xdg-utils \
       xvfb \
       libappindicator3-1 \
       libatk-bridge2.0-0 \
       libgtk-3-0 \
       lsb-release


     

# Install Chrome for Selenium
RUN curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /chrome.deb
RUN dpkg -i /chrome.deb || apt-get install -yf
RUN rm /chrome.deb

# Install chromedriver for Selenium
RUN curl https://chromedriver.storage.googleapis.com/73.0.3683.20/chromedriver_linux64.zip -o /usr/local/bin/chromedriver
RUN unzip -o /usr/local/bin/chromedriver -d /usr/local/bin
RUN chmod 777 /usr/local/bin/chromedriver


RUN wget --no-verbose --output-document /tmp/firefox-65.0.2.tar.bz2 https://ftp.mozilla.org/pub/firefox/releases/65.0.2/linux-x86_64/en-US/firefox-65.0.2.tar.bz2 && \
    tar -xjf /tmp/firefox-65.0.2.tar.bz2 && \
    mv firefox /opt/firefox56 && \
    ln -s /opt/firefox56/firefox-bin /usr/bin/firefox


RUN GECKODRIVER_VERSION=`wget --no-verbose --output-document - https://api.github.com/repos/mozilla/geckodriver/releases/latest | grep tag_name | cut -d '"' -f 4` && \
    wget --no-verbose --output-document /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz && \
    tar --directory /opt -zxf /tmp/geckodriver.tar.gz && \
    chmod +x /opt/geckodriver && \
    ln -fs /opt/geckodriver /usr/local/bin/geckodriver


