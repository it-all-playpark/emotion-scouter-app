FROM python:3.10.8-buster
WORKDIR /backend/src
COPY requirements.txt ./
RUN apt-get update &&\
    apt-get install libgl1-mesa-dev -y
RUN pip install --upgrade pip &&\
    pip3 install tensorflow &&\
    pip3 install deepface &&\
    pip3 install opencv-python &&\
    pip3 install matplotlib &&\
    pip3 install uWSGI
    # pip3 install -r requirements.txt
COPY src ./
# CMD ["flask", "run", "--host", "0.0.0.0", "--port", "8080"]
CMD ["sh", "-c", "uwsgi uwsgi.ini && sh"]