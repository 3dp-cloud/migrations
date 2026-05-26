# and I quote, primitives

CREATE TABLE user (
    user_id UUID PRIMARY KEY,
    plan TEXT DEFAULT 'free' CHECK (plan IN ('free', 'paid'))
);

CREATE TABLE file (
    file_id UUID PRIMARY KEY,
    user_id UUID REFERENCES user(user_id),
    name TEXT NOT NULL
);

# Printers stuff

CREATE TABLE companion (
    companion_id UUID PRIMARY KEY,
    token TEXT NOT NULL,
    whitelisted_ips INET[],
)

CREATE TABLE printer (
    printer_id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES user(user_id),
    companion_id UUID REFERENCES companion(companion_id),
    companion_relative_ip INET NOT NULL,
    type TEXT NOT NULL
);

# STL catalog

CREATE TABLE listing (
    listing_id UUID PRIMARY KEY,
    user_id UUID REFERENCES user(user_id),
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    keywords TEXT[],
    likes INTEGER CHECK (value >= 0),
    dislikes INTEGER CHECK (value >= 0) 
);

CREATE TABLE listing_version (
    listing_version_id UUID PRIMARY KEY,
    listing_id UUID REFERENCES listing(listing_id),
    name TEXT NOT NULL,
    changelog TEXT NOT NULL,
);

CREATE TABLE listing_version_file (
    listing_version_id UUID REFERENCES listing_version(listing_version_id),
    file_id UUID REFERENCES file(file_id)
);