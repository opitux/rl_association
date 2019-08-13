SET FOREIGN_KEY_CHECKS=0;

--
-- Table structure for table `galette_events_events`
--

DROP TABLE IF EXISTS galette_events_events;
CREATE TABLE galette_events_events (
  id_event int(10) NOT NULL auto_increment,
  name varchar(150) NOT NULL,
  address varchar(150) NOT NULL default '',
  zip varchar(10) NOT NULL default '',
  town varchar(50) NOT NULL default '',
  country varchar(50) default NULL,
  begin_date date NOT NULL default '1901-01-01',
  end_date date NOT NULL default '1901-01-01',
  creation_date date NOT NULL default '1901-01-01',
  is_open tinyint(1) NOT NULL default 1,
  id_group int(10) default NULL,
  comment text,
  PRIMARY KEY (id_event),
  FOREIGN KEY (id_group) REFERENCES galette_groups (id_group) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `galette_events_bookings`
--

DROP TABLE IF EXISTS galette_events_bookings;
CREATE TABLE galette_events_bookings (
  id_booking int(10) NOT NULL auto_increment,
  id_event int(10) NOT NULL,
  id_adh int(10) unsigned NOT NULL,
  booking_date date NOT NULL default '1901-01-01',
  is_paid tinyint(1) NOT NULL default 0,
  payment_amount  decimal(15, 2) default '0',
  payment_method tinyint(3) unsigned NOT NULL default '0',
  bank_name varchar(100) default NULL,
  check_number varchar(50) default NULL,
  number_people int(4) default NULL,
  creation_date date NOT NULL default '1901-01-01',
  comment text,
  PRIMARY KEY (id_booking),
  UNIQUE KEY (id_event, id_adh),
  FOREIGN KEY (id_event) REFERENCES galette_events_events (id_event) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_adh) REFERENCES galette_adherents (id_adh) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `galette_events_activities`
--

DROP TABLE IF EXISTS galette_events_activities;
CREATE TABLE galette_events_activities (
  id_activity int(10) NOT NULL auto_increment,
  name varchar(150) NOT NULL,
  is_active tinyint(1) NOT NULL default 1,
  creation_date date NOT NULL default '1901-01-01',
  comment text,
  PRIMARY KEY (id_activity)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS galette_events_activitiesevents;
CREATE TABLE galette_events_activitiesevents (
  id_event int(10) NOT NULL,
  id_activity int(10) NOT NULL,
  status tinyint(1) NOT NULL,
  PRIMARY KEY(id_event,id_activity),
  FOREIGN KEY (id_event) REFERENCES galette_events_events (id_event) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_activity) REFERENCES galette_events_activities (id_activity) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS galette_events_activitiesbookings CASCADE;
CREATE TABLE galette_events_activitiesbookings (
  id_activitybooking int(10) NOT NULL auto_increment,
  id_activity int(10) NOT NULL,
  id_booking int(10) NOT NULL,
  checked tinyint(1) default 0,
  PRIMARY KEY (id_activitybooking),
  UNIQUE KEY (id_activity, id_booking),
  FOREIGN KEY (id_activity) REFERENCES galette_events_activities (id_activity) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_booking) REFERENCES galette_events_bookings (id_booking) ON DELETE CASCADE ON UPDATE CASCADE
);

SET FOREIGN_KEY_CHECKS=1;
