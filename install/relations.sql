CREATE TABLE urls (
    url text UNIQUE NOT NULL, 
    entity text PRIMARY KEY
);

CREATE TABLE userlookup (
    username text NOT NULL, 
    domain text NOT NULL, 
    entity text PRIMARY KEY, 
    UNIQUE (username, domain)
);

CREATE TABLE pidlookup (
    pid text NOT NULL, 
    domain text NOT NULL, 
    entity text PRIMARY KEY, 
    UNIQUE (pid, domain)
);

CREATE TABLE courselookup (
    courseid text NOT NULL, 
    domain text NOT NULL, 
    entity text PRIMARY KEY, 
    UNIQUE (courseid, domain)
);

CREATE TABLE homeserverlookup (
    entity text PRIMARY KEY, 
    domain text NOT NULL,
    homeserver text NOT NULL, 
    UNIQUE (entity, domain)
);

CREATE TABLE rolelist (
    roleentity text PRIMARY KEY, 
    roledomain text, 
    rolesection text,
    userentity text NOT NULL, 
    userdomain text NOT NULL, 
    role text NOT NULL,
    startdate timestamp, 
    enddate timestamp, 
    manualenrollentity text,
    manualenrolldomain text, 
    UNIQUE (roleentity, roledomain, rolesection, userentity, userdomain,
        role)
);

CREATE TABLE assessments (
    courseentity text PRIMARY KEY, 
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
    UNIQUE (courseentity, coursedomain, userentity, userdomain, 
        resourceid, partid)
);
