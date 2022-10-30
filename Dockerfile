FROM python:3.10.8-buster as builder

RUN apt-get update &&\
    apt-get install -y --no-install-recommends libgl1-mesa-dev nginx supervisor gfortran

RUN pip install --upgrade pip &&\
    pip3 install tensorflow deepface opencv-python matplotlib uwsgi python-dotenv flask_httpauth


# nginxユーザー追加
# nginxユーザーがlocalでDeepfaceを実行できるように 
# nginxユーザーがcloud runでDeepfaceを実行できるように 
RUN useradd --no-create-home nginx &&\
    chmod 703 /root &&\
    chmod 733 /home


RUN rm /etc/nginx/sites-enabled/default
RUN rm -r /root/.cache


COPY server-conf/nginx.conf /etc/nginx/
COPY server-conf/flask-site-nginx.conf /etc/nginx/conf.d/
COPY server-conf/uwsgi.ini /etc/uwsgi/
COPY server-conf/supervisord.conf /etc/supervisor/

COPY src /project/src

WORKDIR /project
# CMD ["flask", "run", "--host", "0.0.0.0", "--port", "8080"]
CMD ["/usr/bin/supervisord"]

# FROM python:3.10.8-alpine3.16 as runner
# COPY  --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
# WORKDIR /backend/src
# COPY  --from=builder /backend/src ./
# CMD ["sh", "-c", "uwsgi uwsgi.ini && sh"]