CREATE TABLE user (
    id UUID PRIMARY KEY
);

# Printers stuff

CREATE TABLE printer (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES user(id),
    type TEXT NOT NULL
);

CREATE TABLE companion (
    id UUID PRIMARY KEY,
    token TEXT NOT NULL,
    whitelisted_ips INET[],
)

CREATE TABLE companion_printer (
    companion_id UUID NOT NULL REFERENCES companion(id),
    printer_id UUID NOT NULL REFERENCES printer(id),
    PRIMARY KEY (companion_id, printer_id)
);