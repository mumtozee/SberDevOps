FROM python:3.10

WORKDIR /text_svc

COPY requirements.txt /text_svc/requirements.txt
RUN pip3 install -r requirements.txt

COPY . ./

EXPOSE 5000
CMD ["python", "main_svc.py"]