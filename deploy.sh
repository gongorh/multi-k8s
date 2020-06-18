docker build -t gongorh/multi-client:latest -t gongorh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gongorh/multi-server:latest -t gongorh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gongorh/multi-worker:latest -t gongorh/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push gongorh/multi-client:latest 
docker push gongorh/multi-server:latest
docker push gongorh/multi-worker:latest

docker push gongorh/multi-client:$SHA
docker push gongorh/multi-server:$SHA
docker push gongorh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gongorh/multi-server:$SHA
kubectl set image deployments/client-deployment client=gongorh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gongorh/multi-worker:$SHA
