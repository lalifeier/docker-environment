FROM python:3.9-alpine as build-stage
FROM base as builder
COPY requirements.txt /requirements.txt
RUN pip install --user -r /requirements.txt

FROM python:3.9-alpine as production-stage
COPY --from=builder /root/.local /root/.local
COPY src /app
WORKDIR /app

# update PATH environment variable
ENV PATH=/home/app/.local/bin:$PATH

CMD ["/bin/sh"]
