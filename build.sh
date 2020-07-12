echo "Building Docker image"
docker build --tag amazonlinux:nodejs .
echo "Installing Sharp and other modules"
docker run --rm --volume ${PWD}/lambda/origin-response-function:/build amazonlinux:nodejs /bin/bash -c "source ~/.bashrc; npm init -f -y; npm install sharp --save; npm install querystring --save; npm install --only=prod"
echo "Building dist"
mkdir -p dist
echo "Build origin-response-function"
cd lambda/origin-response-function && zip -FS -q -r ../../dist/origin-response-function.zip * && cd ../..
echo "Build viewer-request-function"
cd lambda/viewer-request-function && zip -FS -q -r ../../dist/viewer-request-function.zip * && cd ../..
echo "Done building lambda-edge-image-resizer"