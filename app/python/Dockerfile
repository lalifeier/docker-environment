# FROM python:3.9 as build-stage

# WORKDIR /app

# COPY requirements.txt .
# RUN pip install requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

# FROM python:3.9-alpine as production-stage

# WORKDIR /app

# COPY --from=build-stage /usr/local/bin /usr/local/bin

# COPY --from=build-stage /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

# COPY . .

# CMD ["/bin/sh"]



FROM python:3.9-slim-bullseye as builder

WORKDIR /app

RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple \
	&& pip config set install.trusted-host mirrors.aliyun.com \
  && pip install -r requirements.txt \
  && pip install pyinstaller

RUN pyinstaller --hidden-import=tornado --onefile -d -y run.py

FROM frolvlad/alpine-glibc

WORKDIR /app

COPY --from=builder /app/dist/run .

CMD ["./run"]


# FROM python:3.8.5-slim-buster AS base

# FROM base AS builder
# COPY requirements.txt .
# RUN python -m pip install --user -r requirements.txt

# FROM base AS release
# COPY --from=builder /root/.local /root/.local
# COPY ./src .
# EXPOSE 8080
# ENV PATH=/root/.local/bin:$PATH
# CMD [ "python", "app.py" ]
