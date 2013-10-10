<?="<?php\n"?>

class <?=$this->_namespace?>_Model_DbTable_<?=$this->_className?>  extends <?=$this->_namespace?>_Model_DbTable_TableAbstract {
    
    protected $_name = '<?=$this->_tbname?>';

    protected $_id = <?php
    if ($this->_primaryKey['phptype'] !== 'array') {
        echo '\'' . $this->_primaryKey['field'] . '\'';
    } else {
        echo $this->_primaryKey['field'];
    }
    ?>;

    protected $_sequence = <?=($this->_primaryKey['phptype'] !== 'array') ? 'true' : 'false'; ?>;

    <?=$referenceMap?>

    <?=$dependentTables?>
	
}
