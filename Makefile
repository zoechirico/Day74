PROJECT = intrepid-app-299501
NAME = day74
TAG = dev


docker-build:
	mkdir -p certs
	docker build --no-cache -t gcr.io/$(PROJECT)/$(NAME):$(TAG) -f Dockerfile .

push:
	docker push gcr.io/$(PROJECT)/$(NAME):$(TAG)

load:
	kind load docker-imag gcr.io/$(PROJECT)/$(NAME):$(TAG)


build:
	go build -v .

run:
	docker run --rm -it -p 3000:3000  gcr.io/$(PROJECT)/$(NAME):$(TAG)


deploy:

	docker build --no-cache -t gcr.io/$(PROJECT)/$(NAME):$(TAG) -f Dockerfile .
	docker push gcr.io/$(PROJECT)/$(NAME):$(TAG)
	gcloud beta run deploy day74  --image gcr.io/$(PROJECT)/$(NAME):$(TAG) --platform managed \
            --allow-unauthenticated --project $(PROJECT) \
            --region us-east1 --port 3000 --max-instances 1  --memory 256Mi




