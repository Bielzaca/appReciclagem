package br.AppReciclagem.appReciclagem.service;

import br.AppReciclagem.appReciclagem.model.MaterialReciclavel;
import br.AppReciclagem.appReciclagem.model.TrocaCesta;
import br.AppReciclagem.appReciclagem.repository.TrocaCestaRepository;
import br.AppReciclagem.appReciclagem.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Service
public class TrocaCestaService {
    @Autowired
    private TrocaCestaRepository trocaCestaRepository;
    @Autowired
    UsuarioRepository usuarioRepository;


    public List<TrocaCesta> buscarTodos(){


        return trocaCestaRepository.findAll();
    }

    public List<TrocaCesta> buscarPorUsuario(Long idUsuario) {
        return trocaCestaRepository.findByIdUsuario(idUsuario);
    }



    public void salvar(TrocaCesta troca) {
        trocaCestaRepository.save(troca);
    }

    public String validaTroca(TrocaCesta troca){
        LocalDate hoje = LocalDate.now();
        if(troca.getDataTroca().isAfter(hoje)){
            return "A data da troca não pode ser posterior ao dia de hoje";
        }
        if(usuarioRepository.findById(troca.getIdUsuario()).isEmpty()){
            return "Usuário não encontrado";
        }
        try{
            trocaCestaRepository.save(troca);

        }catch(Exception e){
            Throwable causa = e;
            while (causa != null) {
                if (causa instanceof SQLException) {
                    String mensagemErro = causa.getMessage();

                    return mensagemErro;

                }
                causa = causa.getCause();
            }



        }
        return "ok";
    }
}
