package br.AppReciclagem.appReciclagem.service;

import br.AppReciclagem.appReciclagem.model.CestaBasica;
import br.AppReciclagem.appReciclagem.model.MaterialReciclavel;
import br.AppReciclagem.appReciclagem.model.Usuario;
import br.AppReciclagem.appReciclagem.repository.CestaBasicaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CestaBasicaService {

    @Autowired
    private CestaBasicaRepository cestaBasicaRepository;

    public List<CestaBasica> buscarTodos() {
        return cestaBasicaRepository.findAll();
    }

    public void atualizarPorId(Long id, Integer novoValor) {
        Optional<CestaBasica> cesta = cestaBasicaRepository.findById(id);
        cesta.ifPresent(novaCesta -> {
           novaCesta.setQtdEstoque(novaCesta.getQtdEstoque() + novoValor);
           cestaBasicaRepository.save(novaCesta);
        });
    }
    public String validarAtualizacaoEstoque(String valor){

        try{
            Integer valorInt = Integer.parseInt(String.valueOf(valor));
            if(valorInt <= 0){
                return "Por favor digite um inteiro positivo";
            }
        }
        catch(NumberFormatException e){
            return "Por favor digite um valor inteiro";
        }
        return "ok";
    }
}
