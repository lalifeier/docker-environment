FROM python:3.9-slim-bullseye AS build

WORKDIR /app

RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple \
	&& pip config set install.trusted-host mirrors.aliyun.com \
  && pip install -r requirements.txt \
  && pip install pyinstaller

RUN pyinstaller --hidden-import=tornado --onefile -d -y run.py

FROM frolvlad/alpine-glibc

WORKDIR /app

COPY --from=build /app/dist/run .

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
