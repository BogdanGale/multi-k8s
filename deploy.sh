docker build -t bogdangale/multi-client:latest -t bogdangale/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bogdangale/multi-server:latest -t bogdangale/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bogdangale/multi-worker:latest -t bogdangale/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bogdangale/multi-client:latest
docker push bogdangale/multi-server:latest
docker push bogdangale/multi-worker:latest

docker push bogdangale/multi-client:$SHA
docker push bogdangale/multi-server:$SHA
docker push bogdangale/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bogdangale/multi-server:$SHA
kubectl set image deployments/client-deployment client=bogdangale/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bogdangale/multi-worker:$SHA