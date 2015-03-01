## Description

- Listens for requests
- Validate input
- Process the request
- Return result

- Non Errors are simply the JSON-RPC property 'result'

- Errors are the JSON-RPC property 'errors' and have 3 properties which will map to JSON-API this way:
    - code (JSON-RPC code => JSON-API HTTP status)
    - message (JSON-RPC message => JSON-API code - Application/machine message)
    - data (JSON-RPC data => JSON-API title - Human readable message)

## Dependencies

- io.js 1.x or Node 0.12.x
- RabbitMQ
- MongoDB

## Install

    git clone git@github.com:rudijs/ride-share-market-data.git
    npm install
    npm install -g gulp pm2

## Dev Tools

    gulp help

## Tests

    RABBITMQ_URL='rsm_user:abcdef@rmq01.dev.loc.ridesharemarket.com/rsm' gulp test
    RABBITMQ_URL='rsm:Y9i6YAgdbW7H@192.168.33.10/rsm' gulp test
    gulp lint

    RABBITMQ_URL='rsm_user:abcdef@rmq01.dev.loc.ridesharemarket.com/rsm' gulp watch-test
    gulp watch-lint

## Start

- Development Env
- `pm2 start config/processes.json`

- Production Env
- `pm2 start config/processes.json`

## Notes

### Patch for Solarized theme

'patch' mocha to update the colours to a more solarized-friendly version. Run it in your working directory after an npm install to affect local versions of mocha, or in /usr/lib/node_modules (on my unix machine at least) to affect a global install of mocha.

    sudo apt-get install ack-grep
    pushd node_modules/mocha
    ack-grep -li "'pass': 90" --noignore-dir=node_modules | xargs sed -i "s/'pass': 90/'pass': 92/; s/'error stack': 90/'error stack': 92/; s/'fast': 90/'fast': 92/; s/'light': 90/'light': 92/; s/'diff gutter': 90/'diff gutter': 92/; s/'diff added': 42/'diff added': 34/; s/'diff removed': 41/'diff removed': 33/"
    popd
