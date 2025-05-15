package br.AppReciclagem.appReciclagem.service;

import br.AppReciclagem.appReciclagem.model.EntregaMaterial;
import br.AppReciclagem.appReciclagem.repository.EntregaMaterialRepository;
import br.AppReciclagem.appReciclagem.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class EntregaMaterialService {
    @Autowired
    private EntregaMaterialRepository entregaMaterialRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;


    public List<EntregaMaterial> buscarPorUsuario(Long idUsuario) {
        return entregaMaterialRepository.findByIdUsuario(idUsuario);
    }

    public void salvar(EntregaMaterial entrega) {
        entregaMaterialRepository.save(entrega);
    }

    public String validaEntrega(EntregaMaterial entregaMaterial){
        LocalDate hoje = LocalDate.now();
        if(usuarioRepository.findById(entregaMaterial.getIdUsuario()).isEmpty()){
            return "Usuário não encontrado";
        }
        if(entregaMaterial.getDataEntrega().isAfter(hoje)){
            return "A data de entrega não pode ser posterior ao dia de hoje";
        }

        return "ok";
    }
}
