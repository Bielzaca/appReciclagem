package br.AppReciclagem.appReciclagem.service;

import br.AppReciclagem.appReciclagem.model.MaterialReciclavel;
import br.AppReciclagem.appReciclagem.repository.MaterialReciclavelRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MaterialReciclavelService {
    @Autowired
    private MaterialReciclavelRepository materialRepo;

    public List<MaterialReciclavel> buscarTodos() {
        return materialRepo.findAll();
    }

    public String validaCadastro(MaterialReciclavel material){
        if(material.getTipoMaterial().isBlank()){
            return "Por favor digite um nome para o material reciclável";
        }
        if(material.getTipoMaterial().length() < 2){
            return "O nome do material deve ter ao menos 2 caracteres";
        }
        if(material.getValorPorPeso() <= 0){
            return "Por favor digite um inteiro positivo para o valor em créditos";
        }
        return "ok";
    }
}
