package br.AppReciclagem.appReciclagem.repository;

import br.AppReciclagem.appReciclagem.model.TrocaCesta;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TrocaCestaRepository extends JpaRepository<TrocaCesta, Long> {
    List<TrocaCesta> findByIdUsuario(Long idUsuario);


}
