# 2023-02-02 00:36:48 UTC
SOURCE_DATE_EPOCH=1675298208

# Change to "true" for pushing the image to the registry
PUSH=false

# export BUILDKIT_HOST=docker-container://buildkitd

buildctl build \
  --frontend dockerfile.v0 \
  --local dockerfile=. \
  --local context=. \
  --metadata-file metadata.json \
  --output type=image,name=example.com/foo:$SOURCE_DATE_EPOCH,buildinfo=false,push=$PUSH \
  --opt build-arg:SOURCE_DATE_EPOCH=$SOURCE_DATE_EPOCH \
  --opt platform=linux/amd64,linux/arm64 
