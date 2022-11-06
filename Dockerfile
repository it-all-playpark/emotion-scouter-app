FROM python:3.10.8-buster as builder

RUN apt-get update &&\
    apt-get install -y --no-install-recommends libgl1-mesa-dev gfortran

RUN pip install --upgrade pip &&\
    pip3 install tensorflow deepface opencv-python matplotlib uwsgi python-dotenv flask_httpauth


# nginxユーザー追加
# nginxユーザーがlocalでDeepfaceを実行できるように 
# nginxユーザーがcloud runでDeepfaceを実行できるように 
RUN useradd --no-create-home nginx &&\
    chown nginx /root &&\
    chown nginx /home

RUN rm -r /root/.cache


COPY server-conf/uwsgi.ini /etc/uwsgi/

COPY src /project/src

WORKDIR /project
# CMD ["flask", "run", "--host", "0.0.0.0", "--port", "8080"]
CMD ["/usr/local/bin/uwsgi --ini /etc/uwsgi/uwsgi.ini --die-on-term"]
