#!/bin/bash

# Generate signed certificate using vault
echo "Generating signed certificate with vault..."
vault write -field=signed_key ssh-client-signer/sign/padley public_key=@$HOME/.ssh/id_rsa.pub >$HOME/.ssh/id_rsa-cert.pub

# Check if certificate was generated successfully
if [ $? -eq 0 ]; then
  echo "Certificate generated successfully"
  # Connect to sophie using the signed certificate
  ssh -o CertificateFile=$HOME/.ssh/id_rsa-cert.pub mhadley@sophie.home
else
  echo "Failed to generate certificate"
  exit 1
fi

