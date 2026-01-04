# peripheral_backend-in_go

# proto generate

protoc --proto_path=./proto \
    --go_out=./protoGen --go_opt=paths=source_relative \
    --go-grpc_out=./protoGen --go-grpc_opt=paths=source_relative \
    stack.proto