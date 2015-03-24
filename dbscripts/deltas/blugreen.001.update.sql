-- PT-2012: interoperate with bluegreen-discovery db

SET autocommit = 0;

USE blugreen;

INSERT INTO ENVIRONMENT (ENV_ID, ENV_NAME)
VALUES
  (1, 'idev'),
  (2, 'iqa'),
  (3, 'iprd'),
  (4, 'krakendev'),
  (5, 'krakenqa-blue'),
  (6, 'krakenqa-green'),
  (7, 'krakenprd-blue'),
  (8, 'krakenprd-green'),
  (9, '%%env.name%%');
-- teamcity won't substitute %%

INSERT INTO LOGICAL_DATABASE (LOGICAL_ID, LOGICAL_NAME, FK_ENV_ID)
VALUES
  (1, 'krakendb', 1),
  (2, 'krakendb', 2),
  (3, 'krakendb', 3),
  (4, 'krakendb', 4),
  (5, 'krakendb', 5),
  (6, 'krakendb', 6),
  (7, 'krakendb', 7),
  (8, 'krakendb', 8),
  (9, 'krakendb', 9);

-- FILL THIS IN WITH REAL PASSWORDS BEFORE RUNNING
INSERT INTO PHYSICAL_DATABASE (PHYSICAL_ID, IS_LIVE, DRIVER_CLASS_NAME, URL, USERNAME, `PASSWORD`, FK_LOGICAL_ID)
VALUES
  (1, 1, 'com.mysql.jdbc.Driver',
   'jdbc:mysql://krakendevdb.nikedev.com:3306/krakendev?zeroDateTimeBehavior=convertToNull', 'admin', 'password', 1),
  (2, 1, 'com.mysql.jdbc.Driver',
   'jdbc:mysql://krakenqadb.nikedev.com:3306/krakenqa?zeroDateTimeBehavior=convertToNull', 'kraken_admin', 'password',
   2),
  (3, 1, 'com.mysql.jdbc.Driver', 'jdbc:mysql://krakendb.nikedev.com:3306/kraken?zeroDateTimeBehavior=convertToNull',
   'kraken_user', 'password', 3),
  (4, 0, 'com.mysql.jdbc.Driver', 'does-not-exist-yet', 'nobody', 'password', 4),
  (5, 0, 'com.mysql.jdbc.Driver', 'does-not-exist-yet', 'nobody', 'password', 5),
  (6, 0, 'com.mysql.jdbc.Driver', 'does-not-exist-yet', 'nobody', 'password', 6),
  (7, 0, 'com.mysql.jdbc.Driver', 'does-not-exist-yet', 'nobody', 'password', 7),
  (8, 0, 'com.mysql.jdbc.Driver', 'does-not-exist-yet', 'nobody', 'password', 8),
  (9, 0, 'com.mysql.jdbc.Driver',
   'jdbc:mysql://krakendevdb.nikedev.com:3306/krakendev?zeroDateTimeBehavior=convertToNull', 'admin', 'password', 9);

INSERT INTO APPLICATION_VM (APPVM_ID, APPVM_SIN_NUMBER, APPVM_HOSTNAME, APPVM_IP_ADDRESS, FK_ENV_ID)
VALUES
  (1, 1, 'aws-233-54.nike.com', '10.194.233.54', 1),
  (2, 0, 'aws-233-36.nike.com', '10.194.233.36', 2),
  (3, 5, 'aws-233-56.nike.com', '10.194.233.56', 3),
  (4, 1, 'fakeHostname-krakendev', 'fakeip-krakendev', 4),
  (5, 1, 'fakeHostname-krakenqa-blue', 'fakeip-krakenqa-blue', 5),
  (6, 1, 'fakeHostname-krakenqa-green', 'fakeip-krakenqa-green', 6),
  (7, 1, 'fakeHostname-krakenprd-blue', 'fakeip-krakenprd-blue', 7),
  (8, 1, 'fakeHostname-krakenprd-green', 'fakeip-krakenprd-green', 8),
  (9, 1, 'fakeHostname-%%env.name%%', 'fakeip-%%env.name%%', 9);

COMMIT;

SET autocommit = 1;