Example invocations to run benchmark on local machine:

1. Server
```
anemo-benchmark --port 5566
```

1. Client (look here for output)
```
anemo-benchmark --port 5555 --addrs 127.0.0.1:5566 --requests-up 10 --requests-down 10 --size-up 5000 --size-down 5000
```