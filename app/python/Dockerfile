ARG APP_NAME=demo
ARG APP_PATH=/opt/$APP_NAME
ARG PYTHON_VERSION=3.9.13-slim
ARG POETRY_VERSION=1.1.11

# Stage: staging
FROM python:$PYTHON_VERSION as staging

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

RUN curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python

WORKDIR $APP_PATH

COPY poetry.lock pyproject.toml ./
COPY ./$APP_NAME ./$APP_NAME

# Stage: development
FROM staging as development

ENV FASTAPI_ENV=development

WORKDIR $APP_PATH

RUN poetry install

CMD ["uvicorn", "--reload", "main:app"]


# Stage: build
FROM staging as build

WORKDIR $APP_PATH

RUN poetry build --format wheel
RUN poetry export --format requirements.txt --output constraints.txt --without-hashes


# Stage: production
FROM python:$PYTHON_VERSION as production

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

CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "main:app"]
