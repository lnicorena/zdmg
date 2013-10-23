<?="<?php\n"?>

class <?=$this->_namespace?>_Form_<?=$this->_className?> extends Suricate_Form_Decorator_Default {

    public function init() {

    $this->setName('form-<?= strtolower($this->_className) ?>');
        $this->setAttrib('class', 'zend_form form-horizontal');
        $this->setMethod('POST');

        $id = new Zend_Form_Element_Hidden('<?=$this->_primaryKey['field']?>');
        $id->addFilter('Int');
        $this->addElement($id);

        <?php 
        $_fields = array();
        foreach ($this->_columns as $column): if ($column['field'] != $this->_primaryKey['field']) : ?>
        $<?=$column['capital']?> = new Zend_Form_Element_Text('<?=$column['field']?>');
        $<?=$column['capital']?>->setLabel('<?=$column['capital']?>:')
                ->setRequired(true)
                ->addFilter('StripTags')
                ->addFilter('StringTrim')
                ->addValidator('NotEmpty');
        $this->addElement($<?=$column['capital']?>, null, null, 'col-sm-3');
        
        <?php 
        $_fields[] = $column['field'];
        endif; endforeach;?>

        $submit = new Zend_Form_Element_Button('submit');
        $submit->setLabel('<i class="icon-save"></i> ')
                ->setAttrib('type', 'submit')
                ->setAttrib('class', 'btn btn-large btn-success')
                ->setIgnore(true)
                ->setOptions(array('escape' => false));
        $this->addElement($submit);

        $limpar = new Zend_Form_Element_Button('limpar');
        $limpar->setLabel('<i class="icon-ban-circle"></i> Limpar')
                ->setAttrib('type', 'reset')
                ->setAttrib('class', 'btn btn-large btn-warning')
                ->setIgnore(true)
                ->setOptions(array('escape' => false));
        $this->addElement($limpar);

        $voltar = new Zend_Form_Element_Button('voltar');
        $voltar->setLabel('<i class="icon-chevron-left"></i> Voltar')
                ->setAttrib('onclick', 'window.history.go(-1)')
                ->setAttrib('class', 'btn btn-large btn-default')
                ->setIgnore(true)
                ->setOptions(array('escape' => false));
        $this->addElement($voltar);

        $this->montandoGrupo(array('<?= implode('\', \'', $_fields)?>'), 'campos');
        $this->montandoGrupo(array('voltar', 'limpar', 'submit'), 'botoes');
    }

}