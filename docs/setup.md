
Setup zephyr
https://docs.golioth.io/getting-started/device-examples/compile-example-code/zephyr/set-up-zephyr

rm -rf /home/pablo/golioth-zephyr-workspace/zephyr/build

pablo@pablo-pc:~/golioth-zephyr-workspace/zephyr$ west build -b esp32 samples/basic/minimal --pristine=always

(.venv) pablo@pablo-pc:~/golioth-zephyr-workspace/zephyr$ west flash

(.venv) pablo@pablo-pc:~/golioth-zephyr-workspace/zephyr$ west espressif monitor

