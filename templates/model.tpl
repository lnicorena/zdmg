<?="<?php\n"?>
<?php $initb = array("Tb", "Tba"); ?>

class <?=$this->_namespace?>_Model_<?=str_replace($initb, "", $this->_className)?> extends <?=$this->_namespace?>_Model_ModelAbstract {

<?php foreach ($this->_columns as $column): ?>
    protected $<?=$column['field']?>;
<?php endforeach;?>
<?php foreach ($this->getForeignKeysInfo() as $key): ?>
    protected $<?=strtolower($this->_getRelationName($key, 'parent'))?>;
<?php endforeach;?>
<?php foreach ($this->getDependentTables() as $key): ?>
    protected $<?=strtolower($this->getRelationName($key, 'dependent'))?>;
<?php endforeach;?>

    public function __construct($<?=strtolower(str_replace($initb, "", $this->_className))?> = null) {
        if (!is_null($<?=strtolower(str_replace($initb, "", $this->_className))?>) && $<?=strtolower(str_replace($initb, "", $this->_className))?> instanceof Zend_Db_Table_Row) {
        <?php foreach ($this->_columns as $column): ?>
            $this-><?=$column['field']?> = $<?=strtolower(str_replace($initb, "", $this->_className))?>-><?=$column['field']?>;
		<?php endforeach;?>
        }
    }

    public function __set($name, $value) {
        $this->$name = $value;
    }

    public function __get($name) {
        return $this->$name;
    }

}
