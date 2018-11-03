docker build -t shekharhub/multi-client:latest -t shekharhub/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shekharhub/multi-server:latest -t shekharhub/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shekharhub/multi-worker:latest -t shekharhub/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shekharhub/multi-client:latest
docker push shekharhub/multi-server:latest
docker push shekharhub/multi-worker:latest

docker push shekharhub/multi-client:$SHA
docker push shekharhub/multi-server:$SHA
docker push shekharhub/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shekharhub/multi-server:$SHA
kubectl set image deployments/client-deployment client=shekharhub/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shekharhub/multi-worker:$SHA