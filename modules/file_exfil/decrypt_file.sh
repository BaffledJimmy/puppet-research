#!/bin/bash
KEY="WibbleDibbleMyKey123"
IV="1234567890123456"

ENCRYPTED_FILE="encrypted_data.txt"
DECRYPTED_FILE="final_output.txt"
TEMP_BIN="decrypted_tmp.bin"
base64 -d "$ENCRYPTED_FILE" > "$TEMP_BIN"

openssl enc -aes-256-cbc -d -salt -pbkdf2 -pass pass:"$KEY"  -iv "$IV" -in "$TEMP_BIN" -out "$DECRYPTED_FILE"
cat "$DECRYPTED_FILE" | base64 -d
