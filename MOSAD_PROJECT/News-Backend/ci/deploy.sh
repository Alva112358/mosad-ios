set -e

ssh-keyscan -t $TRAVIS_SSH_KEY_TYPES -H $SERVER_IP 2>&1 | tee -a ${TRAVIS_HOME}/.ssh/known_hosts
openssl aes-256-cbc -K $encrypted_4006a652c8d1_key -iv $encrypted_4006a652c8d1_iv -in ci/deploy_rsa.enc -out /tmp/deploy_rsa -d
chmod 600 /tmp/deploy_rsa
ssh $SERVER_USERNAME@$SERVER_IP -o StrictHostKeyChecking=no -i /tmp/deploy_rsa '/bin/bash -c "cd /root/newsback && ls && git pull origin master && ROCKET_ENV=production /root/.cargo/bin/cargo build --release && ./target/release/news-backend"'