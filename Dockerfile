FROM python:3.8.13
WORKDIR /backend/src
COPY requirements.txt ./
RUN apt-get update &&\
    apt-get install libgl1-mesa-dev -y
RUN pip install --upgrade pip &&\
    pip3 install tensorflow &&\
    pip3 install deepface &&\
    pip3 install opencv-python &&\
    pip3 install matplotlib
    # pip3 install -r requirements.txt
COPY src ./
CMD ["flask", "run", "--host", "0.0.0.0"]