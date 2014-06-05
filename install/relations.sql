CREATE TABLE urls (
    url text UNIQUE NOT NULL, 
    entity text PRIMARY KEY
);

CREATE TABLE userlookup (
    username text NOT NULL, 
    domain text NOT NULL, 
    entity text NOT NULL, 
    PRIMARY KEY (entity, domain),
    UNIQUE (username, domain)
);

CREATE TABLE pidlookup (
    pid text NOT NULL, 
    domain text NOT NULL, 
    entity text NOT NULL, 
    PRIMARY KEY (entity, domain),
    UNIQUE (pid, domain)
);

CREATE TABLE courselookup (
    courseid text NOT NULL, 
    domain text NOT NULL, 
    entity text NOT NULL,
    PRIMARY KEY (entity, domain), 
    UNIQUE (courseid, domain)
);

CREATE TABLE homeserverlookup (
    entity text NOT NULL, 
    domain text NOT NULL,
    homeserver text NOT NULL, 
    PRIMARY KEY (entity, domain)
);

CREATE TABLE rolelist (
    roleentity text NOT NULL, 
    roledomain text, 
    rolesection text,
    userentity text NOT NULL, 
    userdomain text NOT NULL, 
    role text NOT NULL,
    startdate timestamp, 
    enddate timestamp, 
    manualenrollentity text,
    manualenrolldomain text, 
    PRIMARY KEY (roleentity, roledomain),
    UNIQUE (roleentity, roledomain, rolesection, userentity, userdomain,
        role)
);

CREATE TABLE assessments (
    courseentity text NOT NULL, 
    coursedomain text NOT NULL, 
    userentity text NOT NULL, 
    userdomain text NOT NULL, 
    resourceid text NOT NULL, 
    partid text NOT NULL, 
    scoretype text, 
    score text, 
    totaltries text, 
    countedtries text, 
    status text, 
    responsedetailsjson text, 
    PRIMARY KEY (courseentity, coursedomain, userentity, userdomain, 
        resourceid, partid)
);
