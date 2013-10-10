<?="<?php\n"?><?php $initb = array("Tb", "Tba"); ?>

class <?=$this->_namespace?>_Model_Mapper_<?=str_replace($initb, "", $this->_className)?> extends <?=$this->_namespace?>_Model_Mapper_MapperAbstract {

    protected $_db_table;

    public function __construct() {
        $this->_db_table = new <?=$this->_namespace?>_Model_DbTable_<?=str_replace($initb, "", $this->_className)?>();
    }

    public function save(<?=$this->_namespace?>_Model_<?=str_replace($initb, "", $this->_className)?> $<?=strtolower(str_replace($initb, "", $this->_className))?>) {
        $dados = array(
		<?php foreach ($this->_columns as $column): ?>
            '<?=$column['field']?>' => $<?=strtolower(str_replace($initb, "", $this->_className))?>-><?=$column['field']?>,
		<?php endforeach;?>
        );

        if (is_null($<?=strtolower(str_replace($initb, "", $this->_className))?>-><?=$this->_primaryKey['field']?>)) {
            return $this->_db_table->insert($dados);
        } else {
            $this->_db_table->update($dados, array('<?=$this->_primaryKey['field']?> = ?' => $<?=strtolower(str_replace($initb, "", $this->_className))?>-><?=$this->_primaryKey['field']?>));
        }
    }
	
    public function getDbTable(){
        return $this->_db_table;
    }
    
    public function remove($<?=strtolower(str_replace($initb, "", $this->_className))?>) {
        $this->_db_table->find($<?=strtolower(str_replace($initb, "", $this->_className))?>-><?=$this->_primaryKey['field']?>)->current()->delete();
    }
	
    public function get<?=str_replace($initb, "", $this->_className)?>ById($id, $vetor = false) {
        $busca = $this->_db_table->find($id);

        if (count($busca) == 0) {
            throw new Exception('Informação não encontrada');
        }

        if ($vetor) {
            $<?=strtolower(str_replace($initb, "", $this->_className))?> = $busca->current()->toArray();
        } else {
            $tupla = $busca->current();
            $<?=strtolower(str_replace($initb, "", $this->_className))?> = new <?=$this->_namespace?>_Model_<?=str_replace($initb, "", $this->_className)?>($tupla);
        }
        return $<?=strtolower(str_replace($initb, "", $this->_className))?>;
    }
    
    public function get<?=str_replace($initb, "", $this->_className)?>s() {
        return $this->_db_table->fetchAll(); // $select, "order by"
    }

}