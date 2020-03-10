FROM openjdk:slim
COPY --from=python:3.6.5 / /

RUN mkdir /app
WORKDIR /app

COPY app/requirements.txt .
RUN pip3 install -r requirements.txt

ADD /app .

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN python3 -c 'import nltk; nltk.download("stopwords"); nltk.download("wordnet");'

CMD ["uwsgi", "project.ini"]

# docker build -t hyperted/topic .
# docker run -p 27020:5000  -d -v /home/semantic/ted-talk-topic-extraction/models:/app/models -v /home/semantic/ted-talk-topic-extraction/data:/app/data --name hyperted_topic hyperted/topic