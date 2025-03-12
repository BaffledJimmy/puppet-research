#!/bin/bash
KEY="WibbleDibbleMyKey123"
IV="1234567890123456"

ENCRYPTED_FILE="encrypted_data.txt"
base64 -d "$ENCRYPTED_FILE" > decrypted_tmp.bin

openssl enc -aes-256-cbc -d -salt -pbkdf2 -pass pass:"$KEY" -iv "$IV" -in decrypted_tmp.bin -out final_output.txt
base64 -d final_output.txt > original_envvars.txt
cat original_envvars.txt
