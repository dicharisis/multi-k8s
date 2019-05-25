docker build -t dicharisis/multi-client:latest -t dicharisis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dicharisis/multi-server:latest -t dicharisis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dicharisis/multi-worker:latest -t dicharisis/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dicharisis/multi-client:latest
docker push dicharisis/multi-server:latest
docker push dicharisis/multi-worker:latest

docker push dicharisis/multi-client:$SHA
docker push dicharisis/multi-server:$SHA
docker push dicharisis/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dicharisis/multi-server:$SHA
kubectl set image deployments/client-deployment client=dicharisis/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dicharisis/multi-worker:$SHA


