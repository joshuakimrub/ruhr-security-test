listener "tcp" {
    address = "0.0.0.0:9200"
    tls_disable = false
    tls_cert_file = "${CERT}"
    tls_key_file = "${KEY}"
    tls_min_version = "tls13"
    custom_ui_response_headers = {
        "default" = {
            "Strict-Transport-Security" = ["max-age=31536000; includeSubDomains"],
            "Content-Security-Policy" = ["default-src 'none'; script-src 'self' 'wasm-unsafe-eval'; frame-src 'self'; font-src 'self'; connect-src 'self'; img-src 'self' data:; style-src 'self'; media-src 'self'; manifest-src 'self'; style-src-attr 'self'; frame-ancestors 'self'"]
        },
        "301" = {
            "Strict-Transport-Security" = ["max-age=31536000"],
            "Content-Security-Policy" = ["default-src 'none'; script-src 'none'; connect-src 'none'"],
        },
    }
}

controller {
    name = "boundary-controller"
    database {
        url = "postgresql://boundary:${POSTGRES_PASSWORD}@localhost:5432/boundary"
    }
}

worker {
    name = "boundary-worker"
    controllers = ["127.0.0.1:9200"]
}

kms "aead" {
    purpose = "worker-auth"
    aead_type = "aes-gcm"
    key = "${AES_KEY}"
    key_id = "global_worker-auth"
}