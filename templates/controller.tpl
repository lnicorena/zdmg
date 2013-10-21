<?="<?php\n"?>

class <?=$this->_namespace?>_<?=$this->_className?>Controller extends Zend_Controller_Action {

    public $feedback;
    private $id;
    private $model;
    private $mapper;
    private $form;
    
    public function init() {
        $this->id = intval($this->_getParam('id', 0));
        $this->feedback = $this->_helper->getHelper('FlashMessenger');
        $this->model = new <?=$this->_namespace?>_Model_<?=$this->_className?>();
        $this->mapper = new <?=$this->_namespace?>_Model_Mapper_<?=$this->_className?>();
        $this->form = new <?=$this->_namespace?>_Form_<?=$this->_className?>();
    }

    public function indexAction() {
        $pagina = intval($this->_getParam('pagina', 1));
        $dados = $this->view-><?= strtolower($this->_className)?> = $this->mapper->get<?=$this->_className?>s();

        $paginacao = Zend_Paginator::factory($dados);
        $paginacao->setItemCountPerPage(Zend_Registry::get('itens_por_pagina'));
        $paginacao->setPageRange(Zend_Registry::get('range'));
        $paginacao->setCurrentPageNumber($pagina);
        $this->view->paginacao = $paginacao;
    }

    public function adicionarAction() {
        $this->form->submit->setLabel('Adicionar');
        
        if ($this->getRequest()->isPost()) {
            $formulario = $this->getRequest()->getPost();
            if ($this->form->isValid($formulario)) {
                try{
                    <?php foreach ($this->_columns as $column): if ($column['field'] != $this->_primaryKey['field']) : ?>
                    $this->model-><?=$column['field']?> = $this->form->getValue('<?=$column['field']?>');
                    <?php endif; endforeach;?>
                    $this->mapper->save($this->model);
                    
                    $this->feedback->addMessage('success'); $this->feedback->addMessage('Sucesso');
                    $this->feedback->addMessage("O registro <strong>{$this->model->nome}</strong> foi adicionado com sucesso!");                    
                        
                } catch (Exception $e){
                    $this->feedback->addMessage('error'); $this->feedback->addMessage('Erro');
                    $detalhes = (APPLICATION_ENV == "development" || $e->getCode() == 99) ? "Detalhes: {$e->getMessage()}" : "";
                    $this->feedback->addMessage("Ocorreu um erro ao inserir o registro. {$detalhes}");
                }
                $this->_helper->redirector('index');
            } else {
                $this->form->populate($formulario);
            }
        }
        
        $this->view->form = $this->form;
    }

    public function editarAction() {
        $id = intval($this->_getParam('id', 0));

        if ($id > 0) {
            $this->form->submit->setLabel('Salvar');
            $this->form->limpar->setAttrib('class','btn-voltar');

            if ($this->getRequest()->isPost()) {
                $formulario = $this->getRequest()->getPost();
                if ($this->form->isValid($formulario)) {
                    try{
                        $this->model = $this->mapper->get<?=$this->_className?>ById($id);
                        <?php foreach ($this->_columns as $column): if ($column['field'] != $this->_primaryKey['field']) : ?>
                        $this->model-><?=$column['field']?> = $this->form->getValue('<?=$column['field']?>');
                        <?php endif; endforeach;?>
                        $this->mapper->save($this->model);
                        
                        $this->feedback->addMessage('success'); $this->feedback->addMessage('Sucesso');
                        $this->feedback->addMessage("O registro <strong>{$this->model->nome}</strong> foi alterado com sucesso!");                    
                        
                    } catch (Exception $e){
                        $this->feedback->addMessage('error'); $this->feedback->addMessage('Erro');
                        $detalhes = (APPLICATION_ENV == "development" || $e->getCode() == 99) ? "Detalhes: {$e->getMessage()}" : "";
                        $this->feedback->addMessage("Ocorreu um erro ao editar o registro. {$detalhes}");
                    }
                    
                    $this->_helper->redirector('index');
                } else {
                    $this->form->populate($formulario);
                }
            } else {
                $this->form->populate($this->mapper->get<?=$this->_className?>ById($id, true));     
            }
            $this->view->form = $this->form;
        }
    }
    
    public function removerAction() {
        if ($this->getRequest()->isPost()) {
            $del = $this->getRequest()->getPost('del');
            if ($del == 'Sim') {
                $id = $this->getRequest()->getPost('id');
                try{
                    $this->model = $this->mapper->get<?=$this->_className?>ById($id);
                    $this->mapper->remove($this->model);
                    
                    $this->feedback->addMessage('success');
                    $this->feedback->addMessage('Sucesso'); 
                    $this->feedback->addMessage("O registro <strong>{$this->model->nome}</strong> foi removido com sucesso!");
                }  catch (Exception $e){
                    $this->feedback->addMessage('error'); $this->feedback->addMessage('Erro');
                    $detalhes = (APPLICATION_ENV == "development" || $e->getCode() == 99) ? "Detalhes: {$e->getMessage()}" : "";
                    $this->feedback->addMessage("Ocorreu um erro ao tentar remover o registro. {$detalhes}");
                }
            }
            $this->_helper->redirector('index');
        } else {
            $id = $this->_getParam('id', 0);
            $this->view->dado = $this->mapper->get<?=$this->_className?>ById($id, true);
        }
    }    

}