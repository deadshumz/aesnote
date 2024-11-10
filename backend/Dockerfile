FROM python:3.12-alpine

WORKDIR /app

COPY . .

RUN pip install poetry \
    && poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi \
    && chmod +x start.sh

CMD ["sh", "start.sh"]
