FROM znly/protoc as protoc

WORKDIR /app

COPY xuexiaoyi.proto .
RUN protoc -I. --python_out=. xuexiaoyi.proto


FROM python:3-alpine
WORKDIR /app

RUN pip install Flask werkzeug protobuf requests colorama fontTools

COPY --from=protoc /app/xuexiaoyi_pb2.py /app/xuexiaoyi_pb2.py

COPY . .

EXPOSE 88
ENTRYPOINT ["python3", "app.py"]
