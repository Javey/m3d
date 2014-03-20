<?php

require_once('../Lib/Db/jsondb/bootstrap.php');
use \jsondb\classes\JSONDB as JsonDb;

JsonDb::create('site', array(
    'id' => 'integer',
    'name' => 'string'
));