ARG APP_NAME=demo
ARG APP_PATH=/opt/$APP_NAME
ARG PYTHON_VERSION=3.9.13-slim
ARG POETRY_VERSION=1.1.11

# Stage: staging
FROM python:$PYTHON_VERSION as staging

ARG APP_NAME
ARG APP_PATH
ARG POETRY_VERSION

ENV \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1
ENV \
    POETRY_VERSION=$POETRY_VERSION \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1

ENV PATH="$POETRY_HOME/bin:$PATH"

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        curl \
        build-essential

RUN curl -sSL https://install.python-poetry.org | python3 -

WORKDIR $APP_PATH

COPY poetry.lock pyproject.toml ./
COPY ./$APP_NAME ./$APP_NAME

# Stage: development
FROM staging as development

ARG APP_PATH
ARG APP_NAME

ENV APP_NAME=$APP_NAME

ENV FASTAPI_ENV=development

WORKDIR $APP_PATH

RUN poetry install

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT /docker-entrypoint.sh $0 $@
CMD ["poetry" , "run" , "uvicorn", "--reload", "--host=0.0.0.0", "--port=8080", "${APP_NAME}:app"]


# Stage: build
FROM staging as build

ARG APP_PATH

WORKDIR $APP_PATH

RUN poetry build --format wheel
RUN poetry export --format requirements.txt --output constraints.txt --without-hashes


# Stage: production
FROM python:$PYTHON_VERSION as production

ARG APP_NAME
ARG APP_PATH

ENV APP_NAME=$APP_NAME

ENV FASTAPI_ENV=production

ENV \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1

ENV \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100

COPY --from=build $APP_PATH/dist/*.whl ./
COPY --from=build $APP_PATH/constraints.txt ./

RUN pip install ./$APP_NAME*.whl --constraint constraints.txt

WORKDIR $APP_PATH

COPY ./gunicorn_conf.py /gunicorn_conf.py
COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# CMD ["gunicorn",  "-k", "uvicorn.workers.UvicornWorker", "--bind :80",  "--workers 1", "--threads 1", "--timeout 0", "${APP_NAME}:app"]
CMD ["gunicorn", "--worker-class uvicorn.workers.UvicornWorker", "--config /gunicorn_conf.py", "${APP_NAME}:app"]
