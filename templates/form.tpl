<?="<?php\n"?>

class <?=$this->_namespace?>_Form_<?=$this->_className?> extends Suricate_Form_Decorator_Default {

    public function init() {

    $this->setName('form-<?= strtolower($this->_className) ?>');
        $this->setAttrib('class', 'zend_form form-horizontal');
        $this->setMethod('POST');

        $id = new Zend_Form_Element_Hidden('<?=$this->_primaryKey['field']?>');
        $id->addFilter('Int');
        $this->addElement($id);

        <?php foreach ($this->_columns as $column): if ($column['field'] != $this->_primaryKey['field']) : ?>
        $<?=$column['capital']?> = new Zend_Form_Element_Text('<?=$column['field']?>');
        $<?=$column['capital']?>->setLabel('<?=$column['capital']?>:')
                ->setRequired(true)
                ->addFilter('StripTags')
                ->addFilter('StringTrim')
                ->addValidator('NotEmpty');
        $this->addElement($<?=$column['capital']?>);
        $this->configurandoTamanho('<?=$column['field']?>', 'span3');
        
        <?php endif; endforeach;?>

        $submit = new Zend_Form_Element_Submit('submit');
        $submit->setLabel('Salvar')
                ->setAttrib('class', 'btn btn-large btn-primary')
                ->setIgnore(true);
        $this->addElement($submit);

        $limpar = new Zend_Form_Element_Button('limpar');
        $limpar->setLabel('Limpar')
                ->setAttrib('type', 'reset')
                ->setAttrib('class', 'btn btn-large btn-warning')
                ->setIgnore(true);
        $this->addElement($limpar);

        $this->montandoGrupo(array('submit', 'limpar'), 'botoes');
    }

}