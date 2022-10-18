FROM python:3.8.13
WORKDIR /backend/src
COPY requirements.txt ./
RUN apt-get update &&\
    apt-get install libgl1-mesa-dev -y &&\
    pip install --upgrade pip &&\
    pip install -r requirements.txt
COPY src ./
CMD ["flask", "run", "--host", "0.0.0.0"]
