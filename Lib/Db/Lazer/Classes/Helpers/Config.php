<?php

// namespace Lazer\Classes\Helpers;

defined('LAZER_SECURE') or die('Permission denied!');

 /**
  * Config managing class
  *
  * @category Helpers
  * @author Grzegorz Kuźnik
  * @copyright (c) 2013, Grzegorz Kuźnik
  * @license http://opensource.org/licenses/MIT The MIT License
  */
 class Config extends File {

     public static function table($name)
     {
         $file = new Config;
         $file->name = $name;
         $file->setType('config');

         return $file;
     }

     /**
      * Get key from returned config
      * @param type $field key
      * @param type $assoc
      * @return mixed
      */
     public function getKey($field, $assoc = false)
     {
         $data = $this->get($assoc);
         return $assoc ? $data[$field] : $data->{$field};
     }

     /**
      * Return array with names of fields
      * @return array
      */
     public function fields()
     {
         return array_keys($this->getKey('schema', true));
     }

     /**
      * Return relations configure
      * @param mixed $tableName null-all tables;array-few tables;string-one table relation informations
      * @param boolean $assoc Object or associative array
      * @return array|object
      */
     public function relations($tableName = null, $assoc = false)
     {
         if (is_array($tableName))
         {
             $relations = $this->getKey('relations', $assoc);
             if($assoc)
             {
                return array_intersect_key($relations, array_flip($tableName));
             }
             else
             {
                return (object) array_intersect_key((array) $relations, array_flip($tableName));
             }
         }
         elseif ($tableName !== null)
         {
             $data = $this->getKey('relations', $assoc);
             return $assoc ? $data[$tableName] : $data->{$tableName};
         }

         return $this->getKey('relations', $assoc);
     }

     /**
      * Returning assoc array with types of fields
      * @return array
      */
     public function schema()
     {
         return $this->getKey('schema', true);
     }

     /**
      * Returning last ID from table
      * @param string $name
      * @return integer
      */
     public function lastId()
     {
         return $this->getKey('last_id');
     }

 }
 